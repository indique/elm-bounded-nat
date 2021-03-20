module Nat.Min exposing
    ( abs
    , atMost, intAtLeast, atLeast
    , isIntAtLeast, is, isAtLeast, isAtMost, theGreater, theSmaller
    , n, lowerMin
    , addN, subN, add, subIn, mul, div, remainderBy, toPower
    , range
    )

{-| A Nat which is at least some minimum.


## add information

@docs abs


## clamp

@docs atMost, intAtLeast, atLeast


### compare

@docs isIntAtLeast, is, isAtLeast, isAtMost, theGreater, theSmaller


## drop information

@docs n, lowerMin


## modify

@docs addN, subN, add, subIn, mul, div, remainderBy, toPower


## extra

@docs range

-}

import Internal
import Nat exposing (Nat, toInt)
import Nat.Bound exposing (Difference, In, Is, Min, N, Only, To)
import Nat.N exposing (..)
import Nat.N.Type exposing (..)



--## drop information


{-| Convert an exact `Nat n` to a `Nat.Min n (n + a)`.

    Nat.Min.n nat4
    --> is of type Nat (Min Nat4)

-}
n : Nat (N n Is difference) -> Nat (Min n)
n nNat =
    toInt nNat |> Internal.Nat


{-| Set the minimum lower.
-}
lowerMin :
    Nat (N lowerMin Is (Difference howMuchLower To min))
    -> Nat (Min min)
    -> Nat (Min lowerMin)
lowerMin lower =
    Internal.newRange



--## add information


{-| **Cap** the `Nat (Min ...)` to at most a upper limit.

    atMost5 : Nat (Min min) -> Nat (Min Nat5)
    atMost5 =
        Nat.Min.lowerMin nat0
            >> Nat.Min.atMost (nat5 |> Nat.Min.n) { min = nat0 }

    atMost5 (nat12 |> Nat.Min.n) --> Nat 5
    atMost5 (nat3 |> Nat.Min.n) --> Nat 3

-}
atMost :
    Nat (N max Is (Difference a To maxPlusA))
    -> { min : Nat (N min Is (Difference range To max)) }
    -> Nat (Min min)
    -> Nat (In min maxPlusA)
atMost upperLimit min =
    isAtMost upperLimit
        min
        { greater = \_ -> upperLimit |> Internal.newRange
        , equalOrLess = identity
        }


{-| If the `Nat (Min ...)` is lower than a lower limit, return the lower limit instead.

    atLeast5 : Nat (Min min) -> Nat (Min Nat5)
    atLeast5 =
        Nat.Min.atLeast (nat5 |> Nat.Min.n)

    atLeast5 (nat3 |> Nat.Min.n) --> Nat 5
    atLeast5 (nat12 |> Nat.Min.n) --> Nat 12

-}
atLeast :
    Nat (Only newMin)
    -> Nat (Min min)
    -> Nat (Min newMin)
atLeast lowerLimit =
    toInt >> max (toInt lowerLimit) >> Internal.Nat


{-| The absolute value of an `Int`, which is at least `Nat0`.

    Nat.Min.abs 16 --> Nat.Min 16

    Nat.Min.abs -4 --> Nat.Min 4

Really only use this if you want the absolute value.

    badLength list =
        List.length >> Nat.Min.abs

    goodLength =
        List.foldl
            (\_ -> Nat.Min.addN nat1 >> Nat.Min.lowerMin nat0)
            (Nat.Min.n nat0)

If something like this isn't possible, use [`Nat.Min.intAtLeast`](Nat-Min#intAtLeast)`nat0`!

-}
abs : Int -> Nat (Min Nat0)
abs int =
    Basics.abs int |> Internal.Nat


{-| If the `Int >= a minimum`, `Just the Nat.Min`, else `Nothing`.

    4 |> Nat.Min.isIntAtLeast nat5 --> Nothing

    1234 |> Nat.Min.isIntAtLeast nat5 --> Just (NatIn 1234)

-}
isIntAtLeast : Nat (N min Is difference) -> Int -> Maybe (Nat (Min n))
isIntAtLeast min int =
    if int >= toInt min then
        Just (Internal.Nat int)

    else
        Nothing


