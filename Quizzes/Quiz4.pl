double(X, Y) :- var(X), X is Y / 2, !.
double(X, Y) :- Y is 2 * X, !.
