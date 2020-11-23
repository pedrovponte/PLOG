:-use_module(library(lists)). 
ligado(a,b). 
ligado(f,i).
ligado(a,c). 
ligado(f,j).
ligado(b,d). 
ligado(f,k).
ligado(b,e). 
ligado(g,l).
ligado(b,f). 
ligado(g,m).
ligado(c,g). 
ligado(k,n).
ligado(d,h). 
ligado(l,o).
ligado(d,i). 
ligado(i,f).  

resolva_prof(Start, End, Sol) :-
    resolva_prof(Start, End, [Start], Sol).

resolva_prof(End, End, Sol, Sol).

resolva_prof(Start, End, Temp, Sol) :-
    ligado(Start, Next),
    \+ member(Next, Temp),
    append(Temp, [Next], Temp1),
    resolva_prof(Next, End, Temp1, Sol).
	
ache_todos(X, Y, Z) :-
    bagof(X, Y, Z), !.

ache_todos(_, _, []).

estende_ate_filho([N|Path], [N1,N|Path]) :-
    ligado(N, N1),
    \+ member(N1, Path).

resolva_larg(Start, End, Sol) :-
    largura([[Start]], End, Sol1),
    reverse(Sol1, Sol).

largura([[End|T]|_], End, [End|T]).

largura([T|Fila], End, Sol) :-
    ache_todos(ExtensaoAteFilho, estende_ate_filho(T, ExtensaoAteFilho), Extensoes),
    append(Fila, Extensoes, FilaExtendida),
    largura(FilaExtendida, End, Sol).
	
get_fastest_path(Start, End, Sol) :-
    setof(Tam-Sol1, (resolva_prof(Start, End, Sol1), length(Sol1, Tam)), L),
    write(L),
    nl,
    nth0(0, L, Sol).
	
pathContains(List, Path) :-
	ligado(X, _),
	ligado(_, Y),
	resolva_prof(X, Y, Path),
	all_member(List, Path).

all_member([X|Rest], Path) :-
	member(X, Path),
	all_member(Rest, Path).

all_member([], Path, Path).

getAllPaths(Start, End, Paths) :-
    findall(Path, resolva_prof(Start, End, Path), Paths).