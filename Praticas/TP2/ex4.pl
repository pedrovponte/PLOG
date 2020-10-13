factorial(0,1).
factorial(N,Valor):-
	N>0,
	N1 is N-1, 
	factorial(N1,V1),
	Valor is N * V1.
	


fact(N,F):-fact(N,1,F).
fact(0,F,F).
fact(N,Acc,F):-
	N>0,
	N1 is N-1,
	Acc1 is Acc*N,
	fact(N1,Acc1,F).