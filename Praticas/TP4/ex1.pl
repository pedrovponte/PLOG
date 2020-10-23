ligado(a,b).
ligado(a,c).
ligado(b,d).
ligado(b,e).
ligado(b,f).
ligado(c,g).
ligado(d,h).
ligado(d,i).
ligado(f,i).
ligado(f,j).
ligado(f,k).
ligado(g,l).
ligado(g,m).
ligado(k,n).
ligado(l,o).
ligado(i,f).

resolva_prof(No_inicial, No_meta, Solucao):-
	resolva_prof([], No_inicial, No_meta, Solucao).
	
resolva_prof(Visitados, No_meta, No_meta, []).
	
resolva_prof(Visitados, No_inicial, No_meta, [No_inicial|Solucao]):-
	\+member(No_inicial,Visitados),
	No_inicial \= No_meta,
	ligado(No_inicial, No1),
	resolva_prof([No_inicial|Visitados], No1, No_meta, Solucao).
	


resolva_larg(No_inicial, No_meta, Solucao):-
	resolva_larg([], [[No_inicial]], No_meta, Sol).

resolva_larg(Visitados, [[No_meta|T]|_], No_meta, [No_meta|T]).

resolva_larg(Visitados, [T|Fila], No_meta, Solucao):-
	