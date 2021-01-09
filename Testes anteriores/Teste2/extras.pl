:- use_module(library(lists)).
:- use_module(library(clpfd)).

build(Budget, NPacks, ObjectsCosts, ObjectsPacks, Objects, UsedPacks) :-
	length(Objects, 3),
	
	length(ObjectsPacks, N),
	domain(Objects, 1, N),
	
	all_distinct(Objects),
	checkSum(Objects, ObjectsPacks, UsedPacks),
	checkSum(Objects, ObjectsCosts, TotalCost),
	UsedPacks #=< NPacks,
	TotalCost #=< Budget,
	labeling([maximize(UsedPacks)],Objects).

checkSum([], _, 0).

checkSum([Id | Objects], ObjectsInfo, Total) :-
	checkSum(Objects, ObjectsInfo, SumTotal),
	element(Id, ObjectsInfo, ValueO),
	Total #= ValueO + SumTotal.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
wrap(Presents, PaperRolls, SelectedPaperRolls) :-
	length(Presents, NumberPresents),
	length(SelectedPaperRolls, NumberPresents),
	length(PaperRolls, PapersNumber),
	domain(SelectedPaperRolls, 1, PapersNumber),
	
	getTasks(Presents, SelectedPaperRolls, Tasks),
	getMachines(PaperRolls, Machines, 1),
	cumulatives(Tasks, Machines, [bound(upper)]),
	
	labeling([], SelectedPaperRolls).
	
getTasks([], [], []).
	
getTasks([P | Presents], [Sel | SelectedPaperRolls], [T | Tasks]) :-
	T = task(0, P, P, P, Sel),
	getTasks(Presents, SelectedPaperRolls, Tasks).
	
getMachines([], [], _).

getMachines([P | PaperRolls], [M | Machines], Id) :-
	M = machine(Id, P),
	Id1 is Id + 1,
	getMachines(PaperRolls, Machines, Id1).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
	length(MenHeights, Men),
	length(WomenHeights, Women),
	Men =:= Women,
	length(Pairs, Men),
	length(Pair, Men), % List of all mans and cotains the indice of the woman
	domain(Pair, 1, Men),
	all_distinct(Pair),
	setHeights(MenHeights, WomenHeights, Delta, Pair),
	labeling([], Pair),
	prepare(Pair, Pairs, 1).
	
setHeights([], _, _, []).
	
setHeights([MenHeight | MenHeights], WomenHeights, Delta, [PH | PT]) :-
	element(X, WomenHeights, WomenHeight),
	MenHeight #>= WomenHeight, 
	(0 #=< MenHeight - WomenHeight #/\ Delta #>= MenHeight - WomenHeight) #<=> B,
	PH #= B * X,
	setHeights(MenHeights, WomenHeights, Delta, PT).
	
	
prepare([], [], _).

prepare([PH | PT], [PSH | PST], Current) :-
	PSH = Current - PH,
	Current1 is Current + 1,
	prepare(PT, PST, Current1).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
	length(MenHeights, MenLen),
	length(WomenHeights, WomenLen),
	
	Comprimento = [MenLen, WomenLen],
	maximum(MaxLength, Comprimento),
	minimum(MinLength, Comprimento),
	
	length(MVars, MinLength),
	domain(MVars, 1, MaxLength),
	
	length(WVars, MinLength),
	domain(WVars, 1, MaxLength),
	
	all_distinct(MVars),
	all_distinct(WVars),
	
	make_pairs(MenHeights, WomenHeights, Delta, Refe, MVars, WVars),
	append(Refe, MVars, Vars1),
	append(Vars1, WVars, Vars2),
	sum(Refe, #=, Max),
	labeling([maximize(Max)], [Max | Vars2]),
	parse_values(Refe, MVars, WVars, Pairs).
	

make_pairs(_, _, _, [], [], []).	

make_pairs(MenHeights, WomenHeights, Delta, [R | Refe], [M | MVars], [W | WVars]) :-
	element(M, MenHeights, HeightM),
	element(W, WomenHeights, HeightW),
	((HeightM #>= HeightW) #/\ (HeightM	- HeightW #=< Delta)) #<=> R,
	make_pairs(MenHeights, WomenHeights, Delta, Refe, MVars, WVars).	
	
parse_values([], [], [], []).

parse_values([0 | Refe], [M | MVars], [W | WVars], Pairs) :-
	parse_values(Refe, MVars, WVars, Pairs).
	
parse_values([1 | Refe], [M | MVars], [W | WVars], [P | Pairs]) :-
	P = M - W,
	parse_values(Refe, MVars, WVars, Pairs).
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ups_and_downs(Min, Max, N, L) :-
	length(L, N),
	domain(L, Min, Max),
	check_conditions(L), !,
	labeling([], L).
	
check_conditions([_]).

check_conditions([L1, L2]) :-
	L1 #< L2 #\/ L1 #> L2.
	
check_conditions([L1, L2, L3 | T]) :-
	(L1 #< L2 #/\ L2 #> L3) #\/ (L1 #> L2 #/\ L3 #> L2),
	check_conditions([L2, L3 | T]).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% concelho(Nome, Distancia, NEleitoresIndecisos)
concelho(x,120,410).
concelho(y,10,800).
concelho(z,543,2387).
concelho(w,3,38).
concelho(k,234,376).

concelhos(NDias, MaxDist, ConcelhosVisitados, DistTotal, TotalEleitores) :-
	findall(Nome - Distancia - NEleitoresIndecisos, concelho(Nome, Distancia, NEleitoresIndecisos), Concelhos),
	length(Concelhos, NConcelhos),
	length(Visitas, NConcelhos),
	domain(Visitas, 0, 1),
	count(1, Visitas, #=<, NDias),
	eleitores_ganhos(Visitas, Concelhos, TotalEleitores),
	distancia_percorrida(Visitas, Concelhos, DistTotal),
	DistTotal #=< MaxDist,
	labeling([maximize(TotalEleitores)], Visitas),
	concelhos_visitados(Visitas, Concelhos, ConcelhosVisitados).
	
eleitores_ganhos([], [], 0).
	
eleitores_ganhos([V | Visitas], [_ - _ - NEleitoresIndecisos | Concelhos], TotalEleitores) :-
	eleitores_ganhos(Visitas, Concelhos, TotalEleitores1),
	TotalEleitores #= TotalEleitores1 + NEleitoresIndecisos * V.
	
distancia_percorrida([], [], 0).
	
distancia_percorrida([V | Visitas], [_ - Distancia - _ | Concelhos], DistanciaTotal) :-
	distancia_percorrida(Visitas, Concelhos, DistanciaTotal1),
	DistanciaTotal #= DistanciaTotal1 + Distancia * V.
	
concelhos_visitados([], [], []).

concelhos_visitados([0 | Visitas], [_ | Concelhos], ConcelhosVisitados) :-
	concelhos_visitados(Visitas, Concelhos, ConcelhosVisitados).
	
concelhos_visitados([1 | Visitas], [Nome - _ - _ | Concelhos], [Nome | ConcelhosVisitados]) :-
	concelhos_visitados(Visitas, Concelhos, ConcelhosVisitados).
	
	
	













	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	