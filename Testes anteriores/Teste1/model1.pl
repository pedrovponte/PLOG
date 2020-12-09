%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

madeItThrough(Participant) :-
	participant(Participant, _, _),
	performance(Participant, Times),
	member(120, Times).
	
	
% 2-----------------------------------------------------------------------
	
juriTimes(Participants, JuriMember, Times, Total) :-
	juriTimes(Participants, JuriMember, [], Times, 0, Total).
	
juriTimes([], _, Times, Times, Total, Total).

juriTimes([H|T], JuriMember, AuxTimes, Times, AuxTotal, Total) :-
	performance(H, PTimes),
	nth1_member(JuriMember, PTimes, Time),
	append(AuxTimes, [Time], NewAuxTimes),
	NewAuxTotal is AuxTotal + Time,
	juriTimes(T, JuriMember, NewAuxTimes, Times, NewAuxTotal, Total).
	
	
nth1_member(_, [], _) :- fail.
	
nth1_member(1, [H|_], H).

nth1_member(N, [_|T], Time) :-
	N1 is N - 1,
	nth1_member(N1, T, Time).
	

% 3-------------------------------------------------------------------------

patientJuri(JuriMember) :-
	getParticipants(Participants),
	juriTimes(Participants, JuriMember, Times, _),
	member(120, Times),
	splitListByElement(120, Times, NewTimes),
	member(120, NewTimes).
	
	
getParticipants(Participants) :-
	getParticipants([], Participants).
	
getParticipants(Acc, Participants) :-
	performance(Id, _),
	\+ member(Id, Acc),
	append(Acc, [Id], NewAcc),
	getParticipants(NewAcc, Participants).
	
getParticipants(Participants, Participants).

splitListByElement(N, [N|T], T).

splitListByElement(N, [_|T], NewTimes) :-
	splitListByElement(N, T, NewTimes).
	
% 4----------------------------------------------------------------------------
	
bestParticipant(P1, P2, P1) :-
	performance(P1, Times1),
	performance(P2, Times2),
	sumTimes(Times1, Sum1),
	sumTimes(Times2, Sum2),
	Sum1 > Sum2.
	
bestParticipant(P1, P2, P2) :-
	performance(P1, Times1),
	sumTimes(Times1, Sum1),
	performance(P2, Times2),
	sumTimes(Times2, Sum2),
	Sum2 > Sum1.
	
	
sumTimes(Times, Sum) :-
	sumTimes(Times, 0, Sum).
	
sumTimes([], Sum, Sum).

sumTimes([H|T], Acc, Sum) :-
	Acc1 is Acc + H,
	sumTimes(T, Acc1, Sum).

% 5----------------------------------------------------------

allPerfs :-
	getParticipants(Participants),
	printParticipants(Participants).
	
printParticipants([]).
	
printParticipants([H|T]) :-
	participant(H, _, Performance),
	performance(H, Times),
	write(H), write(':'), write(Performance), write(':'),write(Times), nl,
	printParticipants(T).
	

getParticipants(Participants) :-
	getParticipants([], Participants).
	
getParticipants(Acc, Participants) :-
	performance(Id, _),
	\+ member(Id, Acc),
	append(Acc, [Id], NewAcc),
	getParticipants(NewAcc, Participants).
	
getParticipants(Participants, Participants).

% 6-------------------------------------------------------------

nSuccessfulParticipants(T) :-
	findall(Participant, successful(Participant), Participants),
	length(Participants, T).
	
successful(Participant) :-
	performance(Participant, Times),
	noClickButton(Times).
	
noClickButton([]).

noClickButton([H|T]) :-
	H =:= 120,
	noClickButton(T).
	
% 7--------------------------------------------------------------

:- use_module(library(lists)).

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

% 8--------------------------------------------------------------

:- use_module(library(lists)).


eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).
	
selectNParticipants(0, _, Participants, Participants).
	
selectNParticipants(N, List, _, _) :-
	length(List, L),
	L < N,
	fail.
	
selectNParticipants(N, List, AccList, Participants) :-
	length(List, L),
	List = [H|T],
	L >= N,
	append(AccList, [H], NewAccList),
	N1 is N - 1,
	selectNParticipants(N1, T, NewAccList, Participants).
	
nextPhase(N, Participants) :-
	setof(TotalTime-Id-Performance, eligibleOutcome(Id, Performance, TotalTime), Eligible),
	reverse(Eligible, NewEligibles),
	selectNParticipants(N, NewEligibles, [], Participants).
	
% 11----------------------------------------------------------------

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).
	
langford(N,L) :-
	N1 is N * 2,
	length(L, N1),
	langford(N, L, N1).
	
langford(0, _, _).

langford(N, L, TotalLength) :-
	impoe(N, L),
	N1 is N-1,
	langford(N1, L, TotalLength).

	
	
