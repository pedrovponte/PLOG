**5.**

```
initial(0-0).
final(2-_Y).

% empty bucket1
ligado(e1, _X-Y, 0-Y).

% empty bucket2
ligado(e2, X-_Y, X-0).

% fill bucket1
ligado(f1, _X-Y, 4-Y).

% fill bucket2
ligado(f2, X-_Y, X-3).

% Move from bucket1 to bucket2
ligado(m12, X-Y, X1-Y1) :-
    X > 0,
    Y < 3,
    Diff is 3-Y,
    T is min(X, Diff),
    X1 is X-T,
    Y1 is Y+T.

% Move from bucket2 to bucket1
ligado(m21, X-Y, X1-Y1) :-
    X < 4,
    Y > 0,
    Diff is 4-X,
    T is min(Y, Diff),
    X1 is X+T,
    Y1 is X-T.

path(End, End, Path, Path, []).
path(Start, End, Temp, Path) :-
    next(Start, Mid, Op),
    \+ member(Mid, Temp),
    append(Temp, [Mid], TempAppended),
    path(Mid, End, TempAppended, Path, Rest).

b :- initial(Ini), final(Final), path(Ini, Final, [Ini], Path), print(Path).

minB:- 
    initial(Ini), final(Final), 
    setof(Len-Path, ( path(Ini, Final, [Ini], Path), length(Path, Len)  ), L),
    L = [ MinLen-MinPath | _ ], printa(MinPath).

```

