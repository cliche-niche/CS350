-- ! Testing remains, cannot print trees as of now
-- Q3
data Gtree a = Gnode a [Gtree a] 
               deriving (Show, Eq)
data Btree a = Bnode (Btree a) (Btree a) | Leaf a
               deriving (Show, Eq)

-- Utils
-- Finds the leftmost leaf in a Btree
-- Used as a util in `b2g`
leftmost :: Btree Char -> Char
leftmost (Leaf c) = c
leftmost (Bnode l _) = leftmost l

-- Picks up all the "parameters" of a function: Each node having a path of the form 
-- (L*R - Any number of L childs followed by a single R child) is a parameter
-- Used as a util in `b2g`  
params :: Btree Char -> [Btree Char]
params (Leaf _) = []
params (Bnode l r) = params l ++ [r]

-- Q3(a)
g2b :: Gtree Char -> Btree Char
-- Base Case
g2b (Gnode c []) = Leaf c
-- Last parameter is the right child, left child is made by recurring on the remaining params and the function
-- Omitting the last parameter and recurring on remaining params can be justified by "currying"
g2b (Gnode c gts) = Bnode (g2b (Gnode c (take (length gts - 1) gts))) (g2b (gts !! (length gts - 1)))

-- Q3(b)
b2g :: Btree Char -> Gtree Char
-- Base Case
b2g (Leaf c) = Gnode c []
-- Gnode has the name of the function (leftmost leaf), and a list of parameters (params l ++ right child of current node)
-- Need to recursively convert all parameter nodes to Gtree, hence `b2g` has been mapped onto the list
b2g (Bnode l r) = Gnode (leftmost l) (map b2g (params l ++ [r]))