-- on définit un type alias pour () -> (Bool, String) car ce sera plus pratique à manipuler
type UnitTest =  () -> (Bool, String) 

-- une fonction pour construire des UnitTests
test :: String -> (() -> Bool) -> UnitTest 
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

-- exécute des tests
runTests :: [UnitTest] -> [(Bool,String)]
runTests = map (\test -> test ())

-- interprète le résultat d'un test
interpret :: Bool -> String
interpret bool =
    if bool 
        then "[ OK ]"
        else "[ X  ]"
        
-- format le résultat d'un test
format :: (Bool, String) -> String
format (result, label) = "  " ++ interpret result ++ " " ++ label

-- groupe et exécute des tests
describe :: String -> [UnitTest] -> String
describe label tests =
    let
        -- exécute tous les test puis formate leur résultat
        runAll = map format . runTests $ tests
        -- ajoute le descriptif tu groupe
        report = label : runAll
    in
        -- formate le tout
        unlines report        

        
main = 
    putStrLn $ describe "addition" [
        test "1 + 1 == 2" (\() -> 1 + 1 == 2),
        test "2 + 2 == 4" (\() -> 2 + 2 == 4),
        test "2 + 1 == 4" (\() -> False)
    ]
