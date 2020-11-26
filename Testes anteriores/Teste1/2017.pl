%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

:-dynamic played/4.

%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).


% 1-----------------------------------------------

achievedALot(Player) :-
	played(Player, _, _, PercentUnlocked),
	PercentUnlocked >= 80.
	
% 2-----------------------------------------------

isAgeAppropriate(Name, Game) :-
	player(Name, _, Age),
	game(Game, _, MinAge),
	Age >= MinAge.
	
% 3-----------------------------------------------

timePlayingGames(Player, Games, ListOfTimes, SumTimes) :-
	timePlayingGames(Player, Games, [], ListOfTimes, 0, SumTimes).
	
timePlayingGames(_, [], ListOfTimes, ListOfTimes, SumTimes, SumTimes).
	
timePlayingGames(Player, [H|T], AccListOfTimes, ListOfTimes, AccSumTimes, SumTimes) :-
	(
		played(Player, H, HoursPlayed, _);
		HoursPlayed = 0
	),
	append(AccListOfTimes, [HoursPlayed], AccListOfTimes1),
	AccSumTimes1 is AccSumTimes + HoursPlayed,
	timePlayingGames(Player, T, AccListOfTimes1, ListOfTimes, AccSumTimes1, SumTimes).
	
% 4------------------------------------------------

listGamesOfCategory(Cat) :-
	game(Title, Categories, MinAge),
	member(Cat, Categories),
	write(Title), write(' ('), write(MinAge), write(')'), nl,
	fail.

listGamesOfCategory(_).

% 5------------------------------------------------

updatePlayer(Player, Game, Hours, Percentage) :-
	retract(played(Player, Game, InitialHours, InitialPercentage)), !,
	NewHours is InitialHours + Hours,
	NewPercentage is InitialPercentage + Percentage,
	assert(played(Player, Game, NewHours, NewPercentage)).
	
updatePlayer(Player, Game, Hours, Percentage) :-
	assert(played(Player, Game, Hours, Percentage)).
	
% 6-------------------------------------------------

fewHours(Player, Games) :-
	fewHours(Player, [], Games).

fewHours(Player, GamesAux, Games) :-
	played(Player, Game, Hours, _),
	Hours < 10,
	\+ (member(Game, GamesAux)), !,
	append(GamesAux, [Game], NewGamesAux),
	fewHours(Player, NewGamesAux, Games).
	
fewHours(_, Games, Games).

% 7-------------------------------------------------

ageRange(MinAge, MaxAge, Players) :-
	findall(PlayerName, (player(PlayerName, _, Age), Age >= MinAge, Age =< MaxAge), Players).
	
% 8-------------------------------------------------

sumlist([H|T], AccSum, Sum) :-
	NewAccSum is AccSum + H,
	sumlist(T, NewAccSum, Sum).
	
sumlist([], Sum, Sum).

averageAge(Game, AverageAge) :-
	findall(PlayerAge, (played(Player, Game, _, _), player(_, Player, PlayerAge)), Ages),
	sumlist(Ages, 0, Sum),
	length(Ages, L),
	AverageAge is Sum / L.
	
% 9--------------------------------------------------

:-use_module(library(lists)).

mostEffectivePlayers(Game, Players) :-
	findall(
		Efficiency-Player,
		(
			played(Player, Game, Hours, Percentage),
			Efficiency is Percentage / Hours
		),
		PlayersEfficiency
	),
	sort(PlayersEfficiency, Sorted),
	reverse(Sorted, Reversed),
	getMostEffective(Reversed, Players),!.
	
getMostEffective([BestEfficiency-BestPlayer | Rest], Players) :-
	getMostEffective(Rest, BestEfficiency, [BestPlayer], Players).
	
getMostEffective([Player | Rest], BestEfficiency, BestList, Players) :-
	Player = BestEfficiency-P,
	append(BestList, [P], NewBestList),
	getMostEffective(Rest, BestEfficiency, NewBestList, Players).
	
getMostEffective(_, _, Players, Players).

% 10---------------------------------------------------

whatDoesItDo(X) :-
	player(Y, X, Z),
	\+ (played(X, G, L, M),
	game(G, N, W),
	W > Z).

	