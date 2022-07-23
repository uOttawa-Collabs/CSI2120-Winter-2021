maxmin([H], Max, Min) :-
    Max is H,
    Min is H,
    !.

maxmin([H | T], Max, Min) :-
    maxmin(T, MaxPrime, MinPrime),
    max(H, MaxPrime, Max),
    min(H, MinPrime, Min).
    
max(Number1, Number2, Max) :- 
    Number1 > Number2,
    Max is Number1,
    !.

max(Number1, Number2, Max) :- 
    Number1 =< Number2,
    Max is Number2,
    !.
    
min(Number1, Number2, Min) :- 
    Number1 < Number2,
    Min is Number1,
    !.

min(Number1, Number2, Min) :- 
    Number1 >= Number2,
    Min is Number2,
    !.
