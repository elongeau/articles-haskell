repeatMe :: (Int -> String) -> Int -> IO ()
repeatMe f count = do 
    print (f count) -- <1>
    if count > 1
    then
        repeatMe f (count - 1) -- <2>
    else
        return () -- <3>