### PLS

**1.**

----

**2.**

```pl
solve(Total) :-
    Total = [Joao, Antonio, Francisco, Harpa, Violino, Piano, Terça, Quinta, Quinta2],
    Pessoas = [Joao, Antonio, Francisco],
    Instrumentos = [Harpa, Violino, Piano],
    Ensaio = [Terça, Quinta, Quinta2],
    Antonio #\= Piano,
    Piano #= Terça,
    Joao #\= Quinta,
    Joao #\= Violino,
    Violino #= Quinta2,
    Joao #\= Piano,
    labelling([], Total),
    write('Result: ', Total).
```

**3.**

```pl
compras(Total) :-
    Total = [Adams, Baker, Catt, Dodge, Ennis, Fisk, Livro, Vestido, Bolsa, Gravata, Chapeu, Candeeiro, AndarTerreo, Segundo1, Segundo2, Terceiro, Quinto, Sexto],
    Pessoas = [Adams, Baker, Catt, Dodge, Ennis, Fisk],
    Compras = [Livro, Vestido, Bolsa, Gravata, Chapeu, Candeeiro],
    Andares = [AndarTerreo, Segundo1, Segundo2, Terceiro, Quinto, Sexto],
    domain(Total, 1, 6),
    all_different(Pessoas),
    all_different(Compras),
    all_different(Andares),
    Adams #= Livro,
    Livro #= AndarTerreo,
    Catt #= Segundo1,
    Gravata #= Segundo2,
    Terceiro #= Vestido,
    Candeeiro #= Quinto,
    Fisk #= Sexto,
    Segundo1 #= Bolsa,
    Baker #\= Bolsa,
    Baker #\= Gravata,
    Ennis #= Candeeiro,
    labeling([], Total),
    write("TOTAL: " + Total).
```

----

**4.**

**a)** Se não fosse segunda-feira, ele estaria a mentir ao fazer a afirmação, o que contraria a hipótese de ele só mentir às segundas. Assim,fica bem estabelecido que era segunda feira. Sendo este dia, ele mentiu ao afirmar: "hoje é segunda-feira e sou casado". Portanto, a proposição atómica "sou casado" é falsa.

**b)** "A quantidade de dias entre hoje e o proximo domingo e um fator primo de dez"

**c)** Isto não pode ter sido dito na segunda-feira. Quem disse isto falou a verdade, logo nao pode ter sido o Jal, já que às segundas ele só mente. Todavia, Tak também não podia falar assim, pois uma semana após é a próxima segunda feira e Tak não mente tanto na segunda como na terça-feira.
Não sendo segunda-feira, quem afirmou mentiu, pois o único dia anterior a terça-feira é segunda-feira. Logo, foi Tak que mentiu: era portanto 
quinta-feira.

**d)** "Amanhã é terça-feira" não pode ter sido dito na segunda-feira pelo Jal, pois o dia seguinte a segunda é terça-feira. Logo, se tivesse dito isso estaria a dizer a verdade no dia em que só mente. Deste modo, quem disse esta primeira frase foi o Tak.
Passada uma semana, o outro irmão, ou seja, o Jal, disse "Amanhã estarei mentindo". Ora, considerando que o Jal só mente à segunda, e uma semana antes o seu irmão tinha falado a verdade ao dizer que o dia seguinte era terça, então eram segundas feiras quando isto foi dito.

**e)** Os habitantes da ilha podem processar o(s) acusador(es) por danos morais... 
Com efeito, imagine-se que há uma pessoa "A" que mente num dia da semana.
Tome-se o seu "antipoda" "A'" que mente todos os dias em que "A" fala a verdade e fala a verdade no dia em que "A" mente. Para os dois juntos não
haverá um único dia em que ambos falarão a verdade e, portanto, haverá um
habitante "C" que mentirá todos os dias. Seja "C'" o antipoda de "C". Este
antipoda fala a verdade todos os dias, contrariando assim as más linguas.

----

**5.**

