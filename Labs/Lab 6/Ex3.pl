canalOpen(saturday).
canalOpen(monday).
canalOpen(tuesday).

raining(saturday).

melting(saturday).
melting(sunday).
melting(monday).

winterlude(X) :-
    canalOpen(X),
    isFalse(raining(X)),
    isFalse(melting(X)).

isFalse(P) :- P, !, fail.
isFalse(_).
