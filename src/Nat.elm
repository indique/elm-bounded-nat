module Nat exposing
    ( Nat
    , abs, range, random
    , toInt, bi
    , theGreater, theSmaller
    , isIntInRange, isIntAtLeast
    , intAtLeast, intInRange
    )

{-|

@docs Nat


## create

@docs abs, range, random


## transform

@docs toInt, bi


## compare

@docs theGreater, theSmaller
@docs isIntInRange, isIntAtLeast


### clamp

@docs intAtLeast, intInRange

-}

import Internal
import Nat.Bound exposing (In, ValueIn, ValueMin)
import Random
import TypeNats exposing (..)


{-| A **bounded** natural number (`>= 0`).


## value / return types

    -- >= 4
    Nat (ValueMin Nat4)

    -- 2 <= nat <= 12
    Nat (ValueIn Nat2 Nat12)

    -- = 3, & 3, described as a difference
    Nat (N Nat3 (Nat3Plus more) (Is a To (Nat3Plus a)) (Is b To (Nat3Plus b)))


## function argument types

    -- >= 4
    Nat (In (Nat4Plus minMinus4) max maybeN)

    -- 4 <= nat <= 5
    Nat (In (Nat4Plus minMinus4) Nat15 maybeN)

    -- any, just >= 0
    Nat range

    -- Not constuctable
    Nat Banana

-}
type alias Nat range =
    Internal.Nat range


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
                    >> InNat.lowerMin nat0
            )
            (nat0 |> NNat.toMin)

If something like this isn't possible, use [`MinNat.intAtLeast`](MinNat#intAtLeast)!

-}
abs : Int -> Nat (ValueMin Nat0)
abs int =
    Basics.abs int |> Internal.Nat


{-| `Nat (In ...)`s from a first to a last value.

    from3To10 : List (Nat (ValueIn Nat3 (Nat10Plus a)))
    from3To10 =
        InNat.range nat3 nat10

    from3ToAtLeast10 : List (Nat (ValueMin Nat3))
    from3ToAtLeast10 =
        InNat.range nat3 atLeast10

The resulting `List` is never empty.

-}
range :
    Nat (In firstMin lastMin firstMaybeN)
    -> Nat (In lastMin lastMax lastMaybeN)
    -> List (Nat (ValueIn firstMin lastMax))
range first last =
    bi List.range first last
        |> List.map Internal.Nat


{-| Generate a random `Nat (In ...)` in a range.
-}
random :
    Nat (In firstMin lastMin firstMaybeN)
    -> Nat (In lastMin lastMax lastMaybeN)
    -> Random.Generator (Nat (ValueIn firstMin lastMax))
random min max =
    bi Random.int min max
        |> Random.map Internal.Nat


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


{-| The greater of 2 `Nat`s. Works just like `Basics.max`.

    Nat.theGreater atLeast3
        (atLeast4 |> InNat.lowerMin nat3)
    --> Nat 4

-}
theGreater : Nat range -> Nat range -> Nat range
theGreater a b =
    if bi (>) a b then
        a

    else
        b


{-| The smaller of 2 `Nat`s. Works just like `Basics.min`.

    Nat.theSmaller atLeast3
        (atLeast4 |> InNat.lowerMin nat3)
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
        isIntInRange nat1 nat100
            { less = Err "must be >= 1"
            , greater = \_-> Err "must be <= 100"
            , inRange = Ok
            }

    rejectOrAcceptUserInt (NNat.toIn nat0)
    --> Err "must be >= 1"

-}
isIntInRange :
    { first : Nat (In minFirst last firstMaybeN)
    , last : Nat (In last lastPlusA lastMaybeN)
    }
    ->
        { less : () -> result
        , greater : Nat (ValueMin (Nat1Plus last)) -> result
        , inRange : Nat (ValueIn minFirst lastPlusA) -> result
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
    Nat.intInRange nat3 nat12

9 |> clampBetween3And12 --> Nat 9

0 |> clampBetween3And12 --> Nat 3

99 |> clampBetween3And12 --> Nat 12
```

If you want to handle the cases `< minimum` & `> maximum` explicitly, use [`isIntInRange`](InNat#isIntInRange).

-}
intInRange :
    Nat (In min firstMax maybeN)
    -> Nat (In firstMax max upperMaybeN)
    -> Int
    -> Nat (ValueIn min max)
intInRange lowerLimit upperLimit =
    Internal.intInRange lowerLimit upperLimit


{-| If the `Int >= a minimum`, `Just` the `Nat (Min minimum)`, else `Nothing`.

    4 |> Nat.isIntAtLeast nat5 --> Nothing

    1234 |> Nat.isIntAtLeast nat5 --> Just (Nat 1234)

-}
isIntAtLeast :
    Nat (In min max maybeN)
    -> Int
    -> Maybe (Nat (ValueMin min))
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
                    >> InNat.lowerMin nat0
            )
            (nat0 |> InNat.toMin)

If you want to handle the case `< minimum` yourself, use [`Nat.isIntAtLeast`](Nat#isIntAtLeast).

-}
intAtLeast :
    Nat (In min max maybeN)
    -> Int
    -> Nat (ValueMin min)
intAtLeast minimum =
    isIntAtLeast minimum
        >> Maybe.withDefault (Internal.toMin minimum)


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
