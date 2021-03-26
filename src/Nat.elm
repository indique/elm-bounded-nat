module Nat exposing
    ( Nat
    , abs
    , toInt, bi
    , theGreater, theSmaller
    , isIntInRange, isIntAtLeast
    , intAtLeast, intInRange
    )

{-|

@docs Nat


## from `Int`

@docs abs


## transform

@docs toInt, bi


## compare

@docs theGreater, theSmaller
@docs isIntInRange, isIntAtLeast


### clamp

@docs intAtLeast, intInRange

-}

import Internal
import Nat.Bound exposing (In, Min)
import Nat.N.Type exposing (..)


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
    nat4 |> NNat.toIn |> Nat.toInt --> 4
    nat4 |> NNat.toMin |> Nat.toInt --> 4

    compare : Nat range -> Nat range -> Order
    compare a b =
        compare (Nat.toInt a) (Nat.toInt b)

-}
toInt : Nat range -> Int
toInt =
    Internal.toInt


{-| The absolute value of an `Int`, which is at least `Nat0`.

    MinNat.abs 16 --> Nat 16

    MinNat.abs -4 --> Nat 4

Really only use this if you want the absolute value.

    badLength list =
        List.length >> MinNat.abs

    goodLength =
        List.foldl
            (\_ ->
                MinNat.addN nat1
                    >> InNat.lowerMin (nat0 |> NNat.toIn)
            )
            (nat0 |> NNat.toMin)

If something like this isn't possible, use [`MinNat.intAtLeast`](MinNat#intAtLeast)!

-}
abs : Int -> Nat (Min Nat0)
abs int =
    Basics.abs int |> Internal.Nat


{-| The greater of 2 `Nat`s. Works just like `Basics.max`.

    Nat.theGreater
        (nat3 |> NNat.toMin)
        (nat4 |> NNat.toMin |> MinNat.lowerMin (nat3 |> NNat.toIn))
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
        (nat3 |> NNat.toMin)
        (nat4 |> NNat.toMin |> MinNat.lowerMin (nat3 |> NNat.toIn))
    --> Nat 3

-}
theSmaller : Nat range -> Nat range -> Nat range
theSmaller a b =
    if bi (<) a b then
        a

    else
        b


{-| An `Int` compared to a range from `first` to `last`.

    rejectOrAcceptUserInt =
        isIntInRange (nat1 |> NNat.toIn) (nat100 |> NNat.toIn)
            { less = Err "must be >= 1"
            , greater = \_-> Err "must be <= 100"
            , inRange = Ok
            }

    rejectOrAcceptUserInt (NNat.toIn nat0)
    --> Err "must be >= 1"

-}
isIntInRange :
    { first : Nat (In minFirst last)
    , last : Nat (In last lastPlusA)
    }
    ->
        { less : () -> result
        , greater : Nat (Min (Nat1Plus last)) -> result
        , inRange : Nat (In minFirst lastPlusA) -> result
        }
    -> Int
    -> result
isIntInRange interval cases int =
    Internal.isIntInRange interval cases int


{-| A `Nat (In ...)` from an `Int`, **clamped** between a minimum & maximum.

  - if the `Int < minimum`, `minimum` is returned
  - if the `Int > maximum`, `maximum` is returned

```
clampBetween3And12 =
    Nat.intInRange (nat3 |> NNat.toIn) (nat12 |> NNat.toIn)

9 |> clampBetween3And12 --> Nat 9

0 |> clampBetween3And12 --> Nat 3

99 |> clampBetween3And12 --> Nat 12
```

If you want to handle the cases `< minimum` & `> maximum` explicitly, use [`isIntInRange`](InNat#isIntInRange).

-}
intInRange :
    Nat (In min firstMax)
    -> Nat (In firstMax max)
    -> Int
    -> Nat (In min max)
intInRange lowerLimit upperLimit =
    Internal.intInRange lowerLimit upperLimit


{-| If the `Int >= a minimum`, `Just` the `Nat (Min minimum)`, else `Nothing`.

    4 |> Nat.isIntAtLeast (nat5 |> NNat.toIn) --> Nothing

    1234 |> Nat.isIntAtLeast (nat5 |> NNat.toIn) --> Just (Nat 1234)

-}
isIntAtLeast : Nat (In min max) -> Int -> Maybe (Nat (Min min))
isIntAtLeast minimum int =
    if int >= toInt minimum then
        Just (Internal.Nat int)

    else
        Nothing


{-| A `Nat (Min ...)` from an `Int`; if the `Int < minimum`, `minimum` is returned.

    9 |> Nat.intAtLeast (nat3 |> NNat.toMin)
    --> Nat 9

    0 |> Nat.intAtLeast (nat3 |> NNat.toMin)
    --> Nat 3

You can also use this if you know an `Int` must be at least `minimum`.

But avoid it if you can do better, like

    goodLength =
        List.foldl
            (\_ ->
                MinNat.addN nat1
                    >> InNat.lowerMin (nat0 |> NNat.toIn)
            )
            (nat0 |> NNat.toMin)

If you want to handle the case `< minimum` yourself, use [`Nat.isIntAtLeast`](Nat#isIntAtLeast).

-}
intAtLeast : Nat (In min max) -> Int -> Nat (Min min)
intAtLeast minimum =
    isIntAtLeast minimum
        >> Maybe.withDefault (Internal.dropMax minimum)


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
