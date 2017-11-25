repeatMe  :: (Show b) => (a -> b) -> a -> Int -> IO ()
repeatMe f value 1 = print (f value)
repeatMe f value count = do 
    print (f value)
    repeatMe f value (count - 1)