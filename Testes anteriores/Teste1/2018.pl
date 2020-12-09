%airport(Name, ICAO, Country).
airport('Aeroporto Francisco Sa Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suarez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aeroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internacional di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Country).
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Societe Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% 1----------------------------------------------------

short(Flight) :-
    flight(Flight, _, _, _, Duration, Company),
    Duration < 90.
	
% 2----------------------------------------------------------------------
	
shorter(Flight1, Flight2, Flight1) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2.

shorter(Flight1, Flight2, Flight2) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration2 < Duration1.
	
% 3------------------------------------------------------------------------
	
arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, DepartureTime, Duration, _),
    DepMinutes is DepartureTime mod 100,
    TotMinutes is DepMinutes + Duration,
    Minutes is TotMinutes mod 60,
    Hours is TotMinutes // 60,
    ArrivalTime is DepartureTime + Hours * 100 - DepMinutes + Minutes.
	
% 4-------------------------------------------------------------------------
	
opera(Company, Country) :-
	flight(_, Origin, Destiny, _, _, Company),
	(airport(_, Origin, Country); airport(_, Destiny, Country)).
	
countries(Company, ListOfCountries) :-
	countriesAux(Company, [], ListOfCountries).
	
countriesAux(Company, AccListOfCountries, ListOfCountries) :-
	opera(Company, Country),
	\+ member(Country, AccListOfCountries),
	append(AccListOfCountries, [Country], NewAccListOfCountries),
	countriesAux(Company, NewAccListOfCountries, ListOfCountries),!.
	
countriesAux(_, ListOfCountries, ListOfCountries).
	
% 5--------------------------------------------------------------------------
	
pairableFlights :-
    flight(Id1, _, Destination, _, _, _),
    flight(Id2, Destination, _, DepartureTime2, _, _),
    arrivalTime(Id1, T1),
	ArrivalTimeMinutes is (T1 // 100) * 60 + (T1 mod 100),
	FinalHourMinutes  is (DepartureTime2 // 100) * 60 + (DepartureTime2 mod 100),
	DiffTime is FinalHourMinutes - ArrivalTimeMinutes,
    DiffTime >= 30,
    DiffTime =< 90,
    write(Destination), write(' - '), write(Id1), write(' \\ '), write(Id2), nl,
    fail.

pairableFlights.

% 6----------------------------------------------------------------------------

new_pairable(InitialTime, TempoPartida, 0) :-
	InitialTimeMinutes is (InitialTime // 100) * 60 + (InitialTime mod 100),
	TempoPartidaMinutes is (TempoPartida // 100) * 60 + (TempoPartida mod 100),
	Difference is TempoPartidaMinutes - InitialTimeMinutes,
	Difference >= 30, !.
	
new_pairable(InitialTime, TempoPartida, 1) :-
	InitialTimeMinutes is (InitialTime // 100) * 60 + (InitialTime mod 100),
	TempoPartidaMinutes is (TempoPartida // 100) * 60 + (TempoPartida mod 100),
	Difference is TempoPartidaMinutes - InitialTimeMinutes,
	Difference < 0.

tripDays([_], _, [], 1).

tripDays([Origem, Destino | Trip], Time, [TempoPartida | FlightTimes], Days) :-
		airport(_, ICAO1, Origem),
		airport(_, ICAO2, Destino),
		flight(Designation, ICAO1, ICAO2, TempoPartida, _, _),
		new_pairable(Time, TempoPartida, DaysWasted),
		arrivalTime(Designation, ArrivalTime),
		tripDays([Destino | Trip], ArrivalTime, FlightTimes, PreviouDays),
		Days is PreviouDays + DaysWasted.

% 7-------------------------------------------------------------------------------
	
:- use_module(library(lists)).

avgFlightLenghtFromAirport(Airport, AvgLenght) :-
    findall(Duration, flight(_, Airport, _, _, Duration, _), Durations),
    length(Durations, N),
    sumlist(Durations, Total),
    AvgLenght is Total / N.
	
	
% 8--------------------------------------------------------------------------------

mostInternational(ListOfCompanies) :-
	setof(
		Count,
		(
			company(C, _, _, _),
			countries(Company, Countries),
			length(Countries, Count)
		),
		Counts
	),
	reverse(Counts, [MaxCount | _]),
	findall(
		Company,
		(
			company(C, _, _, _),
			countries(Company, Countries),
			length(Countries, MaxCount)
		),
		ListOfCompanies
	), !.
	
% 9---------------------------------------------------------------------------------
	
dif_max_2(X,Y) :- X < Y, X >= Y - 2.
	
	
make_pairs(L, P, [X-Y|Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
	make_pairs(L3, P, Zs).

make_pairs([], _, []).