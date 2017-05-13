lenght :: [String] -> Int -- <1>
lenght [] = 0 -- <2>
lenght (x:xs) = 1 + lenght xs -- <3>