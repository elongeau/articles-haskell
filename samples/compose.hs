compose :: (b -> c) -> (a -> b) -> a -> c
compose g f x = g (f x)