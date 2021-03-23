module Nat.Min exposing
    ( abs
    , atMost, intAtLeast, atLeast
    , isIntAtLeast, is, isAtLeast, isAtMost
    , lowerMin
    , addN, subN, add, subIn, mul, div, remainderBy, toPower, addLossy, subInLossy
    , range
    )

{-| A Nat which is at least some minimum.


## add information

@docs abs


## clamp

@docs atMost, intAtLeast, atLeast


### compare

@docs isIntAtLeast, is, isAtLeast, isAtMost


## drop information

@docs lowerMin


## modify

@docs addN, subN, add, subIn, mul, div, remainderBy, toPower, addLossy, subInLossy


## extra

@docs range

-}

import Internal
import Nat exposing (Nat, toInt)
import Nat.Bound exposing (In, Is, Min, N, To)
import Nat.N.Type exposing (..)
import Nat.Ns exposing (..)



--## drop information


{-| Set the minimum lower.

    [ Nat.N.toMin nat3, Nat.N.toMin nat4 ]

Elm complains:

> But all the previous elements in the list are: `Nat (Min Nat3)`

    [ Nat.N.toMin nat3
    , Nat.N.toMin nat4 |> Nat.Min.lowerMin (nat3 |> Nat.N.toIn)
    ]

-}
lowerMin :
    Nat (In lowerMin min)
    -> Nat (Min min)
    -> Nat (Min lowerMin)
lowerMin =
    \_ -> Internal.newRange



--## add information


{-| **Cap** the `Nat (Min ...)` to at most a upper limit.

    atMost5 : Nat (Min min) -> Nat (Min Nat5)
    atMost5 =
        Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
            >> Nat.Min.atMost (nat5 |> Nat.N.toMin) { min = nat0 }

    atMost5 (nat12 |> Nat.N.toMin) --> Nat 5
    atMost5 (nat3 |> Nat.N.toMin) --> Nat 3

-}
atMost :
    Nat (In max maxPlusA)
    -> { min : Nat (N min (Is range To max)) }
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
        Nat.Min.atLeast (nat5 |> Nat.N.toMin)

    atLeast5 (nat3 |> Nat.N.toMin) --> Nat 5
    atLeast5 (nat12 |> Nat.N.toMin) --> Nat 12

-}
atLeast :
    Nat (Min newMin)
    -> Nat (Min min)
    -> Nat (Min newMin)
atLeast lowerLimit =
    Internal.map (max (toInt lowerLimit))


{-| The absolute value of an `Int`, which is at least `Nat0`.

    Nat.Min.abs 16 --> Nat 16

    Nat.Min.abs -4 --> Nat 4

Really only use this if you want the absolute value.

    badLength list =
        List.length >> Nat.Min.abs

    goodLength =
        List.foldl
            (\_ ->
                Nat.Min.addN nat1
                    >> Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
            )
            (Nat.N.toMin nat0)

If something like this isn't possible, use [`Nat.Min.intAtLeast`](Nat-Min#intAtLeast)!

-}
abs : Int -> Nat (Min Nat0)
abs int =
    Basics.abs int |> Internal.Nat


{-| If the `Int >= a minimum`, `Just` the `Nat (Min minimum)`, else `Nothing`.

    4 |> Nat.Min.isIntAtLeast nat5 --> Nothing

    1234 |> Nat.Min.isIntAtLeast nat5 --> Just (Nat 1234)

-}
isIntAtLeast : Nat (Min min) -> Int -> Maybe (Nat (Min min))
isIntAtLeast minimum int =
    if int >= toInt minimum then
        Just (Internal.Nat int)

    else
        Nothing


