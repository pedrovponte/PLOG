:-use_module(library(clpfd)).

quad_mag_3x3:-
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
    R11 #< R13, % evitar que se apresente soluções simétricas, ou seja, que a solução seja a mesma, mas que surja rodada 90º
    R11 #< R31,
    R13 #< R31,
    labeling([], Quad),
    nl,
    format('~d ~d ~d \n', [R11, R12, R13]),
    format('~d ~d ~d \n', [R21, R22, R23]),
    format('~d ~d ~d \n', [R31, R32, R33]), 
    nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

quad_mag_4x4:-
    Quad = [R11, R12, R13, R14, R21, R22, R23, R24, R31, R32, R33, R34, R41, R42, R43, R44],
    domain(Quad, 1, 16),
    all_distinct(Quad),
    R11 + R12 + R13 + R14 #= S,
    R21 + R22 + R23 + R24 #= S,
    R31 + R32 + R33 + R34 #= S,
    R41 + R42 + R43 + R44 #= S,
    R11 + R22 + R33 + R44 #= S,
    R14 + R23 + R32 + R41 #= S,
    R11 + R21 + R31 + R41 #= S,
    R12 + R22 + R32 + R42 #= S,
    R13 + R23 + R33 + R43 #= S,
    R14 + R24 + R34 + R44 #= S,
    R11 #< R14,
    R11 #< R41,
    R14 #< R41,
    labeling([], Quad),
    nl,
    format('~d ~d ~d ~d \n', [R11, R12, R13, R14]),
    format('~d ~d ~d ~d \n', [R21, R22, R23, R24]),
    format('~d ~d ~d ~d \n', [R31, R32, R33, R34]), 
    format('~d ~d ~d ~d \n', [R41, R42, R43, R44]),
    nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zebra :-
    Sol = [Nac, Ani, Beb, Cor, Tab],
    Nac = [Ing, Esp, Nor, Ucr, Por],
    Ani = [Cao, Rap, Igu, Cav, Zeb],
    Beb = [Sum, Cha, Caf, Lei, Agu],
    Cor = [Verm, Verd, Bran, Amar, Azul],
    Tab = [Che, Win, LS, SG, Mar],

    List = [Ing, Esp, Nor, Ucr, Por, Cao, Rap, Igu, Cav, Zeb, Sum, Cha, Caf, Lei, Agu, Verm, Verd, Bran, Amar, Azul, Che, Win, LS, SG, Mar],

    domain(List, 1, 5),

    all_different(Nac),
    all_different(Ani),
    all_different(Beb),
    all_different(Cor),
    all_different(Tab),

    Ing #= Verm,
    Esp #= Cao,
    Nor #= 1,
    Amar #= Mar,
    abs(Che-Rap) #= 1,
    abs(Nor-Azul) #= 1,
    Win #= Igu,
    LS #= Sum,
    Ucr #= Cha,
    Por #= SG,
    abs(Mar - Cav) #= 1,
    Verd #= Caf,
    Verd #= Bran + 1,
    Lei #= 3,

    labeling([], List),
    write(Sol),
    nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nqueens(Cols) :-
    Cols = [C1, C2, C3, C4],
    domain(Cols, 1, 4),
    all_different(Cols),
    C1 #\= C2 + 1, C1 #\= C2 - 1, C1 #\= C3 + 2, C1 #\= C3 - 2, C1 #\= C4 + 3, C1 #\= C4 - 3,
    C2 #\= C3 + 1, C2 #\= C3 - 1, C3 #\= C4 + 2, C3 #\= C4 - 2,
    C3 #\= C4 + 1, C3 #\= C4 - 1, 
    labeling([], Cols).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nqueens(N,Cols):-
    length(Cols,N),
    domain(Cols,1,N),
    constrain(Cols),
    % all_distinct(Cols), % Redundante mas diminui o tempo de resolução
    labeling([],Cols).

constrain([]).

constrain([H | RCols]):-
    safe(H,RCols,1),
    constrain(RCols).
    safe(_,[],_).

safe(X,[Y | T], K) :-
    noattack(X,Y,K),
    K1 is K + 1,
    safe(X,T,K1).

noattack(X,Y,K) :-
    X #\= Y,
    X + K #\= Y,
    X - K #\= Y.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

send(Vars) :-
    Vars = [S, E, N, D, M, O, R, Y],
    domain(Vars, 0, 9),
    all_different(Vars),
    S #\= 0,
    M #\= 0,
    D + E #= Y + C1 * 10,
    N + R + C1 #= E + C2 * 10,
    E + O + C2 #= N + C3 * 10,
    S + M + C3 #= O + C4 * 10,
    C4 #= M,
    labeling([ff], Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

donald(Vars) :-
    Vars = [D, O, N, A, L, G, E, R, B, T],
    domain(Vars, 0, 9),
    all_different(Vars),
    D + D #= T + C1 * 10,
    L + L + C1 #= R + C2 * 10,
    A + A + C2 #= E + C3 * 10,
    N + R + C3 #= B + C4 * 10,
    O + E + C4 #= O + C5 * 10,
    D + G + C5 #= R + C6 * 10,
    C6 #= 0,
    labeling([ff], Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cross(Vars) :-
    Vars = [C, R, O, S, A, D, N, G, E],
    domain(Vars, 0, 9),
    all_different(Vars),
    S + S #= R + C1 * 10,
    S + D + C1 #= E + C2 * 10,
    O + A + C2 #= G + C3 * 10,
    R + O + C3 #= N + C4 * 10,
    C + R + C4 #= A + C5 * 10,
    0 + 0 + C5 #= D,
    labeling([ff], Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumProduct(Vars) :-
    Vars = [A, B, C],
    domain(Vars, 1, 1000000),
    A * B * C #= A + B + C,
    B #< C,
    B #> A,
    labeling([], Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

perus(PUP) :-
    A in 1..9,
    B in 0..9,
    PUP * 72 #= A * 1000 + 670 + B.