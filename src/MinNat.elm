module MinNat exposing
    ( is, isAtLeast, isAtMost
    , subN, add, sub, addN
    )

{-| 2 situations where you use these operations instead of the ones in [`InNat`](InNat):

1.  Your value is of type `Nat (Min ...)`

        nat3 |> NNat.toIn
            |> InNat.mul (nat3 |> NNat.toIn)
        --> Nat (Min Nat3)

2.  The maximum isn't fixed

        divideBy : Nat (In (Nat1Plus minMinus1) max) -> --...


### compare

@docs is, isAtLeast, isAtMost


## modify

@docs subN, add, sub, addN

For every other operation, use [`InNat`](InNat).

-}

import InNat
import Internal
import NNats exposing (..)
import Nat exposing (Nat, toInt)
import Nat.Bound exposing (In, Is, Min, N, To)
import Nat.N.Type exposing (..)



--## add information
-- ## modify


{-| Add a `Nat (Min ...)`. The second argument is the minimum if the added `Nat (Min ...)`.

    nat5
        |> NNat.toMin
        |> MinNat.add atLeast2 nat2
    --> is of type Nat (Min Nat7)

If you have don't the minimum added value at hand, use [`InNat.addLossy`](InNat#addLossy).

-}
add :
    Nat (In addedMin max)
    -> Nat (N addedMin (Is min To sumMin) x)
    -> Nat (In min max)
    -> Nat (Min sumMin)
add inNatToAdd addedMin =
    Internal.add inNatToAdd


{-| Add a fixed `Nat (N ...)` value.

    nat70
        |> NNat.toMin
        |> InNat.addN nat7

-}
addN :
    Nat (N added (Is min To sumMin) x)
    -> Nat (In min max)
    -> Nat (Min sumMin)
addN nNatToAdd =
    Internal.add nNatToAdd


{-| Subtract an exact `Nat (N ...)`.

    (nat7 |> NNat.toMin)
        |> MinNat.subN nat2
    --> is of type Nat (Min Nat5)

-}
subN :
    Nat (N subtracted (Is differenceMin To min) x)
    -> Nat (In min max)
    -> Nat (In differenceMin max)
subN nNatToSubtract =
    Internal.sub nNatToSubtract


{-| Subtract a `Nat (In ...)`. The second argument is the maximum of the subtracted `Nat (In ...)`.

    atLeast6 |> InNat.subLossyMax in0To5 nat5
    --> is of type Nat (In Nat1 (Nat6Plus a))

If you have don't the maximum subtracted value at hand, use [`subLossy`](InNat#subLossy).

-}
sub :
    Nat (In minSubtracted maxSubtracted)
    -> Nat (N maxSubtracted (Is differenceMin To min) x)
    -> Nat (In min max)
    -> Nat (In differenceMin max)
sub inNatToSubtract maxSubtracted =
    InNat.subLossyMax inNatToSubtract maxSubtracted



-- ## compare


{-| Compare the `Nat (Min ...)` to a `Nat (N ...)`. Is it `greater`, `less` or `equal`?

`min` ensures that the `Nat (N ...)` is bigger than the minimum.

    present =
        MinNat.lowerMin (nat0 |> NNat.toIn)
            >> MinNat.is (nat18 |> NNat.toIn)
                { min = nat0 }
                { less = \age -> appropriateToy { age = age }
                , greater = \age -> appropriateExperience { age = age }
                , equal = \() -> bigPresent
                }

    appropriateToy : { age : Nat (In Nat0 Nat17) } -> Toy

    appropriateExperience : { age : Nat (In Nat19 max) } -> Experience

-}
is :
    Nat (In (Nat1Plus triedMinus1) (Nat1Plus triedMinus1PlusA))
    -> { min : Nat (N min (Is lessRange To triedMinus1) x) }
    ->
        { equal : () -> result
        , less : Nat (In min triedMinus1PlusA) -> result
        , greater : Nat (Min (Nat2Plus triedMinus1)) -> result
        }
    -> Nat (In min max)
    -> result
is tried min cases =
    \minNat ->
        case compare (toInt minNat) (toInt tried) of
            EQ ->
                .equal cases ()

            LT ->
                .less cases (Internal.newRange minNat)

            GT ->
                .greater cases (Internal.newRange minNat)


{-| Is the `Nat (Min ...)`

  - `equalOrGreater` than a `Nat` or

  - `less`?

```
factorial : MinNat min -> MinNat Nat1
factorial =
    MinNat.lowerMin (nat0 |> NNat.toIn)
        >> MinNat.isAtLeast (nat1 |> NNat.toIn)
            { min = nat0 }
            { less = \_ -> nat1 |> NNat.toMin
            , equalOrGreater =
                \atLeast1 ->
                    atLeast1
                        |> MinNat.mul
                            (factorial
                                (atLeast1 |> MinNat.subN nat1)
                            )
            }
```

-}
isAtLeast :
    Nat (In triedMin (Nat1Plus triedMinMinus1PlusA))
    -> { min : Nat (N min (Is lessRange To triedMin) x) }
    ->
        { less : Nat (In min triedMinMinus1PlusA) -> result
        , equalOrGreater : Nat (Min triedMin) -> result
        }
    -> Nat (In min max)
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
    MinNat.lowerMin (nat0 |> NNat.toIn)
        >> MinNat.isAtMost nat17
            { min = nat0 }
            { equalOrLess = \age -> Just (goToU18Party { age = age })
            , greater = Nothing
            }
```

-}
isAtMost :
    Nat (In atMostMin atMostMinPlusA)
    -> { min : Nat (N min (Is minToAtMostMin To atMostMin) x) }
    ->
        { equalOrLess : Nat (In min atMostMinPlusA) -> result
        , greater : Nat (Min atMostMin) -> result
        }
    -> Nat (In min max)
    -> result
isAtMost triedUpperLimit min cases =
    \minNat ->
        if toInt minNat <= toInt triedUpperLimit then
            .equalOrLess cases (minNat |> Internal.newRange)

        else
            .greater cases (Internal.newRange minNat)
