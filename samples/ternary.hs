infixr 1 ? -- pour indiqué la priorité à l'opérateur '?'
(?) :: Bool -> (a, a) -> a
condition ? (ifTrue, ifFalse) = 
    if condition 
        then ifTrue 
        else ifFalse