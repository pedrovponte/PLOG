:- use_module(library(lists)).
:- use_module(library(clpfd)).

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),
    test([X2,X3|Xs]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p3(L1, L2) :-
    length(L1, N),
    length(L2, N),
    length(Is, N),
    domain(Is, 1, N),
    pos(L1, L2, Is),
    all_distinct(Is),
    test(L2),
    labeling([], Is).

pos([], _, []).

pos([X|Xs], L2, [I | Is]) :-
    nth1(I, L2, X),
    pos(Xs, L2, Is).

test2([_,_]).

test2([X1,X2,X3|Xs]) :-
    (X1 #< X2, X2 #< X3; X1 #> X2, X2 #> X3),
    test([X2,X3|Xs]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-
    length(Cookings, 3),
    length(RecipeEggs, N),
    domain(Cookings, 1, N),
    all_different(Cookings),
    checkSum(Cookings, RecipeEggs, Eggs),
    checkSum(Cookings, RecipeTimes, TotalTime),
    Eggs #=< NEggs,
    TotalTime #=< MaxTime,
    labeling([maximize(Eggs)], Cookings).

checkSum([], _, 0).

checkSum([C | T], RecipeEggs, TotalEggs) :-
    checkSum(T, RecipeEggs, TotalEggs1),
    element(C, RecipeEggs, Eggs),
    TotalEggs #= TotalEggs1 + Eggs.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cut(Shelves, Boards, SelectedBoards) :-
    length(Shelves, N),
    length(SelectedBoards, N),
    length(Boards, L),
    domain(SelectedBoards, 1, L),
    getTasks(Shelves, SelectedBoards, Tasks),
    getMachines(Boards, Machines, 1),
    cumulatives(Tasks, Machines, [bound(upper)]),
    labeling([], SelectedBoards).

getTasks([], [], []).

getTasks([S | Shelves], [Sel | SelectedBoards], [T | Tasks]) :-
    T = task(0, S, S, S, Sel),
    getTasks(Shelves, SelectedBoards, Tasks).

getMachines([], [], _).

getMachines([B | Boards], [M | Machines], Id) :-
    M = machine(Id, B),
    Id1 is Id + 1,
    getMachines(Boards, Machines, Id1).