```pl

% 1 - azul
% 2 - amarelo
% 3 - verde
% 4 - preto

% semaforo <-------------------->
%          depois          antes

carros:-
    Cor = [ A, B, C, D ],    %posição = posição na fila; valor é cor
    Tam = [ E, F, G, H ],   %
    domain(Cor, 1, 4), domain(Tam, 1, 4), all_distinct(Cor), all_distinct(Tam),
    element(Index, Cor, 3), element(Index, Tam, 1),  % verde é menor
    
    element(I, Cor, 1), IndAntesAz #= I+1, IndDepoisAz #= I-1, % I é index do azul
    element(IndDepoisAz, Tam, TamDepois), element(IndAntesAz, Tam, TamAntes),
    TamAntes #< TamDepois, %imed antes azul menor imed dep azul
    
    Index #< I, %verde depois do azul
    element(Yellow, Cor, 2), element(Black, Cor, 4), Yellow #< Black, %amarelo dep. preto
    append(Cor, Tam, Vars),
    labeling([ ], Vars).

----------------------------------------------------------------------

carros :-
    Cor = [Amarelo, Verde, Azul, Preto], % posiçao = posiçao na fila
    Carros = [Primeiro, Segundo, Terceiro, Quarto],
    domain(Cor, 1, 4),
    domain(Carros, 1, 4),
    all_different(Cor),
    all_different(Carros),
    PosAnt #= Azul - 1,
    PosDep #= Azul + 1,
    nth1(AntesAzul, Carros, PosAnt),
    nth1(DepoisAzul, Carros, PosDep),
    AntesAzul #< DepoisAzul,
    Amarelo #> Preto,
    Verde #> Azul,
    Verde #= Primeiro,
    append(Cor, Carros, Total),
    labeling([], Total),
    write('FILA: '), write(Cor).
```

----

**6.**

Se eu perguntar qual é a porta certa ao seu colega, qual é que ele me indicará?

Note-se que obteremos sempre como resposta a porta errada.

• Se perguntarmos ao guarda sincero, ele irá dizer a porta errada pois sabe que o seu colega iria mentir.

• Se perguntarmos ao guarda mentiroso, ele irá dizer a porta errada, pois por si próprio, mentiria o que o seu colega iria dizer: a verdade.

----

**7.**

```pl
acampamento :-
    Amigos = [Joao, Miguel, Nadia, Silvia, Afonso, Cristina, Geraldo, Julio, Maria, Maximo, Manuel, Ivone],
    Bebidas = [Limonada, Guarana, Whisky, Vinho, Champanhe, Agua, Laranjada, Cafe, Cha, Vermouth, Cerveja, Vodka],
    domain(Amigos, 1, 12),
    domain(Bebidas, 1, 12),
    all_distinct(Amigos),
    all_distinct(Bebidas),
    all_distinct([Geraldo, Julio, Cerveja, Vodka, Vermouth, Cha, Maria, Maximo, Ivone, Manuel, Cafe, Laranjada]),
    all_distinct([Joao, Miguel, Cha, Cafe, Julio, Geraldo, Guarana, Whisky, Nadia, Maria, Laranjada, Limonada]),
    all_distinct([Geraldo, Maximo, Agua, Whisky, Joao, Silvia, Cha, Vodka]),
    all_distinct([Julio, Champanhe, Agua, Miguel, Guarana, Vodka, Maximo, Manuel, Cafe, Silvia, Afonso]),
    append(Amigos, Bebidas, Total),
    labeling([], Total),
    write('Amigos: '), write(Amigos), nl,
    write('Bebidas: '), write(Bebidas).
```

----

**8.**

