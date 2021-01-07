:- use_module(library(clpfd)).
:- use_module(library(lists)).

% Exercicio 3

pres(N, K, Vars):-
	length(Vars, N),
	domain(Vars, 1, K),
	%
	indices(1, Vars),
	%
	labeling([], Vars).

indices(I, [V | Vs]):-
	V mod 2 #\= I mod 2,
	I1 is I + 1,
	indices(I1, Vs).

indices(_, []).

% Exercicio 7

prat(Prateleiras, Objetos, Vars) :-
	length(Objetos, N),
	length(Vars, N),
	length(Prateleiras, NP),
	nth1(1, Prateleiras, P),
	length(P, SP),
	NumPrateleiras is NP * SP,
	domain(Vars, 1, NumPrateleiras),
	getTasks(Objetos, Vars, Tasks),
	append(Prateleiras, Armario),
	getMachines(Armario, Machines, 1),
	cumulatives(Tasks, Machines, [bound(upper)]),
	length(Pesos, NumPrateleiras),
	getPesos(Objetos, Vars, Pesos, 1),
	setPesos(Pesos, NP, 1),
	labeling([], Vars).

getTasks([], [], []).

getTasks([_ - OVolume | Objetos], [V | Vars], [T | Tasks]) :-
	T = task(0, OVolume, OVolume, OVolume, V),
	getTasks(Objetos, Vars, Tasks).

getMachines([], [], _).

getMachines([P | Prateleiras], [M | Machines], Id) :-
	M = machine(Id, P),
	Id1 is Id + 1,
	getMachines(Prateleiras, Machines, Id1).

getPeso([], [], 0, _).

getPeso([O- _ | Objetos], [V | Vars], Peso, Current) :-
	(V #= Current) #<=> Bool,
	Peso #= Bool * O + Temp,
	getPeso(Objetos, Vars, Temp, Current).


getPesos(_, _, [], _).

getPesos(Objetos, Vars, [P | Pesos], Current) :-
	getPeso(Objetos, Vars, P, Current),
	Next is Current + 1,
	getPesos(Objetos, Vars, Pesos, Next).

setPesos(Pesos, Tamanho, Current) :-
	length(Pesos, N),
	Current is N - Tamanho + 1.

setPesos(Pesos, Tamanho, Current) :-
	Baixo is Current + Tamanho,
	element(Current, Pesos, PC),
	element(Baixo, Pesos, PB),
	PC #=< PB,
	Next is Current + 1,
	setPesos(Pesos, Tamanho, Next).

% Exercicio 9

objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 2, 15).
homens(4).
tempo_max(60).

furniture :-
	findall(Objeto-HomensNec-TempoNec, objeto(Objeto, HomensNec, TempoNec), Objetos),
	homens(TotalHomens),
	tempo_max(TempoMax),

	length(Objetos, N),
	length(StartTimes, N),
	length(EndTimes, N),
	
	domain(StartTimes, 0, TempoMax),
	domain(EndTimes, 0, TempoMax),
	
	getTasks(Objetos, StartTimes, EndTimes, Tasks),
	cumulative(Tasks, [limit(TotalHomens)]),
	
	append(StartTimes, EndTimes, Times),
	labeling([], Times),

	max_member(EndTime, EndTimes),
	min_member(StartTime, StartTimes),
	TotalTime is EndTime - StartTime,
	print('Total Time: '), print(TotalTime), nl,
	printResult(Objetos, StartTimes, EndTimes).

getTasks([], [], [], []).

getTasks([O - H - T | Objetos], [ST | StartingTimes], [ET | EndingTimes], [Task | Tasks]) :-
	Task = task(ST, T, ET, H, O),
	getTasks(Objetos, StartingTimes, EndingTimes, Tasks).

printResult([], [], []).

printResult([Objeto-HomensNec-TempoNec | Objetos], [ST | StartingTimes], [ET | EndingTimes]) :-
	print(Objeto), print(': '), print(ST), print('-'), print(ET), nl,
	printResult(Objetos, StartingTimes, EndingTimes).