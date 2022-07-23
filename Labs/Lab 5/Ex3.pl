sum_int(0, 0).
sum_int(N, X) :-
    N > 0,
    Nprime is N - 1,
    sum_int(Nprime, Xprime),
    X is Xprime + N.
