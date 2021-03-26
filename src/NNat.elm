module NNat exposing
    ( add1, sub1
    , toMin, toIn
    )

{-|


## modify

@docs add1, sub1


## drop information

@docs toMin, toIn

-}

import Internal
import Nat exposing (Nat)
import Nat.Bound exposing (..)
import Nat.N.Type exposing (..)


{-| Convert an exact `Nat (N n ...)` to a `Nat (Min n)`.

    nat4 |> NNat.toMin
    --> is of type Nat (Min Nat4)

There is **only 1 situation you should use this.**

To make 2 `Nat`s of the same type.

    [ atLeast1, NNat.toIn nat1 ]

Elm complains:

> But all the previous elements in the list are: `Nat (In Nat1 Infinity)`

    [ atLeast1
    , NNat.toMin nat4
    ]

-}
toMin : Nat (N n x y) -> Nat (Min n)
toMin =
    Internal.newRange


{-| A `Nat (In ...)` from an exact `Nat (N n ...)`.

The minimum is `n`, the maximum `>= n`.

-}
toIn :
    Nat (N n (Is a To nPlusA) x)
    -> Nat (In n nPlusA)
toIn =
    Internal.newRange


{-| The `Nat (N ...)` plus 1.

Keep in mind that if you want add _any_ number,
rather go for [`Nat (In ...)`](InNat) or [`Nat (Min ...)`](MinNat).

-}
add1 :
    Nat (N n (Is a To nPlusA) (Is b To nPlusB))
    ->
        Nat
            (N
                (Nat1Plus n)
                (Is a To (Nat1Plus nPlusA))
                (Is b To (Nat1Plus nPlusB))
            )
add1 =
    Internal.add1


{-| The `Nat (N ...)` minus 1.

Keep in mind that if you want subtract _any_ number,
rather go for [`Nat (In ...)`](Nat-Bound#In) or [`Nat (Min ...)`](Nat-Bound#Min).

-}
sub1 :
    Nat
        (N
            (Nat1Plus nMinus1)
            (Is a To (Nat1Plus nMinus1PlusA))
            (Is b To (Nat1Plus nMinus1PlusB))
        )
    -> Nat (N nMinus1 (Is a To nMinus1PlusA) (Is b To nMinus1PlusB))
sub1 =
    Internal.sub1
