initial(state([left, left, left, left])).
final(state([right, right, right, right])).

cross(state([left, X, Y, Z]), state([right, X, Y, Z]), farmer_cross).
cross(state([right, X, Y, Z]), state([left, X, Y, Z]), farmer_cross).

cross(state([left, X, left, Y]), state([right, X, right, Y]), farmer_brings_chicken).
cross(state([right, X, right, Y]), state([left, X, left, Y]), farmer_returns_chicken).

cross(state([left, left, X, Y]), state([right, right, X, Y]), farmer_brings_fox).
cross(state([right, right, X, Y]), state([left, left, X, Y]), farmer_returns_fox).

cross(state([left, X, Y, left]), state([right, X, Y, right]), farmer_brings_grain).
cross(state([right, X, Y, right]), state([left, X, Y, left]), farmer_returns_grain).

forbidden(state([X, Y, Y, _])) :- X \== Y.
forbidden(state([X, _, Y, Y])) :- X \== Y.

puzzle(P) :-
    initial(StartState),
    final(EndState),
    crossRiver(StartState, EndState, [StartState], P).

crossRiver(State, State, _, []).
crossRiver(StartState, EndState, States, Result) :-
    cross(StartState, TestEndState, Action),
    not(forbidden(TestEndState)),
    % Prevent infinite recursion: farmer crossing and returning with nothing
    not(member(TestEndState, States)),
    crossRiver(TestEndState, EndState, [TestEndState | States], Plan),
    Result = [Action | Plan].
