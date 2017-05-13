data SuperType = StringHolder String
    | IntWrapper Int

customMatch :: SuperType -> String
customMatch (StringHolder s) = s
customMatch (IntWrapper i) = "contains " ++ show i