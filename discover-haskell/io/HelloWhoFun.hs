module Main where

greeting :: String -> IO () -- <1>
greeting name = putStrLn ("Hello " ++ name)

main = do
  name <- getLine
  greeting name
