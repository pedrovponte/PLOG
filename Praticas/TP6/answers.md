## Meta-Programação e Meta-Interpretadores

**1.**

```pl
f(X,Y) :-
	Y is X * X.

duplica(X,Y) :-
	Y is 2 * X.

map1([], _, []).

map1([H|T], TermFunctor, [TH|TT]) :-
 	Term = ..[TermFunctor, H, TH],
	Term,
	map1(T, TermFunctor, TT).
```

----

**2.**

```
separa(L,TermFunctor,Res) :- 
    sepDL(L,TermFunctor,Res-Nots,Nots-[]).

sepDL([],_,P-P,N-N).%caso base, a lista ja foi toda processada


/*Se o predicado ficou verdadeiro adiciona à cabeça do resultado o elemento*/
sepDL([H|T],TermFunctor,[H|T1]-DY,N) :- 
    Term =..[TermFunctor, H],
    Term,
    !, 
    sepDL(T,TermFunctor,T1-DY,N). %tornou o predicado verdadeiro vai continuar   

/*Se o predicado ficou falso adiciona à cabeça do nots o elemento*/
sepDL([H|T],TermFunctor,Y,[H|N]-DN) :- %caso de nao tornar o predicado verdadeiro  
    sepDL(T,TermFunctor,Y,N-DN). 
```

----

**3.**

```pl
mais_proximos(I,[N1|Prox]) :-
	setof(Dif-Nome,prox(I,Dif,Nome),[D1-N1|L]),
	primeiros(D1,L,Prox).

prox(I,Dif,Nome) :- idade(Nome,Id), dif(I,Id,Dif).

dif(A,B,D) :- A > B, !, D is A - B.
dif(A,B,D) :- D is B - A.

primeiros(_,[],[]).
primeiros(D1,[D-_|_],[]) :- D > D1, !.
primeiros(D1,[_-N|L],[N|NL]) :- primeiros(D1,L,NL).
```
 
----

**4**

**a)**

```
func2(Term, F, N) :-
	lenght(X, N),
	Term=..[F | X].
```

**4b)**

```
arg2(N, Term, Arg) :-
	Term=..[_ | X],
	nth1(N, X, Arg).
```

----

## Operações e Aritmética

**1**

**a)** ae(na(a,b),c)
**b)** Erro
**c)** ad(a, na(b,c))
**d)** Erro - na é não associativo, logo não podemos ter um na filho de outro na
**e)** ad(a, ad(b,c))
**f)** ae(ae(a,b), c)
**g)** ad(a, ad(b, ae(ae(na(c,d),e),f)))

----

**2.**

a)

:- op(500, fx, entao).
:- op(400, xfx, se).
:- op(400, xfx, senao).

b)

:- op(600, xfx, gostaria_de).
:- op(800, xfx, se).
:- op(400, xfx, fosse).
:- op(500, xfy, e).

----

**3.**

**a)**

```
 	    \\
        /          \
     //              :
  /      \        /     \
Voo     para     Dia     :
       /     \         /   \
      de    Dest    Hora   min
     /  \
 Número Orig
```

**b)**

```
	             :
		/	   \
	  para	            :
       / \ 	       /	  \
      de  C      para        para
      /\         /  \        /  \
     1  A       de   C      de   B
	            /\          /\
		   2  B        3  A
```

----

**4.**

:- op(200, xfx, existe_em).

X existe_em [X|_].
X existe_em [_|L].
X existe_em L.

:- op(200,fx, concatena).
:- op(150, xfx, da).
:- op(100, xfx, e).

concatena [] e L da L.
concatena [X|L1] e L2 da [X|L3] :-
concatena L1 e L2 da L3.

:- op(200, fx, apaga).
:- op(100, xfx, a).

apaga X a [X|L] da L.
apaga X a [Y|L] da [Y|L1] :-
apaga X a L da L1.

**5.**

**a)**

```
	      joga
	   /	    \
	marcelo       e
	             /  \
		futebol  squash
```

joga(marcelo, [futebol e squash])

**b)**

```
	       joga
	     /	     \
	renata         e
	            /     \
		tenis       e
			  /    \
	         basquete    volei
```

joga(renata, [tenis, basquete, volei])

----

**6.**

:- op(300,xfy,era).
:- op(200,xfx,do).

**7.**

**a)** A = 1 + 0

**b)** X = 0
	   X1 = 1 + 0
	   X1 + 1 = 1 + 0 + 1
	   B = 1 + 1 + 0

**c)** X = 1 + 0 + 1 + 1 + 1 = X1 + 1 = X2 + 1 + 1 -> 1 + X2 + 1 -> 1 + 1 + X1 -> 1 + 1 + 1 + 1 + 0
	   X1 = 1 + 0 + 1 + 1
	   X2 = 1 + 0 + 1 -> 1 + 1 + 0
	   C = 1 + 1 + 1 + 1 + 0

**d)** X = 1 + 1 + 1 + 0
	   D = fail

----

**8.**
