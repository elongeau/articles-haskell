mySum :: Num a => [a] -> a
mySum [] = 0 -- <1>
mySum (x:xs) = x + (mySum xs) -- <2>
