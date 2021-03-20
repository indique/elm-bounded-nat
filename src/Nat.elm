module Nat exposing
    ( Nat
    , toInt
    )

{-|

@docs Nat


## transform

@docs toInt

-}

import Internal


{-| A **bounded** natural number (`>= 0`).

    -- >= 4
    Nat (Min Nat4)

    -- 2 <= nat <= 12
    Nat (In Nat2 Nat12)

    -- = 3
    Nat (Only Nat3)

    -- = 3, & 3, describes as a difference
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
    Nat.In.n nat4 |> Nat.toInt --> 4
    Nat.Min.n nat4 |> Nat.toInt --> 4

    compare a b =
        compare (Nat.toInt a) (Nat.toInt b)

-}
toInt : Nat range -> Int
toInt =
    Internal.toInt
