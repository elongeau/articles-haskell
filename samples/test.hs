type Lazy a = () -> a
type UnitTest =  Lazy (Bool, String) -- <1>

-- une fonction pour construire des UnitTests
test :: String -> (() -> Bool) -> UnitTest -- <2>
test label testFun =
    -- comme un UnitTest est une fonction on va retourner une lambda
    -- l'intérêt est de laisser le framework de test décider quand éxécuter le test
    \() ->
        let
            -- on éxécute le test
            testResult = testFun ()
        in
            -- on renvoi une paire (<résultat du test>, <description du test>)
            (testResult, label)

-- interprète le résultat d'un test
interpret :: Bool -> String -- <3>
interpret True = "✔"
interpret False = "✘"
        
color :: Bool -> String
color True = "\x1b[32m"
color False = "\x1b[31m"

-- format le résultat d'un test
format :: (Bool, String) -> String
format (result, label) = 
    let
        startColor = color result
        icon = interpret result
        resetColor = "\x1b[0m"
    in
        "  " ++ startColor ++ label ++ " " ++ icon ++ resetColor

-- groupe et exécute des tests
describe :: String -> [UnitTest] -> String
describe label tests =
    let
        runTests = map (\test -> test ()) -- <4>
        -- exécute tous les test puis formate leur résultat
        runAll = map format . runTests $ tests -- <5>
        -- ajoute le descriptif tu groupe
        report = label : runAll -- <6>
    in
        -- formate le tout
        unlines report        

        
-- On lance nos tests
main = 
    putStrLn $ describe "addition" [
        test "1 + 1 == 2" (\() -> 1 + 1 == 2),
        test "2 + 2 == 4" (\() -> 2 + 2 == 4),
        test "2 + 1 == 4" (\() -> False)
    ]
