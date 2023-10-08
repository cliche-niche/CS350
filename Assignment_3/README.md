The program files were tested using `ghci`. Brief instructions for running have been provided below on how to use the Prolog files after loading them using the command `:load ["filename.hs"]` <i>(including the inverted commas)</i>

+ [Q1.hs](./Q1.hs): `dia t` can be used on any previously defined BTree `t` and the program will return the diameter of the given tree. Example usage:
```ghci
> t = Node (Node Null 5 Null) 2 (Node Null 3 Null)
> dia t
3
> t = Node (Node Null 5 Null) 2 (Node Null 3 (Node (Node Null 6 Null) 7 (Node Null 6 (Node Null 8 (Node Null 9 Null)))))
> dia t
7
> dia (Node (Node Null 5 Null) 2 (Node Null 3 (Node (Node Null 6 Null) 7 (Node Null 6 (Node Null 8 (Node Null 9 Null))))))
7
```
+ [Q2.hs](./Q2.hs): TBD.
+ [Q3.hs](./Q3.hs): TBD.
