inicial(estado(3,3,e)).

final(estado(0,0,d)).

seguro(estado(M,C,_)):-
	sobrevive(M,C),
	M1 is 3-M, C1 is 3-C,
	sobrevive(M1,C1).
	sobrevive(0,_).

sobrevive(M,C):-M>=0,M>=C.

seguinte(estado(M,C,e),estado(M1,C,d)):- ( M>=1, M1 is M-1 ) ; ( M>=2, M1 is M-2 ).

seguinte(estado(M,C,e),estado(M,C1,d)):- ( C>=1, C1 is C-1 ) ; ( C>=2, C1 is C-2 ).

seguinte(estado(M,C,e),estado(M1,C1,d)):- M>=1, C>=1, M1 is M-1, C1 is C-1.

seguinte(estado(M,C,d),estado(M1,C,e)):-
	Md is 3-M,
	( ( Md>=1, M1 is M+1 ) ; ( Md>=2, M1 is M+2 ) ).

seguinte(estado(M,C,d),estado(M,C1,e)):-
	Cd is 3-C,
	( ( Cd>=1, C1 is C+1 ) ; ( Cd>=2, C1 is C+2 ) ).

seguinte(estado(M,C,d),estado(M1,C1,e)):-
	Md is 3-M, Cd is 3-C,
	Md>=1, Cd>=1, M1 is M+1, C1 is C+1.

atravessa(Ef,Ef,[Ef],_).

atravessa(Ea,Ef,[Ea|R],Eants):-
	seguinte(Ea,Eseg),
	seguro(Eseg),
	\+ member(Eseg,Eants),
	atravessa(Eseg,Ef,R,[Eseg|Eants]).	

miss_can:-
	inicial(Ei), final(Ef),
	atravessa(Ei,Ef,L,[Ei]),
	nl, escrever(L).

escrever([X]).

escrever([E1,E2|T]):- explicacao(E1,E2), nl, escrever([E2|T]).

explicacao(estado(M,C,Marg),estado(M1,C,_)):-
	( (Marg=e,Mm is M-M1,Marg1=esquerda,Marg2=direita)
	; (Mm is M1-M, Marg1=direita,Marg2=esquerda) ),
	write('passaram '),write(Mm),
	write(' missionarios da margem '),write(Marg1),
	write(' para a margem '),write(Marg2),nl.
	
explicacao(estado(M,C,Marg),estado(M,C1,_)):-
	( (Marg=e,Cc is C-C1,Marg1=esquerda,Marg2=direita)
	; (Cc is C1-C, Marg1=direita,Marg2=esquerda) ),
	write('passaram '),write(Cc),
	write(' canibais da margem '),write(Marg1),
	write(' para a margem '),write(Marg2),nl.

explicacao(estado(M,C,Marg),estado(M1,C1,_)):-
	( (Marg=e,Mm is M-M1,Cc is C-C1,Marg1=esquerda,Marg2=direita)
	; (Mm is M1-M, Cc is C1-C, Marg1=direita,Marg2=esquerda) ),
	write('passaram '),write(Mm),write(' missionarios e '),
	write(Cc),write(' canibais da margem '),write(Marg1),
	write(' para a margem '),write(Marg2),nl.