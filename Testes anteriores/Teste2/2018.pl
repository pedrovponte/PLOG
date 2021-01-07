:- use_module(library(lists)).
:- use_module(library(clpfd)).

check([_],[]).

check([A,B|R], [X|Xs]) :-
    A+B #= X,
    check([B|R], Xs).

prog2(N,M,L1,L2) :-
    length(L1,N),
    N1 is N-1,
    length(L2,N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
    all_distinct(L1),
    check(L1, L2),
    labeling([], L1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, Men),
    length(WomenHeights, Women),
    Men =:= Women,
    length(Pairs, Men),
    length(Pair, Men), % List of all mans and cotains the indice of the woman
    domain(Pair, 1, Men),
    all_distinct(Pair),
    setHeight(MenHeights, WomenHeights, Delta, Pair, 1),
    labeling([], Pair),
    prepare(Pair, Pairs, 1).

setHeight(_, _, _, [], _).

setHeight(MenHeights, WomenHeights, Delta, [PH | PT], Current) :-
    nth1(Current, MenHeights, MenHeight),
    nth1(X, WomenHeights, WomenHeight), % Tries any womenHeight for the current menHeight
    MenHeight >= WomenHeight,
    Delta >= MenHeight - WomenHeight,
    PH #= X, % If heights are compatible then the pair number is the number of the women
    Next is Current + 1,
    setHeight(MenHeights, WomenHeights, Delta, PT, Next).

prepare([],[],_).

prepare([PH | PT], [PSH | PST], Current) :-
    PSH = Current-PH,
    Next is Current + 1,
    prepare(PT, PST, Next).