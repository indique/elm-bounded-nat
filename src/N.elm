module N exposing (And, In, Is, N, Nat(..), S, To, Z)

{-| For performance reasons, supplying the modules [`TypeNats`](TypeNats) & [`NNats`](NNats) from here to make names shorter.
-}


type Nat range
    = Nat Int


type S more
    = S Never


type Z
    = Z Never


type Is a to
    = Is Never


type And a to b
    = And Never


type To
    = To Never


type In minimum maximum maybeN
    = In Never


type alias N n isATo nPlusA asAnotherDifference =
    In n nPlusA ( isATo, asAnotherDifference )
