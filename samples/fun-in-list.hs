listOfFunction :: [(String -> String)]
listOfFunction = [
    reverse, 
    \s -> "Hello " ++ s
    ]

run = map (\f -> f "world") listOfFunction