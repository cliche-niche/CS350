sum([H1|[H2 | _]], X) :-
    X is H1 + H2.

canSplit_helper([H1 | [H2 | T]], X) :-
    sum([H1 | [H2 | T]], Sum),
    Sum >= X, !.

canSplit_helper([_ | [H2 | T]], X) :-
    canSplit_helper([H2 | T], X), !.

canSplit([_ | []], _) :- !.

canSplit([H | T], X) :- canSplit_helper([H | T], X).