-- Q2
-- Assumption: A character is present in atmost one leaf, i.e., multiple paths from the root to a character are not possible.
data Btree a = Node (Btree a) (Btree a) | Leaf a

-- Utils
-- Checks if the given character is present in the tree or not 
-- Used as a util in `path`
present :: Btree Char -> Char -> Bool 
present (Leaf c') c = c == c'
present (Node l r) c = present l c || present r c

-- Returns a path (list of Ints, specifically 0s and 1s) to the character from the root
-- Used as a util in both `decode` and `encode`
path :: Btree Char -> Char -> [Int]
path (Leaf c') c = []
path (Node l r) c = 
    if present l c then [0] ++ path l c
    else if present r c then [1] ++ path r c
    else error ([c] ++ " is not present in the given tree")

-- Finds the first character in the tree corresponding to the given list
-- Used as a util in `decode`
firstchar :: [Int] -> Btree Char -> Char
-- Base Case: A character has been found in the tree
firstchar _ (Leaf c) = c
-- Base Case: List terminates in the middle of the tree (on an internal node)
firstchar [] _ = error "Given list does not correspond to a valid string (The list likely terminates on an internal node of the tree)"
-- Traverse the tree according to the list
firstchar (x:xs) (Node l r) = 
    if x == 0 then firstchar xs l
    else if x == 1 then firstchar xs r
    else error "Given list does not correspond to a valid string (The list likely has an Int other than 0/1)" 


-- Q2(a)
decode :: [Int] -> Btree Char -> [Char]
-- Base Case
decode [] _ = []
-- Finds the first character, drops all the nodes (0s and 1s) corresponding to it, and recurs on the remaining list
decode xs ht = [firstchar xs ht] ++ decode (drop (length (path ht (head (decode xs ht)))) xs) ht

-- Q2(b)
-- Concatenates paths from the root to each character in the given [Char].
encode:: [Char] -> Btree Char -> [Int]
encode cs ht = [x | xs <- map (path ht) cs, x <- xs]
