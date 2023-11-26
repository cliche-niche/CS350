-- Q1
data BTree a = Node (BTree a) a (BTree a)
             |   Null
             deriving (Show)

-- Finds height of a BTree
-- Used as a util in `dia`
height :: BTree a -> Int
height Null = 0
height (Node l _ r) = 1 + max (height l) (height r)

dia :: BTree a -> Int
-- Base Case
dia Null = 0
-- Other Cases
dia (Node l _ r) = max (1 + height l + height r) (max (dia l) (dia r))
-- If the diameter contains the root, the first argument will be picked up by `max`
-- -- In this case, 1 is added for the root, `height` is used 
-- -- for maximum number of nodes in a path to a leaf from the root
-- If the diameter does not contain the root, the second argument will be picked by `max`
