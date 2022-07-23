parent(jack,joe).
parent(jack,karl).
parent(marie,anne).
parent(joe,anne).
parent(marie,paul).
parent(joe,paul).
parent(marie,sylvie).
parent(bruno,sylvie).
parent(anne,zach).
parent(tim,zach).
parent(sam,tim).
parent(emma,tim).
parent(josee,sam).
parent(gilles,sam).
female(marie).
female(sylvie).
female(anne).
female(emma).
female(josee).
male(karl).
male(jack).
male(joe).
male(bruno).
male(paul).
male(tim).
male(zach).
male(sam).
male(gilles).

gmp(X, Y) :- parent(X, Z), 
             male(Z), 
             parent(Z, Y), 
             female(X).
