male(aldo).
female(christina).
female(lisa).
male(lincoln).
male(lj).
male(michael).
female(sara).
female(ella).
parent(aldo, lincoln).
parent(christina, lincoln).
parent(aldo, michael).
parent(christina, michael).
parent(lisa, lj).
parent(lincoln, lj).
parent(michael, ella).
parent(sara, ella).
father(aldo,lincoln):-parent(aldo, lincoln),male(aldo).
mother(christina,lincoln):-parent(christina,lincoln),female(christina).
father(aldo,michael):-parent(aldo,michael),male(aldo).
mother(christina,michael):-parent(christina,michael),female(christina).
father(lincoln,lj):-parent(lincoln,lj),male(lincoln).
mother(lisa,lj):-parent(lisa,lj),female(lisa).
father(michael,ella):-parent(michael,ella),male(michael).
mother(sara,ella):-parent(sara,ella),female(sara).

