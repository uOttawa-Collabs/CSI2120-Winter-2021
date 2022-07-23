even(0).
even(N) :-
    N > 0,
    M is N - 1,
    odd(M).

odd(N) :-
    N > 0,
    M is N - 1,
    even(M).

oddEven([H], [even]) :-
    even(H),
    !.

oddEven([H], [odd]) :-
    odd(H),
    !.

oddEven([H | T], [odd | L]) :-
    odd(H),
    oddEven(T, L),
    !.

oddEven([H | T], [even | L]) :-
    even(H),
    oddEven(T, L),
    !.
