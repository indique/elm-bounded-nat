module Nat.N exposing (add1, sub1)

{-|


## modify

@docs add1, sub1

-}

import Internal
import Nat exposing (Nat)
import Nat.Bound exposing (Difference, Is, N, To)
import Nat.N.Type exposing (..)


{-| The `NNat` plus 1.

Keep in mind that if you want add _any_ number,
rather go for [`Nat (In ...)`](Nat-In) or [`Nat (Min ...)`](Nat-Min).

-}
add1 :
    Nat (N n Is (Difference a To nPlusA))
    -> Nat (N (Nat1Plus n) Is (Difference a To (Nat1Plus nPlusA)))
add1 =
    Internal.add1


{-| The `NNat` minus 1.

Keep in mind that if you want subtract _any_ number,
rather go for [`Nat (In ...)`](Nat-Bound#In) or [`Nat (Min ...)`](Nat-Bound#Min).

-}
sub1 :
    Nat (N (Nat1Plus nMinus1) Is (Difference a To (Nat1Plus nMinus1PlusA)))
    -> Nat (N nMinus1 Is (Difference a To nMinus1PlusA))
sub1 =
    Internal.sub1
