dados(um).
dados(dois).
dados(tres). 

cut_teste_c(X,Y) :-
    dados(X),
    !,
    dados(Y).

cut_teste_c('ultima_clausula').


max(X, Y, Z, X) :- X >= Y, X >= Z, !.
max(X, Y, Z, Y) :- Y >= Z, !.
max(_, _, Z, Z).