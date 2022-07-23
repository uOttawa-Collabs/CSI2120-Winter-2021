indexOf(X, []) :- !, fail.
indexOf(X, [X | _], 0).
indexOf(X, [Y | L], N) :- indexOf(X, L, NN), N is NN + 1.
