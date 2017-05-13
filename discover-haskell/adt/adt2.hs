data Fruit = Apple -- <1>
            | Banana
            | Orange
            deriving Show

data Movie = ScienceFiction {title :: String} -- <2>
            | Comedy {actors :: [String]}
            deriving Show

main = do
        print (Apple)
        print (ScienceFiction "Star Wars")
