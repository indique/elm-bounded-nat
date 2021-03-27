module NNat exposing
    ( add1, sub1, add, sub
    , toMin, toIn
    )

{-|


## modify

@docs add1, sub1, add, sub


## drop information

@docs toMin, toIn

-}

import Internal
import NNats exposing (..)
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


{-| The `Nat (N ...)` plus another `Nat (N ...)`. Give the added value twice as a tuple.

    nat6 |> NNat.add ( nat5, nat5 )
    --> Nat 11 of type
    --> Nat
    -->     (N Nat11
    -->         (Is a To Nat11Plus a)
    -->         (Is b To Nat11Plus b)
    -->     )

This is only rarely useful, as you shouldn't

    inRangeXAndXPlus10 x =
        -- won't work
        isInRange x (x |> NNat.add ( nat10, nat10 ))

    isAtLeast10GreaterThan x =
        -- the only use case
        isAtLeast (x |> NNat.add ( nat10, nat10 ))

(examples don't compile, just for demonstration)

Using a [`Nat (In ...)`](InNat) is often the better choice.

-}
add :
    ( Nat (N addedN (Is n To sumN) x)
    , Nat (N addedN (Is aPlusN To aPlusSum) (Is bPlusN To bPlusSum))
    )
    -> Nat (N n (Is a To aPlusN) (Is b To bPlusN))
    -> Nat (N sumN (Is a To aPlusSum) (Is b To bPlusSum))
add nNatToAdd =
    Internal.add (nNatToAdd |> Tuple.first)


{-| The `Nat (N ...)` plus another `Nat (N ...)`. Give the added value twice as a tuple.

    nat6 |> NNat.sub ( nat5, nat5 )
    --> Nat 1 of type
    --> Nat
    -->     (N Nat1
    -->         (Is a To Nat1Plus a)
    -->         (Is b To Nat1Plus b)
    -->     )

This is only rarely useful, as you shouldn't

    inRangeXMinus10ToX x =
        -- won't work
        isInRange (x |> NNat.sub ( nat10, nat10 )) x

    isAtLeast10LessThan x =
        -- the only use case
        isAtLeast (x |> NNat.sub ( nat10, nat10 ))

(examples don't compile, just for demonstration)

Using a [`Nat (In ...)`](InNat) is often the better choice.

-}
sub :
    ( Nat (N subtractedN (Is differenceN To n) x)
    , Nat (N subtractedN (Is aPlusDifferenceN To aPlusN) (Is bPlusDifferenceN To bPlusN))
    )
    -> Nat (N n (Is a To aPlusN) (Is b To bPlusN))
    -> Nat (N differenceN (Is a To aPlusDifferenceN) (Is b To bPlusDifferenceN))
sub nNatToSubtract =
    Internal.sub (nNatToSubtract |> Tuple.first)


{-| Short for `add ( nat1, nat1 )`. See [add](NNat#add) on how to use it properly.
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
    add ( nat1, nat1 )


{-| Short for `sub ( nat1, nat1 )`. See [sub](NNat#sub) on how to use it properly.
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
    sub ( nat1, nat1 )
