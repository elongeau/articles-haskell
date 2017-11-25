greetings :: String -> String
greetings s = "Hello " ++ s

main :: IO () -- <1>
main = do
    name <- getLine -- <2>
    let greeted = greetings name -- <3>
    putStrLn greeted