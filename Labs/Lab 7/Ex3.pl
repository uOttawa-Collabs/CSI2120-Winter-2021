reverseDrop(L, NewL) :-
    subRetain(L, NewL),
    !.

subRetain([H], [H]) :-
    !.

subRetain([H | T], NewL) :-
    subDrop(T, L),
    listAppend(L, [H], NewL),
    !.

subDrop([_], []) :-
    !.

subDrop([_ | T], L) :-
    subRetain(T, L),
    !.

listAppend([], TargetList, TargetList).
listAppend([Head | OriginTail], TargetList, [Head | NewTail]) :-
    listAppend(OriginTail, TargetList, NewTail).
