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

short(Flight) :-
    flight(Flight, _, _, _, Duration, Company),
    Duration < 90.
	
shorter(Flight1, Flight2, Flight1) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2.

shorter(Flight1, Flight2, Flight2) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration2 < Duration1.
	
arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, DepartureTime, Duration, _),
    DepMinutes is DepartureTime mod 100,
    TotMinutes is DepMinutes + Duration,
    Minutes is TotMinutes mod 60,
    Hours is TotMinutes // 60,
    ArrivalTime is DepartureTime + Hours * 100 - DepMinutes + Minutes.
	
	
opera(Company, Country) :-
    flight(_, Id, _, _, _, Company),
    airport(_, Id, Country).

opera(Company, Country) :-
    flight(_, _, Id, _, _, Company),
    airport(_, Id, Country).

countries(Company, ListOfCountries) :-
    airport(_, _, Country),
    opera(Company, Country),
    append(Country, ListOfCountries, ListOfCountries).
	
	
pairableFlights :-
    flight(Id1, Origin, Destination, DepartureTime, Duration, _),
    flight(Id2, Destination, Destination2, DepartureTime2, Duration2, _),
    arrivalTime(Id1, T1),
    Diff is abs(DepartureTime2 - T1),
	DiffHours is Diff // 100,
	DiffMinutes is Diff mod 100,
	DiffTime is DiffHours * 60 + DiffMinutes,
    DiffTime >= 30,
    DiffTime =< 90,
    write(Destination), write(' - '), write(Id1), write(' \\ '), write(Id2), nl,
    fail.
	
:- use_module(library(lists)).

avgFlightLenghtFromAirport(Airport, AvgLenght) :-
    findall(Duration, flight(_, Airport, _, _, Duration, _), Durations),
    length(Durations, N),
    sumlist(Durations, Total),
    AvgLenght is Total / N.
	
	
dif_max_2(X,Y) :- X < Y, X >= Y - 2.
	
	
make_pairs(L, P, [X-Y|Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G.

make_pairs(L, P, [X-Y|Zs]) :-
    select(_X, L, L2),
    select(Y, L2, L3),
    make_pairs(L3, P, Zs).