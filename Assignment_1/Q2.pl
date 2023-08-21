sum([], X) :-
    X = 0.

sum([H | T], X) :-
    sum(T, X_),
    X is H + X_.

is_acceptable([_ | []], _).

is_acceptable([H1 | [H2 | T]], X) :-
    sum([H1 | [H2 | T]], Sum),
    Sum >= X.

sublists([], [], []).

sublists([], [H | T], [H | T]).

sublists([H | T], [], [H | T]).

sublists([H | T1], [H2 | T2], [H | T]) :-
    sublists(T1, [H2 | T2], T).

can_split([_ | []], _).

can_split(L, X) :-
    sublists(L1, L2, L),
    is_acceptable(L1, X),
    is_acceptable(L2, X),
    can_split(L1, X),
    can_split(L2, X),
    !.
