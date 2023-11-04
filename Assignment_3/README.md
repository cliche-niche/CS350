The program files were tested using `ghci`. Brief instructions for running have been provided below on how to use the Prolog files after loading them using the command `:load ["filename.hs"]` <i>(including the inverted commas)</i> <br>
Test cases are provided for each question in the example usages:

+ [Q1.hs](./Q1.hs): `dia t` can be used on any previously defined BTree `t` and the program will return the diameter of the given tree. Example usage:
```c
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
> dia (Node (Node (Node Null 1 Null) 3 (Node Null 2 Null)) 4 (Node Null 5 (Node Null 6 (Node Null 7 Null))))
6
> dia (Node (Node (Node Null 1 Null) 3 (Node Null 2 Null)) 4 (Node (Node Null 8 (Node Null 9 Null)) 5 (Node Null 6 (Node Null 7 Null))))
6
> dia (Node (Node (Node (Node (Node Null 12 Null) 11 Null) 1 Null) 3 (Node Null 2 Null)) 4 (Node (Node Null 8 (Node Null 9 (Node Null 10 Null))) 5 (Node Null 6 (Node Null 7 Null))))
9
```

+ [Q2.hs](./Q2.hs): It is assumed that a character will be present at most once in the whole tree, i.e., multiple paths are not possible to a single character. It is also assumed that if the tree is just a leaf, then neither decoding nor encoding is possible. <br>
`decode :: [Int] -> Btree Char -> [Char]` and `encode :: [Char] -> Btree Char -> [Int]` can be used as shown below:
```c
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
> ht = Node (Node (Node (Leaf 'p') (Leaf 'o')) (Node (Leaf 'l') (Leaf 'i'))) (Node (Leaf 't') (Node (Leaf 'k') (Node (Node (Leaf 's') (Leaf 'e')) (Leaf 'c'))))
> encode "popl" ht
[0,0,0,0,0,1,0,0,0,0,1,0]
> encode "iitk" ht
[0,1,1,0,1,1,1,0,1,1,0]
> encode "cse" ht
[1,1,1,1,1,1,1,0,0,1,1,1,0,1]
> encode "lollipop" ht 
[0,1,0,0,0,1,0,1,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0]
> encode "polici" ht
[0,0,0,0,0,1,0,1,0,0,1,1,1,1,1,1,0,1,1]
> decode [0,0,0,0,0,1,0,0,0] ht
"pop"
> decode [0,1,0,0,0,1,0,1,0] ht
"lol"
> decode [1,1,0,0,1,1,1,0,1,1,1,0,1] ht
"kite"
> decode [1,0,0,1,1,0,1,0,1,1,1,0,1] ht
"tile"
> decode [1,0,0,0,1,0,0,0] ht
"top"
> encode "kitten" ht
n is not present in the given tree
> decode [0,0,0,1,1,1] ht
Given list does not correspond to a valid string (The list likely terminates on an internal node of the tree)
```

