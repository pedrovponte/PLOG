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


