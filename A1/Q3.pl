% ASSUMPTIONS
% 1. There is at least one boulder in the grid. 
%    If there is not, program might behaviour unexpectedly, likely reporting 0 as the answer.
% 2. The dimensions of the grid is at least 1x1, and the grid is always a square.

not(Goal) :- Goal, !, fail.
not(_) :- true.


% Max/Min utils
max(A, B, M) :-
    A >= B,
    !,
    M is A.

max(A, B, M) :-
    B > A,
    !,
    M is B.

min(A, B, M) :-
    A =< B,
    !,
    M is A.

min(A, B, M) :-
    B < A,
    !,
    M is B.


% Checking if a point is a Boulder or not in 1D list
boulder_y([H | _], 0) :-
    !,
    H == 1.

boulder_y([_ | T], Y) :-
    Y1 is Y - 1,
    !,
    boulder_y(T, Y1).    

% H is expected to be a list itself here since the list is expected to be 2D here
boulder_xy([H | _], 0, Y) :-
    !,
    boulder_y(H, Y).

boulder_xy([_ | T], X, Y) :-
    X1 is X-1,
    !,
    boulder_xy(T, X1, Y).


% Find dimension(s) of a grid
find_n([], 0).

find_n([_ | T], N) :-
    find_n(T, N1),
    N is N1 + 1.


% Path helper functions
check_equal_points([X1 | [Y1]], [X2 | [Y2]]) :-
    X1 =:= X2,
    Y1 =:= Y2.

check_membership(Point, [H | _]) :-
    check_equal_points(Point, H),
    !.

check_membership(Point, [_ | T]) :-
    check_membership(Point, T).


% Find all paths
extend_path(P, X, Y, N, Path) :-
    X =:= N-1,
    Y =:= N-1,
    !,
    Path = P.

extend_path(P, X, Y, N, Path) :-
    X - 1 >= 0,
    not(check_membership([X - 1, Y], P)),
    extend_path([[X - 1, Y] | P], X - 1, Y, N, Path).

extend_path(P, X, Y, N, Path) :-
    Y - 1 >= 0,
    not(check_membership([X, Y - 1], P)),
    extend_path([[X, Y - 1] | P], X, Y - 1, N, Path).

extend_path(P, X, Y, N, Path) :-
    X + 1 < N,
    not(check_membership([X + 1, Y], P)),
    extend_path([[X + 1, Y] | P], X + 1, Y, N, Path).

extend_path(P, X, Y, N, Path) :-
    Y + 1 < N,
    not(check_membership([X, Y + 1], P)),
    extend_path([[X, Y + 1] | P], X, Y + 1, N, Path).


% Creates a valid path in a grid of NxN; Used in findall to bruteforce over all possible paths
create_path_init(N, Path) :-
    P = [[0, 0]],
    extend_path(P, 0, 0, N, Path).


% Extracts co-ordinates of all the boulders present in a Grid G of size NxN and stores it in B
add_if_boulder(_, X, _, N, _) :-
    X =:= N,
    !.

add_if_boulder(G, X, Y, N, B) :-
    Y =:= N,
    !,
    add_if_boulder(G, X + 1, 0, N, B).

add_if_boulder(G, X, Y, N, B) :-
    boulder_xy(G, X, Y),
    !,
    add_if_boulder(G, X, Y+1, N, B1),
    B = [[X, Y] | B1].

add_if_boulder(G, X, Y, N, B) :-
    not(boulder_xy(G, X, Y)),
    !,
    add_if_boulder(G, X, Y+1, N, B).

find_boulders(G, N, B) :-
    add_if_boulder(G, 0, 0, N, B).


% Find manhattan distance between two points and store it in Z
manhattan_dist([X1, Y1], [X2, Y2], Z) :-
    max(X1 - X2, X2 - X1, Z1),
    max(Y1 - Y2, Y2 - Y1, Z2),
    Z is Z1 + Z2.


% Find closest distance from all boulders w.r.t. point P and store in M
dist_point(P, [H | []], M) :-
    !,
    manhattan_dist(P, H, M).

dist_point(P, [H | T], M) :-
    manhattan_dist(P, H, M1),
    dist_point(P, T, M2),
    min(M1, M2, M).


% Find closest distance ("safety measure") from a boulder given a path and store in M
% Makes use of dist_point
dist_path(_, [], M) :-
    !,
    M is 0.
    
dist_path([H | []], B, M) :-
    !,
    dist_point(H, B, M).

dist_path([H | T], B, M) :-
    dist_point(H, B, M1),
    dist_path(T, B, M2),
    min(M1, M2, M).


% Find maximum distance/safety measure across all paths and store in M
max_dist_overall([], _, 0).

max_dist_overall([H | T], B, M) :-
    dist_path(H, B, M1),
    max_dist_overall(T, B, M2),
    max(M1, M2, M).



% Main function to find maximum safety measure given a Grid and stores it in M.
safety_measure(Grid, M) :-
    find_n(Grid, N),
    findall(Path, create_path_init(N, Path), Paths),
    find_boulders(Grid, N, B),
    max_dist_overall(Paths, B, M).