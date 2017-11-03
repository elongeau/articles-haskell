fs :: [(String -> String)]
fs = [
    reverse, 
    \s -> "Hello " ++ s
    ]

run = map (\f -> f "world") fs