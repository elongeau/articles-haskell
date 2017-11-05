repeatMe :: (Show b) => (a -> b) -> a -> Int -> IO ()
repeatMe f value count = do 
    print (f value)
    if count > 1
    then
        repeatMe f value (count - 1)
    else
        return ()