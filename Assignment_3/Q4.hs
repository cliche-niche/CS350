-- Q4
data HTree a = Null | Fork a (HTree a) (HTree a)

-- Q4(a)
-- Util for levels
-- Constructs a list from the first 2^n elements of the given list, and recurs for the remaining elements (with n+1)
level :: Int -> [a] -> [[a]]
level _ [] = []
level n xs = [take (2^n) xs] ++ level (n+1) (drop (2^n) xs)

levels :: [a] -> [[a]]
levels xs = level 0 xs

-- Q4(b)
addLayer :: [a] -> [HTree a] -> [HTree a]
-- Base Case
addLayer [] _ = []
-- Pad the given HTree list (`hts`) with two `Null`s, then take the first two elements of this list to `Fork` with `x`
-- Then recur on the remaining `xs` list after dropping the first 2 (consumed) elements from the padded list
addLayer (x : xs) hts = 
    [Fork x ((hts ++ [Null, Null]) !! 0) ((hts ++ [Null, Null]) !! 1)] ++ addLayer xs (drop 2 (hts ++ [Null, Null]))
-- addLayer (x : xs) [] = [Fork x Null Null] ++ addLayer xs []
-- addLayer (x : xs) (ht1 : []) = [Fork x ht1 Null] ++ addLayer xs []
-- addLayer (x : xs) (ht1 : ht2 : hts) = [Fork x ht1 ht2] ++ addLayer xs hts

-- Q4(c)
mkHTrees :: (Ord a) => [[a]] -> [HTree a]
mkHTrees = foldr addLayer [Null]

-- Apply mkHTrees on the list-of-list returned by `levels` and return the `head` of the list formed by `mkHTree`
mkHTree :: (Ord a) => [a] -> HTree a
mkHTree = head . mkHTrees . levels

-- Q4(d)
mkHeap :: (Ord a) => [a] -> HTree a
mkHeap = heapify . mkHTree

heapify :: (Ord a) => HTree a -> HTree a
heapify Null = Null
heapify (Fork x ht1 ht2) = sift x (heapify ht1) (heapify ht2)

-- Compare `x0` with its children `x1`, and `x2` (if present), and bring the minimum of all three upwards
-- Assumption: A node does not have a `Null` left child, without a `non-Null` right child
sift :: (Ord a) => a -> HTree a -> HTree a -> HTree a
sift x0 Null Null = Fork x0 Null Null
sift x0 (Fork x1 ht3 ht4) Null =
    if x0 <= x1 then Fork x0 (Fork x1 ht3 ht4) Null
    else Fork x1 (Fork x0 ht3 ht4) Null
sift x0 (Fork x1 ht3 ht4) (Fork x2 ht5 ht6) =
    if x0 <= min x1 x2 then Fork x0 (Fork x1 ht3 ht4) (Fork x2 ht5 ht6)
    else if x1 <= x2 then Fork x1 (Fork x0 ht3 ht4) (Fork x2 ht5 ht6)
    else Fork x2 (Fork x1 ht3 ht4) (Fork x0 ht5 ht6)