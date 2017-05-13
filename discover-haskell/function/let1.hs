let1 :: Int -> Int
let1 n = let 
    a = n + 1 -- <1>
    f x = x + 2 -- <2>
    in f a -- <3>
