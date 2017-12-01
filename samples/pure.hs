-- pure 
add :: Int -> Int -> Int
add x y = 
    x + y

-- pure : grâce à la transparence référentielle (et l'immuabilité de i)
i = 42

answer :: String -> String
answer question = 
    question ++ " is " ++ show i

-- pas pure : on lit depuis la console puis on y écrit
greetings :: IO ()
greetings =
    do 
        name <- getLine
        putStrLn ("Hello " ++ name)