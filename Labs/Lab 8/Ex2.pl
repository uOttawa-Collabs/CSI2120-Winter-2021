leafNodes(nil, []) :- !.
leafNodes(t(V, nil, nil), [V]) :- !.

leafNodes(t(_, L, nil), Result) :-
    leafNodes(L, Result),
    !.

leafNodes(t(_, nil, R), Result) :-
    leafNodes(R, Result),
    !.

leafNodes(t(_, L, R), Result) :-
    leafNodes(L, ResultLeft),
    leafNodes(R, ResultRight),
    append(ResultLeft, ResultRight, Result),
    !.
