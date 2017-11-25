logAdd :: Int -> Int -> (String -> String)
logAdd x y = 
    let
        sum = x + y
    in
        \s -> s ++ (show sum)
