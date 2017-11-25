repeatMe :: (Int -> String) -> Int -> IO ()
repeatMe f count = do 
    -- f est la fonction passée en paramètre
    -- on lui passe le compteur et on écrit le résultat sur la console
    print (f count) 
    if count > 1
    then
        -- on rappelle repeatMe avec les mêmes arguments sauf le compteur décrémenté
        repeatMe f (count - 1) 
    else
        -- si on a fini de répeter on s'arrête
        return () 