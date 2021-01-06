:-use_module(library(clpfd)).

carteiro(N) :-
    length(Houses, N),
    domain(Houses, 1, N),
    element(N, Houses, 6),
    all_distinct(Houses),
    times(Houses, Time),
    labeling([maximize(Time)], Houses),
    write('Houses: '), write(Houses),nl,
    write('Time: '), write(Time).

times([_], 0).

times([A, B | T], Time) :-
    Time #= Time2 + abs(B - A),
    times([B | T], Time2).

task(1, 2, 1, 1).
task(2, 5, 4, 3).
task(3, 1, -11, -10).

make_plan(0, []).

make_plan(N, [_ | Rest]) :-
    N1 is N - 1,
    make_plan(N1, Rest).

evaluate_plan([], Du1, Pa1, Pe1, Du1, Pa1, Pe1).

evaluate_plan([Id | T], Du1, Pa1, Pe1, Du2, Pa2, Pe2) :-
    task(Id, DuD, PaD, PeD),
    Du is Du1 + DuD,
    Pa is Pa1 + PaD,
    Pe is Pe1 + PeD,
    evaluate_plan(T, Du, Pa, Pe, Du2, Pa2, Pe2).

make_cost(_, [],[]).

make_cost(Sum, [Id | T], [S | TC]) :-
    task(Id, _, PaD, _),
    S is Sum + PaD,
    make_cost(S, T, TC).

planeamento(N, P) :-
    make_plan(N, P),
    domain(P, 1, 4),
    evaluate_plan(P, 0, 0, 0, Du, Pa, Pe),
    Du #< 10, Pa #< 10, Pe #>= 5, Pe #=< 6,
    make_cost(0, P, Cost), 
    minimize(labeling([], Plan), Cost).

tarefas:-
    Joao  = [ 49, 72, 43, 31],
    Maria = [ 45, 78, 36, 29],
    
    
    length(Tarefas, 4),
    domain(Tarefas, 1, 4),
    all_distinct(Tarefas),
    
    element(1, Tarefas, J1),
    element(J1, Joao, J1T),
    element(2, Tarefas, J2),
    element(J2, Joao, J2T),
    
    element(3, Tarefas, M1),
    element(M1, Maria, M1T),
    element(4, Tarefas, M2),
    element(M2, Maria, M2T),
    
    
    T #= J1T + J2T + M1T + M2T,
    labeling([minimize(T)], Tarefas), 
    write(Tarefas), 
    nl, 
    write(T).