module NNat exposing
    ( add, sub
    , toIn
    )

{-| Operations that only apply for `Nat (N ...)`s.


## modify

@docs add, sub


## drop information

@docs toIn

Operations, where the maximum doesn't matter are in `MinNat`, as they apply for `Nat (ValueMin ...)`s as well.

-}

import Internal
import NNats exposing (..)
import Nat exposing (Nat)
import Nat.Bound exposing (..)
import TypeNats exposing (..)


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

-}
add :
    ( Nat
        (N
            addedN
            atLeastAddedN
            (Is n To sumN)
            (Is atLeastN To atLeastSumN)
        )
    , Nat
        (N
            addedN
            atLeastAddedN
            (Is aPlusN To aPlusSum)
            (Is bPlusN To bPlusSum)
        )
    )
    -> Nat (N n atLeastN (Is a To aPlusN) (Is b To bPlusN))
    ->
        Nat
            (N
                sumN
                atLeastSumN
                (Is a To aPlusSum)
                (Is b To bPlusSum)
            )
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

-}
sub :
    ( Nat
        (N
            subN
            atLeastSubN
            (Is differenceN To n)
            (Is atLeastDifferenceN To atLeastN)
        )
    , Nat
        (N
            subN
            atLeastSubN
            (Is aPlusDifferenceN To aPlusN)
            (Is bPlusDifferenceN To bPlusN)
        )
    )
    -> Nat (N n atLeastN (Is a To aPlusN) (Is b To bPlusN))
    ->
        Nat
            (N
                differenceN
                atLeastDifferenceN
                (Is a To aPlusDifferenceN)
                (Is b To bPlusDifferenceN)
            )
sub nNatToSubtract =
    Internal.sub (nNatToSubtract |> Tuple.first)



-- ## drop information


{-| Convert it to a `Nat (ValueIn min max)`.

    nat4 |> NNat.toIn
    --> is of type Nat (ValueIn Nat4 (Nat4Plus a))

There is **only 1 situation you should use this.**

To make these the same type.

    [ in3To10, nat3 ]

Elm complains:

> But all the previous elements in the list are: `Nat (ValueIn Nat3)`

    [ in3To10
    , nat3 |> NNat.toIn
    ]

-}
toIn : Nat (In min max maybeN) -> Nat (ValueIn min max)
toIn =
    Internal.toIn
