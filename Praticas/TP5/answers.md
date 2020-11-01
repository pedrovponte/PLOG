**1)** Com cut, se B e C forem verdadeiros, mas D e E forem falsos, vai falhar. Se B, C, D e E forem verdadeiros, vai passar. Se B e C forem verdadeiros, entao vai depender de F e G. O cut funciona como um if - then - else, neste caso if(B,C), then (D,E), else(F,G). 

```
ite(I,T,E):-I,!,T.
ite(I,T,E):-E.
```

Desta forma, ou é executado (D,E) ou (F,G) e nunca os 2.

**2a)** X=1, X=2, mas não há mais resultados devido ao cut

**2b)** X=1 e Y=1, X=1 e Y=2, X=2 e Y=1, X=2 e Y=2. Nunca vai atingir o p(3).

**2c)** X=1 e Y=1, X=1 e Y=2. O primeiro resultado nunca vai ser 2 devido ao cut.

**5)** 

```
unificavel([], X, []).

unificavel([T | Resto], T1, Resto1):-
    T \= T1,
    unificavel(Resto, T1, Resto1).

unificavel([T | Resto], T1, [T | Resto1]):-
    unificavel(Resto, T1, Resto1).
```

**6)** O cut em imaturo é um cut vermelho, pois altera as soluções obtidas. Neste caso, funciona como um Not, pois se X for adulto, então (!, fail) não é imaturo, caso contrário é imaturo.
O cut em adulto é um cut verde, pois só lá está para haver melhor eficiência no programa. Este cut evita explorar espaços de persquisa em que é impossível estar a resposta. Se X for uma pessoa, então só será adulto se tiver idade igual ou superior a 18. Caso tenha, retorna yes, caso contrário no, e não vai ter de explorar se é uma tartaruga, etc. Só vai verificar se é tartaruga, etc, caso não seja pessoa.