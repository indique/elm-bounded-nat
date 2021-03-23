module N exposing (S, Z)

{-| For performance reasons, supplying the module [`Nat.N.Type`](Nat-N#Type) from here to make names shorter.
-}


type S more
    = S Never


type Z
    = Z Never
