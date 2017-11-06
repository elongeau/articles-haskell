repeatMe :: (Show b) => (a -> b) -> a -> Int -> IO ()
repeatMe f value count = do 
    print (f value) -- <1>
    if count > 1
    then
        repeatMe f value (count - 1) -- <2>
    else
        return () -- <3>