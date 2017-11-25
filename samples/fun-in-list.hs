-- une liste de fonction String -> String
listOfFunction :: [String -> String]
listOfFunction = 
    [
        reverse, -- inverse une String
        \s -> "Hello " ++ s -- préfixe une String avec "Hello "
    ]

run = map (\f -> f "world") listOfFunction