% Original program
countDownOrig(N) :-
    repeat,
    writeln(N),
    N is N - 1,
    N < 0,
    !.

% Observation
% The program outputs infinite 5s.

% Explanation
% The clause N is N - 1 will always fail, since N is not equal to N - 1 anyway.
% As N is N - 1 being evaluated to false, the repeat clause causes Prolog to match this rule (countDownOrig) again, 
% leading to an infinite loop.

% Solution
countDown(N) :-
    writeln(N),
    N > 0,
    Nprime is N - 1,
    countDown(Nprime).

