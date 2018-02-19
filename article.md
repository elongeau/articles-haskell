Depuis quelques années maintenant la programmation fonctionnelle a le vent en poupe, et vous avez certainement vu votre langage favori adopter certaines particularités de la programmation fonctionnelle (pour n’en cité qu’une: les lambdas). Mais ces ajouts ne changent pas le paradigme original du langage, partons donc à l’aventure au pays des fonctions et des lambdas.

# Dis papa c’est quoi une lambda ? 

Une lambda c’est tout simplement une fonction anonyme, ça passera mieux avec un exemple:

~~~~ java
public class LambdaSample {
    public static void main(String... args) {
        final List<Integer> res = Stream.of(1, 2, 3, 4) 
                .map(x -> x * 2) 
                .collect(Collectors.toList());

        System.out.println(res);
    }
}
~~~~

Ici on utilise l’API Stream de Java 8 pour doubler chaque nombre du `Stream`. `map` applique successivement la lambda `x → x * 2` à chaque élément du `Stream`.

L’intérêt d’utiliser une lambda ici est de fournir un comportement à exécuter. Comment et quand celui-ci sera appliqué dépendra de l’appelant (ici `map`).

# Les fonctions en Haskell 

On va maintenant partir sur des exemples en [Haskell](https://www.haskell.org/). Pourquoi me direz-vous ? Haskell est un langage fonctionnel et sa syntaxe permettra de mettre en avant certains concepts de programmation fonctionnelle plus facilement qu’avec Java.

### Une valeur
~~~~ haskell
i :: Int
i = 42
-- Dans le REPL
λ> i
42
~~~~ 

### Une fonction
~~~~ haskell
f :: String -> String
f s = "Hello " ++ s
-- Dans le REPL
λ> f "World"
"Hello World"
~~~~ 

### Une fonction à plusieurs paramètres
~~~~ haskell
add :: Int -> Int -> Int
add x y = x + y
-- Dans le REPL
λ> add 1 2
3
~~~~  

### Une lambda
~~~~ haskell
\x -> x * x
-- Dans le REPL
λ> (\x -> x * x) 2
4
~~~~  

> J’utilise [ghci](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ghci.html) pour exécuter le code, c’est un REPL pour Haskell.

Haskell permet de *placer* une fonction soit avant ses paramètres (*prefix*) ou entre (*infix*). Les fonctions alphanumériques seront *prefix* et celles dont le nom est un ou des symboles seront *infix*. On peut intervertir leurs usages:

### Fonction _prefix_

#### en _prefix_

~~~~ haskell
add 1 2
~~~~

#### en _infix_

~~~~ haskell
1 `add` 2
~~~~

### Fonction _infix_

#### en _prefix_

~~~~ haskell
(+) 1 2
~~~~

#### en _infix_

~~~~ haskell
1 + 2
~~~~

# Un peu d’épice pour relever le gout ? 

On a vu comment faire une lambda à un paramètre. Et pour plusieurs paramètres ? On fait comme ceci :

~~~~ haskell
\x -> \y -> x + y
~~~~

On a une lambda qui contient une lambda. On vient ici de faire quelque chose de très intéressant, un petit indice d’abord:

~~~~ haskell
\x -> (\y -> x + y)
~~~~

Toujours pas ? Alors je viens d’isoler la lambda `\y → x + y`, ceci nous indique qu’une fonction peut en retourner une autre, on parle alors de **higher order function**. On peut se dire qu’il s’agit :

-   soit d’une fonction à **deux** paramètres retournant une valeur.

-   soit d’une fonction à **un** paramètre retournant une fonction à **un** paramètre retournant une **valeur**.

Ce dernier concept s’appelle le **currying**, il consiste à considérer qu’une fonction n’aura toujours qu’un seul paramètre et une seule valeur de retour. En fait une fonction à plusieurs paramètres c’est une fonction à un paramètre retournant une fonction à un paramètre et ainsi de suite jusqu’au résultat final.

La syntaxe Haskell permet nativement le currying :

~~~~ haskell
join :: String -> String -> String
join a b = a ++ b
~~~~

~~~~ haskell
-- on l’utilise normalement
λ> join "Hello " "World" 
"Hello World"
-- on ne passe que le premier argument et on assigne la fonction restante
λ> greetings = join "Hello " 
-- la fonction restante est String → String : c’est ce qu’on attendait (dans le REPL :t nous donne le type d’une valeur)
λ> :t greetings
greetings :: String -> String 
-- on peut utiliser la nouvelle fonction comme n’importe quelle autre
λ> greetings "FP" 
"Hello FP"
λ> greetings "Currying"
"Hello Currying"
~~~~

Lorsque l’on ne passe pas tous ces arguments à une fonction on dit qu’on l'**applique partiellement**

> Accessoirement, pour avoir une lambda à plusieurs paramètres on peut tout à fait l’écrire `\x y → x + y`, c’est juste du sucre syntaxique.

# Une fonction dans la fonction 

Vous vous souvenez du premier exemple en Java ? On passait une lambda à la fonction `map`, il s’agit aussi d’une **higher order function**: on passe une fonction comme paramètre d’une autre.

Un petit exemple en haskell bien entendu:

~~~~ haskell
λ> map (\x -> x * 2) [1,2,3]
[ 2, 4, 6 ]
~~~~

On entoure la lambda de parenthèses sinon le compilateur ne saura pas où elle s’arrête ! `[1,2,3]` est la liste d’entier.

Si vous voulez faire vos propres fonctions prenant une (ou des, soyons fous) fonction il faut feinter, regardons la signature de `map`:

~~~~ haskell
λ> :t map
map :: (a -> b) -> [a] -> [b]
~~~~

Il faut, une nouvelle fois, cerner la fonction avec des parenthèses. `map` est donc une fonction prenant une fonction (de type `a → b`) et une liste puis retourne une liste.

> Les `a` et `b` dans la signature ne sont pas des variables mais des types polymorphes, cela veut dire que l’on pourra les remplacer par n’importe quel type.

# Une fonction plus une fonction égale…​ une fonction 

Dans tout projet de développement, on cherche à faire des éléments (objet, procédure, fonction…​) petits et composables. Personnellement je vois ça comme des legos, des centaines de petites pièces qui ne peuvent rien seule, mais dès qu’on les assemble comme il faut on peut obtenir ce qu’on veut.

On peut également composer des fonctions, on a alors une nouvelle fonction:

~~~~ haskell
λ> greetings s = "Hello " ++ s
λ> reverseGreet s = (greetings . reverse) s
λ> reverseGreet "dlrow"
"Hello world"
~~~~

Ce qui nous intéresse ici c’est la fonction `(.)` (lisez *compose*), voici sa signature: `(b → c) → (a → b) → a → c`. On voit qu’elle prend en paramètres deux fonctions et une valeur et retourne une valeur de type `c`. Que se passe-t-il quand on applique une fonction *composée* ?

1.  elle passe son paramètre de type `a` à la fonction `a → b` (le deuxième paramètre de `(.)`)

2.  la valeur produite, de type `b`, est alors fourni à la fonction `b → c` qui produit le résultat final

> Pourquoi appeler la fonction de composition `(.)` ? Parce qu’en notation mathématique la composition s’écrit `∘`

L’ordre peut paraître contre intuitif, mais implémentons notre propre fonction `compose`:

~~~~ haskell
compose :: (b -> c) -> (a -> b) -> a -> c
compose g f x = g (f x)

-- à l'éxécution
λ> (compose greetings reverse) "dlrow"
"Hello world"
~~~~

Dans notre exemple, comment fait-on pour composer ? On applique `g` sur le résultat de `f x`. Si on met en parallèle les deux versions

~~~~ haskell
(g . f) x
 g ( f  x )
~~~~

*J’ai volontairement rajouté des espaces pour montrer que les paramètres sont au même endroit.*

# Libérez les paramètres 

Pour construire la fonction `reverseGreet` qu’a-t-on fait ?

~~~~ haskell
reverseGreet :: String -> String
reverseGreet s = (greetings . reverse) s
~~~~

On indique que l’on a un paramètre `s` auquel on applique la fonction (composée) `(greetings . reverse)`. Maintenant rappelez-vous deux choses:

-   le type de `(.)` c’est `(b → c) → (a → b) → a → c`

-   une fonction peut en retourner une

Donc si au lieu de dire

> `(.)` est une fonction à trois paramètres: deux fonctions et une valeur de type `a` retournant une valeur de type `c`

on disait

> `(.)` est une fonction prenant deux fonctions et retournant une fonction, comme ceci `(b → c) → (a → b) → (a → c)`

Alors on pourrait écrire `reverseGreet` comme ceci

~~~~ haskell
reverseGreet :: String -> String
reverseGreet = greetings . reverse
~~~~

Plus de paramètres ! Rien de magique là-dedans, encore moins une obscure fonctionnalité d’Haskell, quelques explications: ce qu’on veut c’est qu’en face du nom `reverseGreet` il y est une expression de type `String → String` et `greetings . reverse` convient tout à fait. Il n’y a donc pas besoin d’indiquer explicitement un paramètre.

Ce style de notation est dit [**point free**](https://wiki.haskell.org/Pointfree), on n’écrit plus les paramètres on décrit plutôt le flux de transformation des données.

# Mon framework de test à moi 

Pour finir je vous propose un mini framework de test en Haskell, histoire de montrer un cas concret:

~~~~ haskell
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

-- groupe et exécute des tests
describe :: String -> [UnitTest] -> String
describe label tests =
    let
        runTests = map (\test -> test ())
        -- exécute tous les test puis formate leur résultat
        runAll = map format . runTests $ tests
        -- ajoute le descriptif tu groupe
        report = label : runAll
    in
        -- formate le tout
        unlines report

-- génère une icone selon le résultat du test
shellIcon :: Bool -> String
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
~~~~

#### `type UnitTest =  () → (Bool, String)`

On définit un **type alias**: `UnitTest` est un synonyme pour le type `() → (Bool, String)` soit une fonction qui produira une paire contenant un `Bool` et une `String`. Le `()` est le tuple vide: un type `()` ayant pour seule valeur `()` (oui c’est troublant au début).

#### `test :: String → (() → Bool) → UnitTest`

Une valeur de type `UnitTest` doit être une fonction, la fonction `test` retourne donc une lambda. Le `let …​ in` est une expression qui permet de définir des calculs intermédiaires et de les nommer (plutôt que d’avoir un illisible *one-liner*) Vous remarquerez que pour éxecuter le test on lui passe la valeur `()`.

#### `runTests = map (\test → test ())`

On applique partiellement `map` avec juste une lambda, on obtient alors une fonction `[UnitTest] → [(Bool,String)]`. Vous avez vu ? `UnitTest` est une fonction, on peut donc également construire des listes de fonctions !

#### La fonction `($) :: (a → b) → a → b`)

Elle passe la valeur à sa droite à la fonction à sa gauche, c’est un moyen pratique d’éviter ceci : `(map format . runTests) tests`. Ici on passe la valeur `tests` à la fonction composée `map format . runTests`.

#### La fonction `(:) :: a → [a] → [a]`

Elle ajoute une valeur au début d’une liste.

#### Dans `shellIcon`

On utilise le [**pattern matching**](http://lyah.haskell.fr/syntaxe-des-fonctions#filtrage-par-motif) pour trouver l’icône à afficher

On a ici un mini-framework de test (certes limité) en quelques lignes. Vous pourrez constater qu’on se base juste sur la syntaxe et des fonctions (et du pattern matching mais difficile de s’en passer).

Ci-dessous un exemple d’exécution:

![result](result.png)

# Function for ever 

On a vu que dans un langage fonctionnel, une fonction est une valeur que l’on peut aisément manipuler. La programmation fonctionnelle propose un nouveau challenge car on change de paradigme, au délà d’apprendre une nouvelle syntaxe il faut réussir à penser en terme de fonction: quand les injecter, les composer…​

Je vous encourage vivement à apprendre la programmation fonctionnelle pour ajouter une nouvelle corde à votre arc. Même si comme moi vous n’utilisez pas un langage strictement fonctionnel au jour le jour j’espère que vous aurez une autre approche de votre code.

*Merci à la team LilleFP pour la relecture*
