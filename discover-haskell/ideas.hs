data Foo = Bar String | Baz Int

f :: Baz -> Int
f (Baz i) = i