**1.**

```pl
madeItThrough(Participant) :-
	participant(Participant, _, _),
	performance(Participant, List),
	isMember(120, List).
	
isMember(X, []) :- fail.
isMember(X, [X|_]).
isMember(X, [_|T]) :- isMember(X,T).
```

**2.**

```pl
juriTimes(Participants, JuriMember, Times, Total) :-
	juriTimes(Participants, JuriMember, [], Times, 0, Total).

juriTimes([], _, Times, Times, Total, Total).

juriTimes([H|T], JuriMember, TimesList, Times, TotalAcc, Total) :-
	performance(H, JTimes),
	nth1_member(JuriMember, JTimes, Time),
	NewTotal is TotalAcc + Time,
	append(TimesList, [Time], NewTimeL),
	juriTimes(T, JuriMember, NewTimeL, Times, NewTotal, Total).
	
nth1_member(_, [], _) :- fail.
nth1_member(1, [H | _], H).
nth1_member(N, [_ | T], El) :-
	N1 is N - 1,
	nth1_member(N1, T, El).
```

**3.**

```pl
patientJuri(JuriMember) :-
	getParticipants(Participants),
	juriTimes(Participants, JuriMember, Times, _),
	isMember(120, Times),
	splitListByElement(120, Times, NTimes),
	isMember(120, NTimes).
	
getParticipants(Participants) :-
	getParticipants([], Participants).
	
getParticipants(Acc, Participants) :-
	performance(Participant, _),
	\+isMember(Participant, Acc),
	append(Acc, [Participant], NewAcc),
	getParticipants(NewAcc, Participants).
	
getParticipants(Participants, Participants).

splitListByElement(Element, [Element|T], T).
splitListByElement(Element, [_ | T], N) :-
	splitListByElement(Element, T, N).
```

**4.**

```pl
bestParticipant(P1, P2, P1) :-
	performance(P1, Times1),
	sumOfTimes(Times1, Sum1),
	performance(P2, Times2),
	sumOfTimes(Times2, Sum2),
	Sum1 > Sum2.
	
bestParticipant(P1, P2, P2) :-
	performance(P1, Times1),
	sumOfTimes(Times1, Sum1),
	performance(P2, Times2),
	sumOfTimes(Times2, Sum2),
	Sum2 > Sum1.
	

sumOfTimes(Times, Sum) :-
	sumOfTimes(Times, 0, Sum).
	
sumOfTimes([H|T], AccSum, Sum) :-
	AccSum1 is AccSum + H,
	sumOfTimes(T, AccSum1, Sum).
	
sumOfTimes([], Sum, Sum).
```

**5.**

```pl
allPerfs :-
	getParticipants(Participants),
	printParticipants(Participants).
	
printParticipants([]).
	
printParticipants([H|T]) :-
	participant(H, _, Perf),
	performance(H, Times),
	write(H), write(':'), write(Perf), write(':'), write(Times), nl,
	printParticipants(T).
```

**6.**

```pl
nSuccessfulParticipants(T) :-
	findall(Participant, successful(Participant), Participants),
	length(Participants, T).
	
successful(Participant) :-
	performance(Participant, Times),
	noClickOnButton(Times).
	
noClickOnButton([]).

noClickOnButton([H|T]) :-
	H =:= 120,
	noClickOnButton(T).
```

**7.**

```pl
juriFans(JuriFansList) :-
	auxJuriFans([], [], JuriFansList).

auxJuriFans(Visited, AuxList, JuriFansList) :-
	performance(Participant, Times),
	participant(Participant, _, _),
	\+ isMember(Participant, Visited),
	findall(N, (nth1(N, Times, Time), Time =:= 120), NotPressed),
	append(AuxList, [Participant-NotPressed], NewAuxList),
	append(Visited, [Participant], NewVisited),
	auxJuriFans(NewVisited, NewAuxList, JuriFansList).
	
auxJuriFans(_, JuriFansList, JuriFansList).
```

**8.** 

```pl
selectNParticipants(N, List, Sublist) :-
	append(Sublist, _, List),
	length(Sublist, N).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

nextPhase(N, Participants) :-
	setof(TotalTime-Id-Performance, eligibleOutcome(Id, Performance, TotalTime), Eligible),
	reverse(Eligible, RevParticipants),
	selectNParticipants(N, RevParticipants, Participants).
```

**9.**

Para uma idade Q e uma Lista de participantes R, devolve uma lista das performances feitas por participantes pertencentes à lista e que têm idade igual ou inferior a Q anos.
O cut é verde pois a chamada à função predX não falha, pelo que o cut não vai ter efeito.

**10.**

Este predicado retorna uma lista com X + 2 elementos, sendo o primeiro e o último elementos da lista iguais a X, garantindo assim que entre os 2 elementos X da lista existem X elementos.

**11.**

```pl
langford(N, L) :-
	N1 is 2 * N,
	length(L, N1),
	langford(N, L, N1).
	
langford(0, _, _).

langford(N, L, TotalLength) :-
	impoe(N, L),
	N1 is N - 1,
	langford(N1, L, TotalLength).
```