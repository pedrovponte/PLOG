**1.** Se B e C forem provados, então vai-se tentar provar D e E.
Se D e E forem verdade, então vai retornar *yes*. Se um deles falhar, então vai tentar fazer backtracking, mas encontra o cut e para, retornando *no*.
Caso B ou C sejam falsos, então faz-se backtracking e tenta provar-se a segunda cláusula, retornando *yes* caso tanto F como G sejam verdade, retornando *no* caso algum falhe.
Esta cláusula pode ser vista como uma estrutura *if then else*.

```
ite(I,T,E):-I,!,T.
ite(I,T,E):-E.

------

if(B & C) {
    return D & E;
}
else {
    return F & G;
}
```

Desta forma, ou é executado (D,E) ou (F,G) e nunca os 2.

----

**2.** 

**a)** X=1, X=2, não há mais resultados devido ao cut

**b)** X=1 e Y=1, X=1 e Y=2, X=2 e Y=1, X=2 e Y=2. Nunca vai atingir o p(3) devido ao cut.

**c)** X=1 e Y=1, X=1 e Y=2. O primeiro resultado nunca vai ser 2 devido ao cut.

----

**3.**

**a)** 

```
um
dois
tres
ultima_clausula
no
```

**b)** 

```
um
no
```

**c)** 

```
um-um
um-dois
um-tres
no
```

Isto acontece porque após passar o cut, já não volta para trás, pelo que o X será sempre 1.

----

**4.**

**a)** No caso de X e Y serem iguais e X e Y forem maiores do que Z, o programa irá retornar Z como sendo o maior dos números.

**b)** 

```pl
max(X, Y, Z, X) :- X >= Y, X >= Z, !.
max(X, Y, Z, Y) :- Y >= Z, !.
max(_, _, Z, Z).
```

**5.** 

```
unificavel([], _, []).

unificavel([T | Resto], T1, Resto1):-
    T \= T1,
    unificavel(Resto, T1, Resto1).

unificavel([T | Resto], T1, [T | Resto1]):-
    unificavel(Resto, T1, Resto1).
```

**6.** O cut em imaturo é um cut vermelho, pois altera as soluções obtidas. Neste caso, funciona como um Not, pois se X for adulto, então (!, fail) não é imaturo, caso contrário é imaturo.
O cut em adulto é um cut verde, pois só lá está para haver melhor eficiência no programa. Este cut evita explorar espaços de persquisa em que é impossível estar a resposta. Se X for uma pessoa, então só será adulto se tiver idade igual ou superior a 18. Caso tenha, retorna *yes*, caso contrário *no*, e não vai ter de explorar se é uma tartaruga, etc. Só vai verificar se é tartaruga, etc, caso não seja pessoa.