+ [Q3.hs](./Q3.hs): Both the functions `g2b` and `b2g` work in a similar way. Some sample usages are provided below:
```c
> :load ["Q3.hs"]
> -- Example 1 used is f(g(x,l), h(l), 5) or f (g x l) (h l) 5
> g_rep = Gnode 'f' [Gnode 'g' [Gnode 'x' [ ], Gnode 'l' [ ] ], Gnode 'h' [Gnode 'l' [ ] ], Gnode '5' [ ] ]
> b_rep = Bnode (Bnode (Bnode (Leaf 'f') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Bnode (Leaf 'h') (Leaf 'l'))) (Leaf '5')
> g2b g_rep
Bnode (Bnode (Bnode (Leaf 'f') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Bnode (Leaf 'h') (Leaf 'l'))) (Leaf '5')
> b2g b_rep
Gnode 'f' [Gnode 'g' [Gnode 'x' [],Gnode 'l' []],Gnode 'h' [Gnode 'l' []],Gnode '5' []]
> g2b g_rep == b_rep && b2g b_rep == g_rep
True
> -- Example 2 used is f(h(g(x,l),v(l))) or f (h (g x l) (v l))
> g_rep = Gnode 'f' [Gnode 'h' [Gnode 'g' [Gnode 'x' [], Gnode 'l' []], Gnode 'v' [Gnode 'l' [ ]]]]
> b_rep = Bnode (Leaf 'f') (Bnode (Bnode (Leaf 'h') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Bnode (Leaf 'v') (Leaf 'l')))
> g2b g_rep
Bnode (Leaf 'f') (Bnode (Bnode (Leaf 'h') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Bnode (Leaf 'v') (Leaf 'l')))
> b2g b_rep
Gnode 'f' [Gnode 'h' [Gnode 'g' [Gnode 'x' [], Gnode 'l' []], Gnode 'v' [Gnode 'l' [ ]]]]> g2b g_rep == b_rep && b2g b_rep == g_rep
True
> -- Example 3 used is f(g(x,l), h(l), 5) or f (g x l) (h l) 5
> g_rep = Gnode 'f' [Gnode 'g' [Gnode 'x' [ ], Gnode 'l' [ ] ], Gnode 'h' [Gnode 'l' [ ] ], Gnode '5' [ ] ]
> b_rep = Bnode (Bnode (Bnode (Leaf 'f') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Bnode (Leaf 'h') (Leaf 'l'))) (Leaf '5')
> g2b g_rep
Bnode (Bnode (Bnode (Leaf 'f') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Bnode (Leaf 'h') (Leaf 'l'))) (Leaf '5')
> b2g b_rep
Gnode 'f' [Gnode 'g' [Gnode 'x' [],Gnode 'l' []],Gnode 'h' [Gnode 'l' []],Gnode '5' []]
> g2b g_rep == b_rep && b2g b_rep == g_rep
True
> -- Example 4 used is f(h(g(x, l)), 5, g(x,l)) or f (h (g x l)) 5 (g x l)
> g_rep = Gnode 'f' [Gnode 'h' [Gnode 'g' [Gnode 'x' [ ], Gnode 'l' [ ] ]], Gnode '5' [ ],  Gnode 'g' [Gnode 'x' [ ], Gnode 'l' [ ] ]]
> b_rep = Bnode (Bnode (Bnode (Leaf 'f') (Bnode (Leaf 'h') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l')))) (Leaf '5')) (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))
> g2b g_rep
Bnode (Bnode (Bnode (Leaf 'f') (Bnode (Leaf 'h') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l')))) (Leaf '5')) (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))
> b2g b_rep
Gnode 'f' [Gnode 'h' [Gnode 'g' [Gnode 'x' [ ], Gnode 'l' [ ] ]], Gnode '5' [ ],  Gnode 'g' [Gnode 'x' [ ], Gnode 'l' [ ] ]]
> g2b g_rep == b_rep && b2g b_rep == g_rep
True
> -- Example 5 used is f(g(x, h(l),l), h(3)) or f (g x (h l) l) (h 3) 
> g_rep = Gnode 'f' [Gnode 'g' [Gnode 'x' [ ], Gnode 'h' [Gnode 'l' [ ] ], Gnode 'l' [ ] ], Gnode 'h' [Gnode '3' [ ] ]]
> b_rep = Bnode (Bnode (Leaf 'f') (Bnode (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Bnode (Leaf 'h') (Leaf 'l'))) (Leaf 'l'))) (Bnode (Leaf 'h') (Leaf '3'))
> g2b g_rep
Bnode (Bnode (Leaf 'f') (Bnode (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Bnode (Leaf 'h') (Leaf 'l'))) (Leaf 'l'))) (Bnode (Leaf 'h') (Leaf '3'))
> b2g b_rep
Gnode 'f' [Gnode 'g' [Gnode 'x' [ ], Gnode 'h' [Gnode 'l' [ ] ], Gnode 'l' [ ] ], Gnode 'h' [Gnode '3' [ ] ]]
> g2b g_rep == b_rep && b2g b_rep == g_rep
True
> -- Example 6 used is f(h(g(x,l),l,v(5))) or f (h (g x l) l (v 5))
> g_rep = Gnode 'f' [Gnode 'h' [Gnode 'g' [Gnode 'x' [], Gnode 'l' []], Gnode 'l' [], Gnode 'v' [Gnode '5' [ ]]]]
> b_rep = Bnode (Leaf 'f') (Bnode (Bnode (Bnode (Leaf 'h') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Leaf 'l')) (Bnode (Leaf 'v') (Leaf '5')))
> g2b g_rep
Bnode (Leaf 'f') (Bnode (Bnode (Bnode (Leaf 'h') (Bnode (Bnode (Leaf 'g') (Leaf 'x')) (Leaf 'l'))) (Leaf 'l')) (Bnode (Leaf 'v') (Leaf '5')))
> b2g b_rep
Gnode 'f' [Gnode 'h' [Gnode 'g' [Gnode 'x' [], Gnode 'l' []], Gnode 'l' [], Gnode 'v' [Gnode '5' [ ]]]]
> g2b g_rep == b_rep && b2g b_rep == g_rep
True
```

