module Nat exposing
    ( Nat
    , toInt
    , theGreater, theSmaller
    )

{-|

@docs Nat


## transform

@docs toInt


## compare

@docs theGreater, theSmaller

-}

import Internal


{-| A **bounded** natural number (`>= 0`).

    -- >= 4
    Nat (Min Nat4)

    -- 2 <= nat <= 12
    Nat (In Nat2 Nat12)

    -- = 3
    Nat (Only Nat3)

    -- = 3, & 3, described as a difference
    Nat (N Nat3 Is (Difference a To (Nat3Plus a)))

    -- either one of the above
    Nat range

    -- Not constuctable
    Nat Banana

-}
type alias Nat range =
    Internal.Nat range


{-| Convert a `Nat` to an `Int`.

    nat4 |> Nat.toInt --> 4
    Nat.N.toIn nat4 |> Nat.toInt --> 4
    Nat.N.toMin nat4 |> Nat.toInt --> 4

    compare a b =
        compare (Nat.toInt a) (Nat.toInt b)

-}
toInt : Nat range -> Int
toInt =
    Internal.toInt


{-| The greater of 2 `Nat`s. Works just like `Basics.max`.

    Nat.theGreater
        (nat3 |> Nat.N.toMin)
        (nat4 |> Nat.N.toMin |> Nat.Min.lowerMin (nat3 |> Nat.N.toIn))
    --> Nat 4

-}
theGreater : Nat range -> Nat range -> Nat range
theGreater a b =
    max (toInt a) (toInt b) |> Internal.Nat


{-| The smaller of 2 `Nat`s. Works just like `Basics.min`.

    Nat.theSmaller
        (nat3 |> Nat.N.toMin)
        (nat4 |> Nat.N.toMin |> Nat.Min.lowerMin (nat3 |> Nat.N.toIn))
    --> Nat 3

-}
theSmaller : Nat range -> Nat range -> Nat range
theSmaller a b =
    min (toInt a) (toInt b) |> Internal.Nat
