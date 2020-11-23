append1([], Y, Y).
append1([X|Xs], Ys, [X|Z]) :- append1(Xs, Ys, Z).

inverter(Lista, InvLista) :-
       rev(Lista, [], InvLista).
rev([H|T], S, R) :-
       rev(T, [H|S], R).
rev([], R, R).

member_(X, [X | _]).
member_(X, [Y | L]) :-
       X \= Y,
       member_(X, L).
	   
member_append(X, L) :- append(_, [X | _], [ _, L]).

member_last(X, L) :- append(_, [X], L).

nth_member(1, [M | _], M).
nth_member(N, [_ | T], M) :-
    N > 1,
    N1 is N-1,
    nth_member(N1, T, M).
	
before_(L1, L2, L) :-
       append(_, [L1|X], L),
       append(_, [L2|_], X).
	   
conta(L, N) :-
       conta(L, N, 0).

conta([X|L1], N, Acc) :-
       Acc1 is Acc + 1,
       conta(L1, N, Acc1).

conta([], N, Acc) :-
       N is Acc.
	   
conta_elem(X, [X|L], N) :-
       conta_elem(X, L, N1),
	   N is N1 + 1.

conta_elem(X, [Y|L], N) :-
       conta_elem(X, L, N).

conta_elem(X, [], 0).

substitui(X, Y, [X|L1], [Y|L2]) :-
       substitui(X, Y, L1, L2).

substitui(X, Y, [Z|L1], [Z|L2]) :-
       substitui(X, Y, L1, L2).

substitui(X, Y, [], []).

ordenada([N]).
ordenada([N1, N2]) :-
       N1 =< N2.

ordenada([N1, N2 | Resto]) :-
       N1 =< N2,
       ordenada([N2|Resto]).
	   
ordena(L1, L2) :-
       insertion_sort(L1, L2, []).

insertion_sort(L1, L2, Acc) :-
       find_max(L1, max),
       delete_val(max, L1, New_L1),
       insertion_sort(New_L1, L2, [max | Acc]).
	   
insertion_sort([], L2, L2).

find_max([X|L1], Y) :-
       find_max(L1, K),
       max(X, K, Y).

find_max([X],X).

max(X, Y, Z) :-
       X =< Y,
       Z is Y.

max(X, Y, Z) :-
       X > Y,
       Z is X.

delete_val(X, L1, Res) :-
       append(L2, [X|L3], L1),
       append(L2, L3, Res).
	   
achata_lista([],[]).

achata_lista(X,[X]) :- atomic(X).

achata_lista([H|T], L) :-
       achata_lista(H, L1),
       achata_lista(T, L2),
       append(L1, L2, L).

lista_ate(N,[N|L]) :-
       N >= 1,
       N1 is N - 1,
       lista_ate(N1, L).

lista_ate(0, []).

lista_entre(N1,N2,[N2|L]) :-
       N2 >= N1,
       N3 is N2 - 1,
       lista_entre(N1,N3,L).
	   
lista_entre(N1,N1,[N1]).

soma_lista([X|L], Soma) :-
       soma_lista(L, Soma1),
       Soma is Soma1 + X.

soma_lista([], 0).


par(X) :-
       mod(X,2) =:= 0.
	   
lista_pares(N,[N|L]) :-
       N >= 0,
       mod(N,2) =:= 0,
       N1 is N - 1,
       lista_pares(N1, L).

lista_pares(N,L) :-
       N >= 0,
       mod(N,2) =:= 1,
       N1 is N - 1,
       lista_pares(N1,L).

lista_pares(0,[0]).

lista_impares(N,[N|L]) :-
       N >= 0,
       mod(N,2) =:= 1,
       N1 is N - 1,
       lista_impares(N1, L).

lista_impares(N,L) :-
       N >= 0,
       mod(N,2) =:= 0,
       N1 is N - 1,
       lista_impares(N1,L).

lista_impares(1,[1]).