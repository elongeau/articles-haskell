data Language = Java | Scala | Haskell
data Developer = Functional | Imperative

f :: Developer -> Language -> String
f Imperative Java = "Je code du Java avec le style Imperatif" -- <1>
f Imperative Scala = "Je code du Scala avec le style Imperatif" -- <2>
f Functional _ = "J'aime le fonctionnel, je code dans tous les languages" -- <3>
f _ _ = "Je ne pense pas que ce soit possible" -- <4>