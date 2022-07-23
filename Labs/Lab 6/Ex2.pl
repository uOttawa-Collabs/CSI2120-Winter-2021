element(chlorine, 'Cl').
element(helium, 'He').
element(hydrogen, 'H').
element(nitrogen, 'N').
element(oxygen, 'O').

% Entry point
main :-
    write("Elements in the Periodic Table"), nl,
    repeat,
    write("Symbol to look-up: "),
    read(X),
    process(X).
    
process(X) :-
    element(E, X),
    success(E, X),
    !,
    fail.

process(Y) :-
    failure(Y),
    !,
    write("Exiting.").
    
success(E, X) :-
    write(X),
    write(" is the symbol for: "),
    write(E), nl.

failure(X) :-
    write("Don't know the symbol: "),
    write(X), nl.
