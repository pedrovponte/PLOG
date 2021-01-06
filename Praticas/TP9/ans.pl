:-use_module(library(clpfd)).
:-use_module(library(lists)). 

solve(Total):-
    Total = [Joao, Antonio, Francisco, Harpa, Violino, Piano, Terca, Quinta1, Quinta2], 
    Pessoas = [Joao, Antonio, Francisco], 
    Instrumento = [Harpa, Violino, Piano],       
    Ensaio = [Terca, Quinta1, Quinta2],  
    domain(Total, 1,3),  
    all_distinct(Pessoas),
    all_distinct(Instrumento),
    all_distinct(Ensaio), 
    Antonio #\= Piano,   
    Piano #= Terca, 
    Joao #\= Violino,  
    Joao #\= Piano,    
    Joao #= Quinta1, 
    Violino #= Quinta2, 
    labeling([], Total). 

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
    write('TOTAL: '), write(Total).

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

entregas :-
    Nome = [Paula, Artur, Daniel, Ema],
    Sobrenome = [Mala, Postal, Bola, Famoso],
    Morada = [Espanha, Turquia, Primavera, Hungria, Sardenha],
    Encomenda = [Roupas, Catalogo, Plantas, Livro],
    domain(Nome, 1, 4),
    domain(Sobrenome, 1, 4),
    domain(Morada, 1, 5),
    domain(Encomenda, 1, 4),
    all_distinct(Nome),
    all_distinct(Sobrenome),
    all_distinct(Morada),
    all_distinct(Encomenda),
    Mala #= Roupas,
    Paula #= Postal, 
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

produto :-
    Variaveis = [Interrogadas, Liquido, Po, LiquidoPo, NaoUtiliza],
    domain(Variaveis, 0, 10000),
    Interrogadas #= Liquido + Po + LiquidoPo + NaoUtiliza,
    (1 * Interrogadas) / 3 #= Liquido + NaoUtiliza,
    (2 * Interrogadas) / 7 #= NaoUtiliza + Po,
    LiquidoPo #= 427,
    NaoUtiliza #= (1 * Interrogadas) / 5,
    labeling([], Variaveis),
    write('Variaveis: '), write(Variaveis).

carros2 :-
    length(Carros, 12),
    global_cardinality(Carros, [2-4, 3-2, 4-3, 1-3]),
    element(1, Carros, X),
    element(12, Carros, X),
    element(2, Carros, Y),
    element(11, Carros, Y),
    element(5, Carros, 1),
    three_different(Carros),
    only_once(Carros, 1),
    labeling([], Carros),
    write('Carros: '), write(Carros).

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
    (A #= 2 #/\ B #= 3 #/\ C #= 4 #/\ D #= 1) #<=> Seq,
    Counter #= Counter1 + Seq,
    only_once([B, C, D | T], Counter1).