```pl
restaurante :-
    Pessoas = [Bernard, Daniel, Francisco, Henrique, Jaqueline, Luis],
    Comida = [Peixe, Porco, Pato, Omeleta, Bife, Esparguete],
    domain(Pessoas, 1, 6),
    domain(Comida, 1, 6),
    all_distinct(Pessoas),
    all_different(Comida),
    Daniel #\= Peixe,
    Jaqueline #\= Peixe,
    Francisco #\= Porco,
    Francisco #\= Pato,
    all_distinct([Bernard, Daniel, Pato, Omeleta]),
    Bernard #= Porco #\/ Bernard #= Pato #\/ Bernard #= Bife,
    Francisco #= Porco #\/ Francisco #= Pato #\/ Francisco #= Bife,
    Henrique #= Porco #\/ Henrique #= Pato #\/ Henrique #= Bife,
    append(Pessoas, Comida, Total),
    labeling([], Total),
    write('Pessoas: '), write(Pessoas), nl,
    write('Comida: '), write(Comida).
```

----

**9.**

```pl
ciclismo :-
    Corredores = [Carlos, Ricardo, Raul, Tomas, Roberto, Boris, Diego, 
Luis],
    domain(Corredores, 1, 8),
    all_distinct(Corredores),
    Boris #\= 7,
    Tomas #=< 4,
    Tomas #\= 4,
    Raul #\= 4,
    Diego #\= 7,
    Boris #\= 7,
    Diego #\= 8,
    Boris #\= 8,
    Raul #\= 5,
    Carlos #= 1 #\/ Carlos #= 2,
    Luis #= 1 #\/ Luis #= 2,
    all_distinct([Luis, Ricardo, Boris, 7, 3, 1, 4, 5]),
    labeling([], Corredores),
    write('Corredores: '), write(Corredores).
```

----

**10.**

```pl
eleicoes :-
    Reunioes = [A, B, C, AB, AC, BC, X],
    domain(Reunioes, 1, 200),

    A + AB + AC + X #= 130,
    B + AB + BC + X #= 135,
    C + AC + BC + X #= 65,
    X #= 30,
    A + B + C + AB + AC + BC + X #= 200,
    labeling([], Reunioes),
    write('Reunioes: '), write(Reunioes).
```

----

**11.**

```pl
desporto :-
    Amigos = [Claudio, David, Domingos, Francisco, Marcelo, Paulo],
    Desportos = [Ping, Futebol, Andebol, Rugby, Tenis, Voleibol],
    domain(Amigos, 1, 6),
    domain(Desportos, 1, 6),
    all_distinct(Amigos),
    all_distinct(Desportos),
    Marcelo #\= Tenis,
    Francisco #\= Voleibol,
    Paulo #\= Voleibol,
    Domingos #\= Rugby,
    Claudio #\= Andebol,
    Claudio #\= Rugby,
    Francisco #\= Andebol,
    Francisco #\= Rugby,
    David #\= Futebol,
    Marcelo #= Futebol, 
    David #= Tenis,
    append(Amigos, Desportos, Total),
    labeling([], Total),
    write('Amigos: '), write(Amigos), nl,
    write('Desportos: '), write(Desportos).
```

----

**12.**

```pl
biblioteca :-
    Compartimentos = [ComumInglesHistoria, ComumInglesLiteratura, 
                    DuraInglesHistoria, DuraInglesLiteratura, 
                    ComumFrancesHistoria, ComumFrancesLiteratura, 
                    DuraFrancesHistoria, DuraFrancesLiteratura],
    domain(Compartimentos, 0, 1000),
    ComumInglesHistoria + DuraInglesHistoria + ComumFrancesHistoria + DuraFrancesHistoria #= 52,
    ComumInglesHistoria + DuraInglesHistoria #= 27,
    DuraInglesHistoria + DuraInglesLiteratura + DuraFrancesHistoria + DuraFrancesLiteratura #= 34,
    DuraFrancesHistoria #= 3,
    ComumInglesHistoria + ComumInglesLiteratura + DuraInglesHistoria + DuraInglesLiteratura #= 46,
    ComumInglesHistoria + ComumInglesLiteratura #= 23,
    ComumFrancesLiteratura + DuraFrancesLiteratura #= 20,
    ComumInglesLiteratura + ComumFrancesLiteratura #= 31,
    labeling([], Compartimentos),
    sumlist(Compartimentos, X),
    write('Compartimentos: '), write(X).
```

----

**13.**

