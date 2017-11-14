-- pure 
add :: Int -> Int -> Int
add x y = x + y

-- pas pure : s'appuie sur un variable globale, on lit un état externe à la fonction
i = 42

answer :: String -> String
answer question = question ++ " is " ++ show i

-- pas pure : on lit depuis la console puis on y écrit
greetings :: IO ()
greetings =
    do 
        name <- getLine
        putStrLn ("Hello " ++ name)