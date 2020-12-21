**2.**

```pl
houses(N):-
    length(Houses, N),   %ordem de visita às casas
    domain(Houses, 1, N),
    element(N, Houses, 6),
    all_distinct(Houses),
    times(Houses, Time),
    labeling( [maximize(Time) ], Houses), write(Houses).

times( [ _ ], 0).
times( [A, B | T ], Time):-
    Time #= Time2 + abs(B-A),
    times( [B | T], Time2).
```

**5.**

```pl
menosTempo:-
    Maria = [45,78,36,29],
    Joao = [49,72,43,31],
    Tarefas = [TM1,TM2, TJ1,TJ2],
    domain(Tarefas,1,4),
    all_distinct(Tarefas),
    element(TM1,Maria,X1),
    element(TM2,Maria,X2),
    element(TJ1,Joao,X3),
    element(TJ2,Joao,X4),
    Sum #= X1+X2+X3+X4,
    labeling([minimize[Sum]],Tarefas).
```

outra resolução:

```pl
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
    labeling([minimize(T)], 
    Tarefas), 
    write(Tarefas), 
    nl, 
    write(T).
```