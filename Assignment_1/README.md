The program files were tested using swipl. Brief running instructions have been provided below on how to use the Prolog files after loading them using the command `['filename']` <i>(including the inverted commas)</i>

+ [Q1.pl](./Q1.pl): `union(S1, S2, L).`  where the variable "S1" and "S2" are the 2 lists whose union is to be found, "L" is the output variable that contains the Union.

Similarly, `intersect(S1, S2, L).`  where the variable "S1" and "S2" are the 2 lists whose union is to be found, "L" is the output variable that contains the intersection.

`power_set(S, PS).`  where the variable "S" is the set whose power set is to be found, "PS" is the output variable that contains the power set.

Example usage:

```swipl
| ?- union([4,9,5],[9,4,9,8,4], L).                       

L = [5, 9, 8, 4].

| intersect([4,9,5],[9,4,9,8,4], L).

L = [4, 9].

| ?- power_set([1,2,3], PS).

PS = [[1, 2, 3], [1, 2], [1, 3], [1], [2, 3], [2], [3], []].


```
+ [Q2.pl](./Q2.pl): `canSplit(L, X).` where the variable "L" should be replaced by the list and "X" should be replace by the required x value. Example usage:

```swipl
| ?- canSplit([2,2,1], 4).                       

true.

| ?- canSplit([2,1,3], 5).

false.
```
+ [Q3.pl](./Q3.pl): `safety_measure(Grid, M).` where the variable "Grid" should be replaced by the actual (square) grid in a 2D list format. Example usage:

```swipl
| ?- safety_measure([[1, 0, 0], [0, 0, 0], [0, 0, 1]], M).                       

M = 0

| ?- safety_measure([[0, 0, 0, 1], [0, 0, 0, 0], [0, 0, 0, 0], [1, 0, 0, 0]], M).

M = 2

| ?- 
```