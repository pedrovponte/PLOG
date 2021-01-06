:- use_module(library(lists)).
:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ex1

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 > X3; X1 > X2, X2 < X3),
    test([X2,X3|Xs]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ex3

p3(L1,L2) :-
    length(L1,N),
    length(L2,N),
    pos(L1,L2,Is),
    all_distinct(Is),
    test2(L2),
    labeling([],Is).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).

test2([_,_]).
test2([X1,X2,X3|Xs]) :-
    (X1 #< X2, X2 #> X3; X1 #> X2, X2 #< X3),
    test2([X2,X3|Xs]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ex4

receitas(NOvos, TempoMax, OvosPorReceita, TempoPorReceita, OvosUsados, Receitas) :-
    length(Receitas, 4),

    length(OvosPorReceita, N),
    domain(Receitas, 1, N),
    
    all_distinct(Receitas),
    checkSum(Receitas, OvosPorReceita, OvosUsados),
    checkSum(Receitas, TempoPorReceita, TempoTotal),
    OvosUsados #=< NOvos,
    TempoTotal #=< TempoMax,
    labeling([maximize(OvosUsados)], Receitas).
    
checkSum([], _, 0).
    
checkSum([Id | T], OvosPorReceita, TotalOvos) :-
    checkSum(T, OvosPorReceita, SumOvosUsados),
    element(Id, OvosPorReceita, Ovos),
    TotalOvos #= SumOvosUsados + Ovos.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ex5

wrap(Presents, PaperRolls, SelectedPaperRolls) :-
    length(Presents, NumberPresents),
    length(SelectedPaperRolls, NumberPresents),
    length(PaperRolls, NumberPaperRolls),
    domain(SelectedPaperRolls, 1, NumberPaperRolls),

    getTasks(Presents, SelectedPaperRolls, Tasks),
    getMachines(PaperRolls, Machines, 1),
    cumulatives(Tasks, Machines, [bound(upper)]),
    /* 
    Verifica para todas as Tasks se Fim = Início + Duração.
    Verifica se para todas as tasks com o mesmo Id de máquina (neste caso com o mesmo RoloSelecionado)
    a máquina com esse Id (neste caso o Rolo) cumpre o limite imposto.
    O limite pode ser upper ou lower, no caso de ser upper significa que a máquina tem limite suficiente para todas,
    no caso de ser lower significa que as tasks utilizam mais do que a máquina tem.
    */
    labeling([], SelectedPaperRolls).


getTasks([], [], []).

getTasks([P | Presents], [S | SelectedPaperRolls], [T | Tasks]) :-
    T = task(0, P, P, P, S), % task define-se através de task(Início, Duração, Fim, Consumo, Id Máquina)
    getTasks(Presents, SelectedPaperRolls, Tasks).

getMachines([], [], _).

getMachines([P | PaperRolls], [M | Machines], Id) :-
    M = machine(Id, P), % Machine define-se através de machine(Id Máquina, Limite recurso)
    Id1 is Id + 1,
    getMachines(PaperRolls, Machines, Id1).