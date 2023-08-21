is_element(_, []) :-
    fail.

is_element(X, [H | _]):-
    X = H, !.

is_element(X, [_|T]):-
    is_element(X, T).

sum([], X) :-
    X = 0, !.

sum([H | T], X) :-
    sum(T, X_),
    X is H + X_, ! .

is_acceptable([]) :- 
    fail, !.

is_acceptable([H | T]) :-
    T = [], !.

is_acceptable(List, x) :-
    sum(List, Sum),
    Sum >= x.

partition([], [], []) :- !.

partition(L, [], L) :- !.

partition([], L, L) :- !.

partition([H | T], L2, L) :-
    is_element(H, L),
    partition(T, L2, L).

partition(L1, [H | T2], L) :-
    is_element(H, L),
    partition(L1, T2, L).

can_split()
