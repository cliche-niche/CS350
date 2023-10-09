The program files were tested using `ghci`. Brief instructions for running have been provided below on how to use the Prolog files after loading them using the command `:load ["filename.hs"]` <i>(including the inverted commas)</i>

+ [Q1.hs](./Q1.hs): `dia t` can be used on any previously defined BTree `t` and the program will return the diameter of the given tree. Example usage:
```ghci
> :load ["Q1.hs"]
> t = Node (Node Null 5 Null) 2 (Node Null 3 Null)
> dia t
3
> t = Node (Node (Node Null 1 Null) 2 Null) 3 (Node (Node Null 4 Null) 5 Null) -- Root in diameter
> dia t
5
> t = Node (Node (Node (Node Null 1 Null) 2 Null) 3 (Node (Node Null 4 Null) 5 Null)) 6 Null -- Root not in diameter
> dia t
5
> dia (Node (Node Null 5 Null) 2 (Node Null 3 (Node (Node Null 6 Null) 7 (Node Null 6 (Node Null 8 (Node Null 9 Null))))))
7
```
+ [Q2.hs](./Q2.hs): `decode :: [Int] -> Btree Char -> [Char]` and `encode :: [Char] -> Btree Char -> [Int]` can be used as shown below:
```ghci
> :load ["Q2.hs"]
> ht = Node (Leaf 'a') (Node (Node (Leaf 'b') (Node (Leaf 'c') (Leaf 'd'))) (Node (Node (Leaf 'e') (Leaf 'f')) (Node  (Leaf 'g') (Leaf 'h'))))
> decode [1,1,1,1,1,1,0,0,0,1,0,1,1] ht
"head"
> decode [1,1,0,1,0,1,0,1,1] ht
"fad"
> encode ['f', 'a', 'd'] ht
[1,1,0,1,0,1,0,1,1]
> encode ['h', 'e', 'a', 'd'] ht
[1,1,1,1,1,1,0,0,0,1,0,1,1]
> encode "head" ht
[1,1,1,1,1,1,0,0,0,1,0,1,1]
> decode (encode "head" ht) ht
"head"
```
+ [Q3.hs](./Q3.hs): TBD.
+ [Q4.hs](./Q4.hs): TBD.
