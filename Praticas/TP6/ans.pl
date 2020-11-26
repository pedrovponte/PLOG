f(X,Y) :-
	Y is X * X.

duplica(X,Y) :-
	Y is 2 * X.

map1([], _, []).

map1([H|T], TermFunctor, [TH|TT]) :-
 	Term =..[TermFunctor, H, TH],
	Term,
	map1(T, TermFunctor, TT).
	
	
idade(maria,30).
idade(pedro,25).
idade(jose,25).
idade(rita,18).

mais_proximos(I,[N1|Prox]) :-
	setof(Dif-Nome,prox(I,Dif,Nome),[D1-N1|L]),
	primeiros(D1,L,Prox).

prox(I,Dif,Nome) :- idade(Nome,Id), dif(I,Id,Dif).

dif(A,B,D) :- A > B, !, D is A - B.
dif(A,B,D) :- D is B - A.

primeiros(_,[],[]).
primeiros(D1,[D-_|_],[]) :- D > D1, !.
primeiros(D1,[_-N|L],[N|NL]) :- primeiros(D1,L,NL).

func2(Term, F, N) :-
	length(X, N),
	Term=..[F | X].
	
t(0+1, 1+0).
t(X+0+1, X+1+0).
t(X+1+1, Z) :-
	t(X+1, X1),
	t(X1+1, Z).
