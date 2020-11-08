## Meta-Programação e Meta-Interpretadores

**1)**

```
map([], _, []).

map([C | R], Transfor, [TC | CR]) :-
    aplica(Transfor, [C, TC]),
    map(R, Transfor, CR).

aplica(P, LArgs) :-
    G = ..[P | LArgs], G.

```

**4a)**

```
func(Term, F, N) :-
	lenght(X, N),
	Term=..[F | X].
```

**4b)**

```
arg2(N, Term, Arg) :-
	Term=..[_ | X],
	nth1(N, X, Arg).
```

## Operações e Aritmética

**1)**

**a)** ae(na(a,b),c)
**b)** Erro
**c)** ad(a, na(b,c))
**d)** Erro - na é não associativo, logo não podemos ter um na filho de outro na
**e)** ad(a, ad(b,c))
**f)** ae(ae(a,b), c)
**g)** ad(a, ad(b, ae(ae(na(c,d),e),f)))

**3)**

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

**5)**

**a)**

```
	      joga
	   /	    \
	marcelo       e
	             /  \
		futebol  squash
```

joga(marcelo, [futebol, squash])

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

**7)**