{-| A `Nat (Min ...)` from an `Int`; if the `Int < minimum`, `minimum` is returned.

    9 |> Nat.Min.intAtLeast nat3 --> Nat 9

    0 |> Nat.Min.intAtLeast nat3 --> Nat 3

You can also use this if you know an `Int` must be at least `minimum`.

But avoid it if you can do better, like

    goodLength =
        List.foldl
            (\_ ->
                Nat.Min.addN nat1
                    >> Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
            )
            (Nat.N.toMin nat0)

If you want to handle the case `< minimum` yourself, use [`Nat.Min.isIntAtLeast`](Nat-Min#isIntAtLeast).

-}
intAtLeast : Nat (Min min) -> Int -> Nat (Min min)
intAtLeast minimum =
    isIntAtLeast minimum
        >> Maybe.withDefault minimum



-- ## modify


{-| Add a `Nat (Min ...)`. The second argument is the minimum if the added `Nat (Min ...)`.

    nat5
        |> Nat.N.toMin
        |> Nat.Min.add atLeast2 nat2
    --> is of type Nat (Min Nat7)

If you have don't the minimum added value at hand, use [`addLossy`](Nat-Min#addLossy).

-}
add :
    Nat (Min addedMin)
    -> Nat (N addedMin (Is min To sumMin))
    -> Nat (Min min)
    -> Nat (Min sumMin)
add addedMinNat addedMin =
    Internal.map ((+) (toInt addedMinNat))


{-| Add a `Nat (Min ...)`. The second argument is the minimum if the added `Nat (Min ...)`.

    atLeast5 |> Nat.Min.addLossy atLeast2
    --> is of type Nat (Min Nat5)

    atLeast2 |> Nat.Min.addLossy atLeast5
    --> is of type Nat (Min Nat2)

If you have the minimum added value at hand, use [`add`](Nat-Min#add).

-}
addLossy :
    Nat (Min addedMin)
    -> Nat (Min min)
    -> Nat (Min min)
addLossy addedMinNat =
    Internal.map ((+) (toInt addedMinNat))


{-| Add an exact `Nat (N ...)`.

    atLeast5 |> Nat.Min.addN nat2
    --> is of type Nat (Min Nat7)

-}
addN :
    Nat (N added (Is min To sumMin))
    -> Nat (Min min)
    -> Nat (Min sumMin)
addN nNat =
    Internal.map ((+) (toInt nNat))


{-| Subtract a `Nat (In ...)`. The second argument is the maximum if the subtracted `Nat (In ...)`.

    atLeast6 |> Nat.Min.subIn inNat0To5 nat5
    --> is of type Nat (Min Nat1)

If you have don't the maximum subtracted value at hand, use [`subInLossy`](Nat-Min#subInLossy).

-}
subIn :
    Nat (In subtractedMin subtractedMax)
    -> Nat (N subtractedMax (Is differenceMin To min))
    -> Nat (Min min)
    -> Nat (Min differenceMin)
subIn subtractedInNat subtractedMax =
    Internal.map (\x -> x - toInt subtractedInNat)


{-| Subtract a `Nat (In ..)` safely, but without calculating the new minimum.

    nat6 |> Nat.N.toMin
        |> Nat.In.subInLossy between1And5
    --> is of type Nat (Min Nat0)

If you have the maximum subtracted value at hand, use [`sub`](Nat-Min#sub).

-}
subInLossy :
    Nat (In subtractedMin min)
    -> Nat (Min min)
    -> Nat (Min Nat0)
subInLossy subtractedInNat =
    Internal.map (\x -> x - toInt subtractedInNat)


{-| Subtract an exact `Nat`.

    (nat7 |> Nat.N.toMin)
        |> Nat.Min.subN nat2
    --> is of type Nat (Min Nat5)

-}
subN :
    Nat (N subtracted (Is differenceMin To min))
    -> Nat (Min min)
    -> Nat (Min differenceMin)
subN nNat =
    Internal.map (\base -> base - toInt nNat)


{-| Multiply by a `Nat (Min ...)` >= 1.
we know that if `a >= 1  →  x * a >= x`

    five |> Nat.Min.mul two
    --> Nat 10 of type Nat (Min Nat5)

    two |> Nat.Min.mul five
    --> Nat 10 of type Nat (Min Nat2)

    two = nat2 |> Nat.N.toMin

    five = nat5 |> Nat.N.toMin

-}
mul :
    Nat (Min (Nat1Plus multipliedMinMinus1))
    -> Nat (Min min)
    -> Nat (Min min)
mul minNat =
    Internal.map ((*) (toInt minNat))


{-| Divide (`//`) by a `Nat.Min`. `div 0` is impossible.

    Nat.N.toMin nat7 |> Nat.Min.div (nat3 |> Nat.N.toMin)
    --> Nat 2 of type Nat (Min Nat0)

-}
div :
    Nat (Min (Nat1Plus minMinus1))
    -> Nat (Min min)
    -> Nat (Min Nat0)
div minNat =
    Internal.map (\base -> base // toInt minNat)


{-| The remainder after division. `remainderBy 0` is impossible.

    Nat.N.toMin nat7 |> Nat.Min.remainderBy (Nat.N.toMin nat3)
    --> Nat 1 of type Nat (Min Nat0)

-}
remainderBy :
    Nat (Min (Nat1Plus dMinMinus1))
    -> Nat (Min min)
    -> Nat (Min Nat0)
remainderBy minNat =
    Internal.map (Basics.remainderBy (minNat |> toInt))


{-| The `Nat (Min ...) ^ a Nat (Min ...)`.
We know that if `a >= 1  →  x ^ a >= x`

    five |> Nat.Min.toPower two
    --> Nat 25 of type Nat (Min Nat5)

    two |> Nat.Min.toPower five
    --> Nat 25 of type Nat (Min Nat2)

    two = nat2 |> Nat.N.toMin

    five = nat5 |> Nat.N.toMin

-}
toPower :
    Nat (Min (Nat1Plus minMinus1))
    -> Nat (Min min)
    -> Nat (Min min)
toPower power =
    Internal.map (\x -> x ^ toInt power)



-- ## compare


{-| Compare the `Nat (Min ...)` to a `Nat (N ...)`. Is it `greater`, `less` or `equal`?

`min` ensures that the `Nat (N ...)` is bigger than the minimum.

    present =
        Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
            >> Nat.Min.is (nat18 |> Nat.N.toIn)
                { min = nat0 }
                { less = \age -> appropriateToy { age = age }
                , greater = \age -> appropriateExperience { age = age }
                , equal = \() -> bigPresent
                }

    appropriateToy : { age : Nat (In Nat0 Nat17) } -> Toy

    appropriateExperience : { age : Nat (Min Nat19) } -> Experience

-}
is :
    Nat (In (Nat1Plus triedMinus1) (Nat1Plus triedMinus1PlusA))
    -> { min : Nat (N min (Is lessRange To triedMinus1)) }
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
factorial : Nat.Min min -> Nat.Min Nat1
factorial =
    Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
        >> Nat.Min.isAtLeast (nat1 |> Nat.N.toIn)
            { min = nat0 }
            { less = \_ -> nat1 |> Nat.N.toMin
            , equalOrGreater =
                \atLeast1 ->
                    atLeast1
                        |> Nat.Min.mul
                            (factorial
                                (atLeast1 |> Nat.Min.subN nat1)
                            )
            }
```

-}
isAtLeast :
    Nat (In triedMin (Nat1Plus triedMinMinus1PlusA))
    -> { min : Nat (N min (Is lessRange To triedMin)) }
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


{-| Is the `Nat (Min ...)`

  - `equalOrLess` than a `Nat` or

  - `greater`?

```
goToU18Party : { age : Nat (In min Nat17) } -> List Snack

tryToGoToU18Party =
    Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
        >> Nat.Min.isAtMost nat17
            { min = nat0 }
            { equalOrLess = \age -> Just (goToU18Party { age = age })
            , greater = Nothing
            }
```

-}
isAtMost :
    Nat (In atMostMin atMostMinPlusA)
    -> { min : Nat (N min (Is minToAtMostMin To atMostMin)) }
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



-- ## extra


{-| `Nat (Min ...)`s from a first `Nat (In ...)` to a last `Nat (Min ...)`.

An empty range cannot be constructed.

-}
range :
    Nat (In firstMin lastMin)
    -> Nat (Min lastMin)
    -> List (Nat (Min firstMin))
range first last =
    List.range (toInt first) (toInt last)
        |> List.map Internal.Nat
