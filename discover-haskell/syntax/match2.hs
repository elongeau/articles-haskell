testMatch :: Bool -> String
testMatch bool = case bool of
  True -> "VRAI"
  _ -> "FAUX" <1>
