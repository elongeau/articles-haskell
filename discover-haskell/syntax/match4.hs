testMatch :: Bool -> Int -> String
testMatch True 1 = "VRAI - 1"
testMatch True 0 = "VRAI - 0"
testMatch False 0 = "FAUX - 0"
testMatch _ _ = "WHAT ?!"
