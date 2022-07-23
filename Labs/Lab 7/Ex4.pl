addAlternate(L, S) :-
    addAlternate(L, 0, p, S),
    !.

addAlternate([], A, _, A).    

addAlternate([H | T], A, p, S) :- !,
    AA is A + H,
    addAlternate(T, AA, m, S).

addAlternate([H | T], A, m, S) :- !, 
    AA is A - H,
    addAlternate(T, AA, p, S).
