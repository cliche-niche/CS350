The program files were tested using gprolog. Brief running instructions have been provided below on how to use the Prolog files after loading them using the command `['filename']` <i>(including the inverted commas)</i>

+ [Q1.pl](./Q1.pl):
+ [Q2.pl](./Q2.pl):
+ [Q3.pl](./Q3.pl): `safety_measure(Grid, M).` where the variable "Grid" should be replaced by the actual (square) grid in a 2D list format. Example usage:

```gprolog
| ?- safety_measure([[1, 0, 0], [0, 0, 0], [0, 0, 1]], M).                       

M = 0

(1 ms) yes
| ?- safety_measure([[0, 0, 0, 1], [0, 0, 0, 0], [0, 0, 0, 0], [1, 0, 0, 0]], M).

M = 2

(18 ms) yes
| ?- 
```