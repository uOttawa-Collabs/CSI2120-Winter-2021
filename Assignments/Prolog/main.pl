% Question 1
% Question 1.a
greater([], [], []) :- !.

greater([Head1 | Tail1], [Head2 | Tail2], ['#t' | Result]):-
    Head1 > Head2,
    greater(Tail1, Tail2, Result),
    !.

greater([Head1 | Tail1], [Head2 | Tail2], ['#f' | Result]):-
    Head1 =< Head2,
    greater(Tail1, Tail2, Result),
    !.

% Question 1.b
greater([_ | Tail1], [], ['#t' | Result]):-
    greater(Tail1, [], Result),
    !.

greater([], [_ | Tail2], ['#f' | Result]):-
    greater([], Tail2, Result),
    !.

% Question 2
adj(a, b). adj(a, g).
adj(b, c). adj(b, i).
adj(c, d). adj(d, e).
adj(d, j). adj(e, l).
adj(f, g). adj(g, h).
adj(h, i). adj(i, j).
adj(j, k). adj(k, l).
adj(l, m).

% Question 2.b
neighbors(Piece, Set) :-
    setof(X, (adj(Piece, X); adj(X, Piece)), Set),
    !.

% Question 2.a
neighbors(Piece, Number) :-
    neighbors(Piece, Set),
    length(Set, Number),
    !.

% Question 2.c
same_neighbor(Piece1, Piece2, CommonNeighbors) :-
    neighbors(Piece1, Set1),
    neighbors(Piece2, Set2),
    intersection(Set1, Set2, [CommonNeighbors | _]).

% Question 3
% voter, voted_for
vote(marie, justin).
vote(jean, erin).
vote(sasha, justin).
vote(helena, erin).
vote(emma, jagmeet).
vote(sam, jagmeet).
vote(paul, erin).
vote(jake, justin).
vote(mark, justin).

count(People, VoteCount) :-
    bagof(X, vote(X, People), List),
    length(List, VoteCount),
    !.

elect([], _) :- !.

elect([Head | PeopleList], Result) :-
    elect(PeopleList, ResultPrime),
    count(Head, HeadVoteCount),
    count(ResultPrime, ResultVoteCount),
    HeadVoteCount > ResultVoteCount,
    Result = Head,
    !.

elect([Head | PeopleList], Result) :-
    elect(PeopleList, ResultPrime),
    count(Head, HeadVoteCount),
    count(ResultPrime, ResultVoteCount),
    HeadVoteCount =< ResultVoteCount,
    Result = ResultPrime,
    !.

% Question 4
% course, evaluation, max mark
evaluation('CSI2120', assignment(1), 5).
evaluation('CSI2120', labQuiz(1), 1).
evaluation('CSI2120', midterm(1), 26).
evaluation('SEG2105', midterm(1), 20).

% name, studentId, course list
student(name(blake, [ann]), 33333, ['CSI2110', 'CSI2120']).
student(name(carp, [tony, a]), 76543, ['SEG2105']).
student(name(doe, [jane, j]), 88345, ['CSI2120']).
student(name(green, [tim, b]), 12345, ['CSI2120', 'SEG2105']).

% course, studentId, evaluation, mark
mark('CSI2120', 33333, midterm(1), 20).
mark('CSI2120', 88345, midterm(1), 23.5).
mark('CSI2120', 12345, midterm(1), 16).

average(List, Average) :-
    average(List, List, _, Average),
    !.

average([], List, Length, Average) :-
    length(List, Length),
    Average = 0,
    !.

average([Head | Tail], List, Length, Average) :-
    average(Tail, List, Length, AveragePrime),
    Average is AveragePrime + Head / Length,
    !.

averageMark(Course, Evaluation, AverageMark) :-
    findall(Mark, mark(Course, _, Evaluation, Mark), MarkList),
    evaluation(Course, Evaluation, MaxMark),
    average(MarkList, Average),
    AverageMark is (Average / (MaxMark) * 100),
    !.