```pl
automoveis :-
    Nacionalidades = [Alemao, Ingles, Brasileiro, Espanhol, Italiano, Francês],
    LaVie = [L1, L2],
    Sistema = [S1, S2],
    Fagor = [F1, F2],
    append([LaVie, Sistema, Fagor], Marcas),
    domain(Nacionalidades, 1, 6),
    all_distinct(Marcas),
    all_distinct(Nacionalidades),
    Alemao #= L1,
    Brasileiro #= S1,
    Espanhol #= F1,
    L2 #= 1,
    S2 #= 5,
    F2 #= 3,
    Espanhol #\= 2,
    Espanhol #\= 6,
    Italiano #\= 3,
    Frances #\= 3,
    Alemao #\= 2,
    Italiano #\= 1,
    append([Nacionalidades, Marcas], Total),
    labeling([], Total),
    write('Nacionalidades: '), write(Nacionalidades), nl,
    write('Marcas: '), write(Marcas).
```

**14.**

```pl

```

**15.**

```pl
entregas :-
    Nome = [Paula, Artur, Daniel, Ema],
    Sobrenome = [Mala, Postal, Bola, Famoso],
    Morada = [Espanha, Turquia, Primavera, Hungria, Sardenha],
    Encomenda = [Roupas, Catalogo, Plantas, Livro],
    domain(Nome, 1, 4),
    domain(Sobrenome, 1, 4),
    domain(Morada, 1, 4),
    domain(Encomenda, 1, 4),
    all_distinct(Nome),
    all_distinct(Sobrenome),
    all_distinct(Morada),
    all_distinct(Encomenda),
    Mala #= Roupas,
    Paula #= Postal, 
    Paula #\= Bola,
    Paula #\= Espanha,
    Bola #\= Espanha,
    Paula #\= Catalogo,
    Artur #\= Catalogo,
    Turquia #\= Plantas,
    Ema #= Primavera,
    Hungria #\= Bola,
    Hungria #= Livro,
    Plantas #\= Famoso,
    Famoso #= Sardenha,
    Famoso #\= Daniel,
    append(Nome, Sobrenome, Total1),
    append(Total1, Morada, Total2),
    append(Total2, Encomenda, Total),
    labeling([], Total),
    write('Nome: '), write(Nome), nl,
    write('Sobrenome: '), write(Sobrenome), nl,
    write('Morada: '), write(Morada), nl,
    write('Encomenda: '), write(Encomenda).
```

**16.**

```pl
produto :-
    Variaveis = [Interrogados, Liquido, Po, LiquidoPo, NaoUtiliza],
    domain(Variaveis, 0, 10000),
    Interrogadas #= Liquido + Po + LiquidoPo + NaoUtiliza,
    (1 * Interrogadas) / 3 #= Liquido + NaoUtiliza,
    (2 * Interrogadas) / 7 #= NaoUtiliza + Po,
    LiquidoPo #= 427,
    NaoUtiliza #= (1 * Interrogadas) / 5,
    labeling([], Variaveis),
    write('Variaveis: '), write(Variaveis).
```

**17.**

```pl
% 1 - azul
% 2 - amarelo
% 3 - verdes
% 4 - vermelhos

carros2 :-
    length(Carros, 12),
    global-cardinality(Carros, [2-4, 3-2, 4-3, 1-3]),
    element(1, Carros, X),
    element(12, Carros, X),
    element(2, Carros, Y),
    element(11, Carros, Y),
    element(5, Carros, 1),
    three_different(Carros),
    only_once(Carros, 1),
    labeling([], Carros),
    write('Carros: ', Carros).

three_different(Carros) :-
    length(Carros, L),
    L < 3.

three_different([A, B, C | T]) :-
    all_distinct([A, B, C]),
    three_different([B, C | T]).

only_once(Carros, 0) :-
    length(Carros, L),
    L < 4.

only_once([A, B, C, D | T], Counter) :-
    (A #= 2 #/\ B #= 3 #/\ C #= 4 #/\ D #= 1) <=> Seq,
    Counter #= Counter1 + Seq,
    only_once([B, C, D | T]).
```