+ [Q4.hs](./Q4.hs): Sample usage of `mkHeap` has been provided below:
```c
> :load ["Q4.hs"]
> mkHeap [1..10]
Fork 1 (Fork 2 (Fork 4 (Fork 8 Null Null) (Fork 9 Null Null)) (Fork 5 (Fork 10 Null Null) Null)) (Fork 3 (Fork 6 Null Null) (Fork 7 Null Null))
> mkHeap [1..10] == mkHTree [1..10] -- Array is already sorted; heapify does not swap any elements
True
> mkHeap (reverse [1..10])
Fork 1 (Fork 2 (Fork 3 (Fork 10 Null Null) (Fork 7 Null Null)) (Fork 6 (Fork 9 Null Null) Null)) (Fork 4 (Fork 5 Null Null) (Fork 8 Null Null))
> mkHeap ([1..5] ++ (reverse [1..5]))
Fork 1 (Fork 1 (Fork 2 (Fork 3 Null Null) (Fork 4 Null Null)) (Fork 2 (Fork 5 Null Null) Null)) (Fork 3 (Fork 5 Null Null) (Fork 4 Null Null))
> mkHeap ((reverse [1..5]) ++ [1..5])
Fork 1 (Fork 2 (Fork 3 (Fork 5 Null Null) (Fork 4 Null Null)) (Fork 4 (Fork 5 Null Null) Null)) (Fork 1 (Fork 3 Null Null) (Fork 2 Null Null))
> mkHeap ((reverse [1..7]) ++ [1..7])
Fork 1 (Fork 2 (Fork 4 (Fork 7 Null Null) (Fork 6 Null Null)) (Fork 3 (Fork 3 Null Null) (Fork 4 Null Null))) (Fork 1 (Fork 2 (Fork 5 Null Null) (Fork 6 Null Null)) (Fork 5 (Fork 7 Null Null) Null))
> mkHeap [11, 6, 3, 8, 2, 4, 2, 6, 8, 9, 3, 5, 2, 6, 0, 12, 17]
Fork 0 (Fork 2 (Fork 6 (Fork 8 (Fork 12 Null Null) (Fork 17 Null Null)) (Fork 8 Null Null)) (Fork 3 (Fork 9 Null Null) (Fork 6 Null Null))) (Fork 2 (Fork 4 (Fork 5 Null Null) (Fork 11 Null Null)) (Fork 2 (Fork 6 Null Null) (Fork 3 Null Null)))
```
