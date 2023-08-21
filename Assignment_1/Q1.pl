is_element(_, []) :-
    fail.

is_element(X, [H | _]):-
    X = H, !.

is_element(X, [_|T]):-
    is_element(X, T).

make_unique([], []) :- !.

make_unique([H | T], Out_List) :-
    is_element(H, T),
    make_unique(T, Out_List), !.

make_unique([H | T], Out_List) :-
    not(is_element(H, T)),
    make_unique(T, Small_Out_List),
    Out_List = [H | Small_Out_List].

intersect_helper([] , _ , []) :- !.

intersect_helper(_, [], []) :- !.

intersect_helper([H1 | T1], S, Intersect_List) :-
    is_element(H1, S),
    intersect_helper(T1, S, Small_Intersect_List),
    Intersect_List = [H1 | Small_Intersect_List] , !.

intersect_helper([H1 | T1], S, Intersect_List) :-
    not(is_element(H1, S)),
    intersect_helper(T1, S, Intersect_List).

intersect(S1, S2, Intersect_List) :-
    intersect_helper(S1, S2, Redundant_Intersect_List),
    make_unique(Redundant_Intersect_List, Intersect_List).

union_helper([], S, S) :- !.

union_helper(S, [], S) :- !.

union_helper([H1 | T1], [H2 | T2], Union_List) :-
    union_helper(T1, T2, Small_Union_List),
    Union_List = [H1 | [H2 | Small_Union_List]].

union(S1, S2, Union_List) :-
    union_helper(S1, S2, Redundant_Union_List),
    make_unique(Redundant_Union_List, Union_List).

ord_subset_helper([], []).

ord_subset_helper([H | T], [H | TS])  :- 
    ord_subset_helper(T, TS).

ord_subset_helper(S, [_ | TS]) :- 
    ord_subset_helper(S, TS).

ord_subset(S, T) :-
    make_unique(T, T_),
    ord_subset_helper(S, T_).

power_set(List, Power_Set) :-
    findall(Sub_Set, ord_subset(Sub_Set, List), Power_Set).