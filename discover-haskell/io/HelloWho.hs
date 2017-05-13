module Hello where

main = do
  name <- getLine -- <1>
  putStrLn ("Hello " ++ name ++ " !") -- <2>