{-| A `Nat.Min` from an `Int`; if the `Int < minimum`, `minimum` is returned.

    9 |> Nat.Min.intAtLeast nat3 --> Nat.Min 9

    0 |> Nat.Min.intAtLeast nat3 --> Nat.Min 3

You can also use this if you know an `Int` must be at least `minimum`.

But avoid it if you can do better, like

    goodLength =
        List.foldl
            (\_ -> Nat.Min.addN nat1 >> Nat.Min.lowerMin nat0)
            (Nat.Min.n nat0)

If you want to handle the case `< minimum` yourself, use [`Nat.Min.isIntAtLeast`](Nat-Min#isIntAtLeast).

-}
intAtLeast : Nat (N n Is difference) -> Int -> Nat (Min n)
intAtLeast minimum int =
    isIntAtLeast minimum int
        |> Maybe.withDefault (n minimum)



-- ## modify


{-| Add a `Nat.Min`. The second argument is the minimum if the added `Nat.Min`.

    (nat5 |> Nat.Min.n)
        |> Nat.Min.add atLeast2 nat2

-}
add :
    Nat (Min addedMin)
    -> Nat (N addedMin Is (Difference min To sumMin))
    -> Nat (Min min)
    -> Nat (Min sumMin)
add addedMinNat addedMin =
    Internal.map ((+) (toInt addedMinNat))


{-| Add an exact `Nat`.

    (nat5 |> Nat.Min.n)
        |> Nat.Min.addN nat2
    --> Nat.Min 7

-}
addN :
    Nat (N n Is (Difference min To minPlusN))
    -> Nat (Min min)
    -> Nat (Min minPlusN)
addN nNat =
    Internal.map ((+) (toInt nNat))


{-| Subtract a `InNat`. The second argument is the maximum if the subtracted `InNat`.

    (nat5 |> Nat.Min.n)
        |> Nat.Min.subIn inNat0To5 itsMaximum

-}
subIn :
    Nat (In subtractedMin subtractedMax)
    -> Nat (N subtractedMax Is (Difference differenceMin To min))
    -> Nat (Min min)
    -> Nat (Min differenceMin)
subIn subtractedInNat subtractedMax =
    Internal.map (\base -> base - toInt subtractedInNat)


{-| Subtract an exact `Nat`.

    (nat7 |> Nat.Min.n)
        |> Nat.Min.subN nat2
    --> Nat.Min 5

-}
subN :
    Nat (N n Is (Difference minMinusN To min))
    -> Nat (Min min)
    -> Nat (Min minMinusN)
subN nNat =
    Internal.map (\base -> base - toInt nNat)


{-| Multiply by a `Nat.Min` >= 1.
We can't compute the highest possiblenew minimum,
we only know that if `a >= 1  →  x * a >= x`

    five |> Nat.Min.mul two
    --> Nat.Min 10, but the type is Nat.Min Nat5

    two |> Nat.Min.mul five
    --> Nat.Min 10, but the type is Nat.Min Nat2

    two = nat2 |> Nat.Min.n

    five = nat5 |> Nat.Min.n

-}
mul :
    Nat (Min (Nat1Plus multipliedMinMinus1))
    -> Nat (Min min)
    -> Nat (Min min)
mul minNat =
    Internal.map ((*) (toInt minNat))


{-| Divide (`//`) by a `Nat.Min`. `div 0` is impossible.

    Nat.Min.n nat7 |> Nat.Min.div (Nat.Min.n nat3)
    --> Nat.Min 2 of type Nat.Min Nat0

-}
div :
    Nat (Min (Nat1Plus minMinus1))
    -> Nat (Min min)
    -> Nat (Min Nat0)
div minNat =
    Internal.map (\base -> base // toInt minNat)


{-| The remainder after division. `remainderBy 0` is impossible.

    Nat.Min.n nat7 |> Nat.Min.remainderBy (Nat.Min.n nat3)
    --> Nat.Min Nat0

-}
remainderBy :
    Nat (Min (Nat1Plus dMinMinus1))
    -> Nat (Min min)
    -> Nat (Min Nat0)
remainderBy minNat =
    Internal.map (Basics.remainderBy (minNat |> toInt))


{-| The `Nat.Min ^ a Nat.Min`.
We can't compute the highest possible new minimum,
we only know that if `a >= 1  →  x ^ a >= x`

    five |> Nat.Min.toPower two
    --> Nat.Min 25, but the type is Nat.Min Nat5

    two |> Nat.Min.mul five
    --> Nat.Min 25, but the type is Nat.Min Nat2

    two = nat2 |> Nat.Min.n

    five = nat5 |> Nat.Min.n

-}
toPower :
    Nat (Min (Nat1Plus minMinus1))
    -> Nat (Min min)
    -> Nat (Min min)
toPower power =
    \minNat -> toInt minNat ^ toInt power |> Internal.Nat



-- ## compare


{-| Compared to an exact `Nat`.
-}
is :
    Nat (N (Nat1Plus triedMinus1) Is (Difference (Nat1Plus aMinus1) To (Nat1Plus triedMinus1PlusA)))
    -> { min : Nat (N min Is (Difference lessRange To triedMinus1)) }
    ->
        { equal : () -> result
        , less : Nat (In min triedMinus1PlusA) -> result
        , greater : Nat (Min (Nat2Plus triedMinus1)) -> result
        }
    -> Nat (Min min)
    -> result
is tried min cases =
    \minNat ->
        case compare (toInt minNat) (toInt tried) of
            EQ ->
                .equal cases ()

            LT ->
                .less cases (toInt minNat |> Internal.Nat)

            GT ->
                .greater cases (Internal.newRange minNat)


{-| Is the `Nat (Min ...)`

  - `equalOrGreater` than a `Nat` or

  - `less`?

```
factorialHelp : Nat.Min min -> Nat.Min Nat1
factorialHelp =
    Nat.Min.lowerMin nat0
        >> Nat.Min.isAtLeast nat1
            { min = nat0 }
            { less = \_ -> Nat.Min.n nat1
            , equalOrGreater =
                \oneOrGreater ->
                    oneOrGreater
                        |> Nat.Min.mul
                            (factorialHelp
                                (oneOrGreater |> Nat.Min.subN nat1)
                            )
            }
```

-}
isAtLeast :
    Nat (N triedMin Is (Difference a To (Nat1Plus triedMinMinus1PlusA)))
    -> { min : Nat (N min Is (Difference (Nat1Plus lessRange) To triedMin)) }
    ->
        { less : Nat (In min triedMinMinus1PlusA) -> result
        , equalOrGreater : Nat (Min triedMin) -> result
        }
    -> Nat (Min min)
    -> result
isAtLeast triedLowerLimit min cases =
    \minNat ->
        if toInt minNat >= toInt triedLowerLimit then
            .equalOrGreater cases (Internal.newRange minNat)

        else
            .less cases (minNat |> Internal.newRange)


{-| Is the `Nat.Min`

  - `equalOrLess` than a `Nat` or

  - `greater`?

-}
isAtMost :
    Nat (N atMostMin Is (Difference a To atMostMinPlusA))
    -> { min : Nat (N min Is (Difference minToAtMostMin To atMostMin)) }
    ->
        { equalOrLess : Nat (In min atMostMinPlusA) -> result
        , greater : Nat (Min atMostMin) -> result
        }
    -> Nat (Min min)
    -> result
isAtMost triedUpperLimit min cases =
    \minNat ->
        if toInt minNat <= toInt triedUpperLimit then
            .equalOrLess cases (minNat |> Internal.newRange)

        else
            .greater cases (Internal.newRange minNat)


{-| The greater of 2 `Nat.Min`s. Works just like [Basics.max](Basics#max).

    Nat.Min.theGreater
        (nat3 |> Nat.Min.n)
        (nat4 |> Nat.Min.n |> Nat.Min.lowerMin nat3)
    --> Nat.Min 4

-}
theGreater : Nat (Min min) -> Nat (Min min) -> Nat (Min min)
theGreater a b =
    Basics.max (toInt a) (toInt b)
        |> Internal.Nat


{-| The smaller of 2 `Nat.Min`s. Works just like [Basics.min](Basics#min).

    Nat.Min.theSmaller
        (nat3 |> Nat.Min.n)
        (nat4 |> Nat.Min.n |> Nat.Min.lowerMin nat3)
    --> Nat.Min 3

-}
theSmaller : Nat (Min min) -> Nat (Min min) -> Nat (Min min)
theSmaller a b =
    Basics.min (toInt a) (toInt b)
        |> Internal.Nat



-- ## extra


{-| `Nat.Min`s from a first `InNat` to a last `Nat.Min`.
-}
range :
    Nat (In firstMin lastMin)
    -> Nat (Min lastMin)
    -> List (Nat (Min firstMin))
range first last =
    List.range (toInt first) (toInt last)
        |> List.map Internal.Nat
