data Movie = ScienceFiction {title :: String}
            | Comedy {actors :: [String]}
            deriving Show

test (ScienceFiction title) = "The best movie ever is " ++ title
test (Comedy actors) = "a comedy movie with " ++ (show actors)
