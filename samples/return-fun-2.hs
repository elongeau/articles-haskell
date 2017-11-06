logAdd :: Int -> Int -> String -> String
logAdd x y s = 
    let
        sum = x + y
    in
        s ++ (show sum)
