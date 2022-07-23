interval(X, L, H) :- number(X), number(L), number(H),
    !, X >= L, X =< H.
interval(X, X, H) :- number(X), number(H),
    X =< H.
interval(X, L, H) :- number(L), number(H), 
    L < H, L1 is L + 1,
    interval(X, L1, H).

% Answers
    
% ?- findall(X, interval(X, 1, 10), L). 
% L = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].

% ?- findall((X, Y), (interval(X, 1, 3), interval(Y, 1, 3)), L).
% L = [(1, 1),  (1, 2),  (1, 3),  (2, 1),  (2, 2),  (2, 3),  (3, 1), (3, 2), (3, 3)].

% ?- findall([X, Y], (interval(X, 1, 3), interval(Y, 1, 3)), L).
% L = [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]].

% ?- findall([X, Y], (interval(X, 1, 3), interval(Y, 1, 3), X =\= Y), L).
% L = [[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]].

