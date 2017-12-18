type UnitTest =  () -> (Bool, String) -- <1>

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

-- groupe et exécute des tests
describe :: String -> [UnitTest] -> String
describe label tests =
    let
        runTests = map (\test -> test ()) -- <3>
        -- exécute tous les test puis formate leur résultat
        runAll = map format . runTests $ tests -- <4>
        -- ajoute le descriptif tu groupe
        report = label : runAll -- <5>
    in
        -- formate le tout
        unlines report        

-- génère une icone selon le résultat du test
shellIcon :: Bool -> String -- <6>
shellIcon True  = "✔"
shellIcon False = "✘"
        
shellColor :: Bool -> String
shellColor True  = "\x1b[32m"
shellColor False = "\x1b[31m"

-- formate le résultat d'un test
format :: (Bool, String) -> String
format (result, label) = 
    let
        startColor = shellColor result
        icon = shellIcon result
        resetColor = "\x1b[0m"
    in
        "  " ++ startColor ++ label ++ " " ++ icon ++ resetColor
        
-- On lance nos tests
main = 
    putStrLn $ describe "addition" [
        test "1 + 1 == 2" (\() -> 1 + 1 == 2),
        test "2 + 2 == 4" (\() -> 2 + 2 == 4),
        test "2 + 1 == 4" (\() -> False)
    ]
