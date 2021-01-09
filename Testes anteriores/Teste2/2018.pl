:- use_module(library(lists)).
:- use_module(library(clpfd)).

check2([_], []).

check2([A,B|R], [X|Xs]) :-
    A+B #= X,
    check2([B|R], Xs).

prog2(N,M,L1,L2) :-
    length(L1,N),
    N1 is N-1,
    length(L2,N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
	append(L1, L2, L3),
    all_distinct(L3),
    check2(L1, L2),
    labeling([], L1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, Men),
    length(WomenHeights, Women),
    Men =:= Women,
    length(Pairs, Men),
    length(Pair, Men), % List of all mans and cotains the indice of the woman
    domain(Pair, 1, Men),
    all_distinct(Pair),
    setHeight(MenHeights, WomenHeights, Delta, Pair, 1),
    labeling([], Pair),
    prepare(Pair, Pairs, 1).

setHeight(_, _, _, [], _).

setHeight(MenHeights, WomenHeights, Delta, [PH | PT], Current) :-
    nth1(Current, MenHeights, MenHeight),
    nth1(X, WomenHeights, WomenHeight), % Tries any womenHeight for the current menHeight
    MenHeight >= WomenHeight,
    Delta >= MenHeight - WomenHeight,
    PH #= X, % If heights are compatible then the pair number is the number of the women
    Next is Current + 1,
    setHeight(MenHeights, WomenHeights, Delta, PT, Next).

prepare([],[],_).

prepare([PH | PT], [PSH | PST], Current) :-
    PSH = Current-PH,
    Next is Current + 1,
    prepare(PT, PST, Next).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
	length(MenHeights, MenLen),
	length(WomenHeights, WomenLen),
	
	Comprimento = [MenLen, WomenLen],
	maximum(MaxLength, Comprimento),
	minimum(MinLength, Comprimento),
	
	length(MVars, MinLength),
	domain(MVars, 1, MaxLength),
	
	length(WVars, MinLength),
	domain(WVars, 1, MaxLength),
	
	all_distinct(MVars),
	all_distinct(WVars),
	
	make_pairs(MenHeights, WomenHeights, Delta, Refe, MVars, WVars),
	append(Refe, MVars, Vars1),
	append(Vars1, WVars, Vars2),
	sum(Refe, #=, Max),
	labeling([maximize(Max)], [Max | Vars2]),
	parse_values(Refe, MVars, WVars, Pairs).
	

make_pairs(_, _, _, [], [], []).	

make_pairs(MenHeights, WomenHeights, Delta, [R | Refe], [M | MVars], [W | WVars]) :-
	element(M, MenHeights, HeightM),
	element(W, WomenHeights, HeightW),
	((HeightM #>= HeightW) #/\ (HeightM	- HeightW #=< Delta)) #<=> R,
	make_pairs(MenHeights, WomenHeights, Delta, Refe, MVars, WVars).	
	
parse_values([], [], [], []).

parse_values([0 | Refe], [M | MVars], [W | WVars], Pairs) :-
	parse_values(Refe, MVars, WVars, Pairs).
	
parse_values([1 | Refe], [M | MVars], [W | WVars], [P | Pairs]) :-
	P = M - W,
	parse_values(Refe, MVars, WVars, Pairs).