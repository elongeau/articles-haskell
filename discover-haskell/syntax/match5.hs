testMatch :: Maybe Int -> String
testMatch (Just x) = show x -- <1>
testMatch Nothing = "rien"
