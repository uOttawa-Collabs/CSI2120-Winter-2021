secondLast(X, [H | T]) :-    % Base case
    checkSingleElementList(T),
    X is H,
    !.
    
secondLast(X, [_ | T]) :-
    secondLast(X, T).
    
checkSingleElementList([_ | T]) :-
    T = [].
