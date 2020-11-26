**1.**

```pl
quad_mag:-
    Quad = [R11,R12,R13,R21,R22,R23,R31,R32,R33],
    domain(Quad,1,9),
    all_distinct(Quad),
    R11 + R12 + R13 #= S,
    R21 + R22 + R23 #= S,
    R31 + R32 + R33 #= S,
    R11 + R21 + R31 #= S,
    R21 + R22 + R23 #= S,
    R31 + R32 + R33 #= S,
    R11 + R22 + R33 #= S,
    R13 + R22 + R31 #= S,
    R11 #< R13, //evitar que se apresente soluções simétricas, ou seja, que a solução seja a mesma, mas que surja rodada 90º
    R11 #< R31,
    R13 #< R31,
    labeling([], Quad).
```

----

**7.**

```pl
perus :-
    A in 1..9,
    B in 0..9,
    PUP * 72 #= A * 1000 + 670 + B.
```
