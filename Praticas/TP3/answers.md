**1.**
**a)** yes
**b)** no
**c)** H = apple, T = [broccoli, refrigerator]
**d)** H = a, T = [b, c, d, e]
**e)** H = apples, T = [bananas]
**f)** H = a, T = [[b, c, d]]
**g)** H = apples, T = []
**h)** no
**i)** One = apple, Two = sprouts, T = [fridge, milk]
**j)** X = a, Z = Y | T
**k)** H = apple, T = [_01], Z = _01
**l)** yes

**5.**
**a)** member_(X, [X | _]).
       member_(X, [Y | L]) :-
       X \= Y,
       member_(X, L).
Outra solução: membro(X, L) :- append(_L1, [X | _L2], L).

**b)** member_append(X, L) :- append(_, [X | _], [ _, L]).

**c)** member_last(X, L) :- append(_, [X], L).

**d)** nth_member(1, [M | _], M).
nth_member(N, [_ | T], M) :- 
    N > 1
    N1 is N-1
    nth_member(N1, T, M).
