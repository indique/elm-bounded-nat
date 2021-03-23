module Nat exposing
    ( Nat
    , toInt, bi
    , theGreater, theSmaller
    )

{-|

@docs Nat


## transform

@docs toInt, bi


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
    nat4 |> Nat.N.toIn |> Nat.toInt --> 4
    nat4 |> Nat.N.toMin |> Nat.toInt --> 4

    compare : Nat range -> Nat range -> Order
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
    if bi (>) a b then
        a

    else
        b


{-| The smaller of 2 `Nat`s. Works just like `Basics.min`.

    Nat.theSmaller
        (nat3 |> Nat.N.toMin)
        (nat4 |> Nat.N.toMin |> Nat.Min.lowerMin (nat3 |> Nat.N.toIn))
    --> Nat 3

-}
theSmaller : Nat range -> Nat range -> Nat range
theSmaller a b =
    if bi (<) a b then
        a

    else
        b


{-| Use the `Int` values of two `Nat`s to return a result.

    Nat.bi (>=) nat5 nat4 --> True

    Nat.bi (>=) nat5 nat40 --> False

Note, that you must give the `Nat`s in the same order you would give `Int`s.

Don't overuse this.

-}
bi :
    (Int -> Int -> result)
    -> Nat aRange
    -> Nat bRange
    -> result
bi op a b =
    op (toInt a) (toInt b)
