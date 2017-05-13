testMatch :: Int -> String
testMatch bool = case bool of
  1 -> "un"
  2 -> "deux"
  3 -> "trois"
  _ -> "autre" <1>
