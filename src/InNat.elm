module InNat exposing
    ( atLeast, atMost
    , is, isInRange, isAtLeast, isAtMost
    , addN, subN, add, sub, div, remainderBy, subLossy, addLossy, mul, toPower, subLossyMax
    , lowerMin, maxIs, dropMax
    , random, range
    )

{-| A natural number within a minimum & maximum.


## add information


### clamp

@docs atLeast, atMost


### compare

@docs is, isInRange, isAtLeast, isAtMost


## modify

@docs addN, subN, add, sub, div, remainderBy, subLossy, addLossy, mul, toPower, subLossyMax


## drop information

@docs lowerMin, maxIs, dropMax


## more

@docs random, range

-}

import Internal
import NNat
import NNats exposing (..)
import Nat exposing (Nat, bi, toInt)
import Nat.Bound exposing (..)
import Nat.N.Type exposing (..)
import Random



-- ## add information
-- ### clamp


{-| **Cap** the `Nat (In ...)` to at most a number.

    nat5 |> NNat.toIn
        |> InNat.atMost (nat10 |> NNat.toIn) { min = nat5 }
    --> InNat 5

    nat15 |> NNat.toIn |> InNat.lowerMin (nat5 |> NNat.toIn)
        |> InNat.atMost (nat10 |> NNat.toIn) { min = nat5 }
    --> Nat 10

`min` ensures that that number is at least the minimum.

The maximum can also be `Infinity`.

    nat5 |> NNat.dropMax
        |> InNat.atMost (nat10 |> NNat.toIn) { min = nat5 }
    --> Nat 5

-}
atMost :
    Nat (In newMax newMaxPlusA)
    -> { min : Nat (N min (Is newRange To newMax) y) }
    -> Nat (In min max)
    -> Nat (In min newMaxPlusA)
atMost higherLimit min =
    Internal.map (Basics.min (higherLimit |> toInt))


{-| If the `Nat (In ...)` is less than a number, return that number instead.

    nat5 |> NNat.toIn
        |> InNat.atLeast nat10
    --> Nat 10

    nat15 |> NNat.toIn
        |> InNat.atLeast (nat10 |> NNat.toIn)
    --> Nat 15

Notice that this also works, if the `max` is `Infinity`.

    nat15 |> NNat.dropMax
        |> InNat.atLeast (nat10 |> NNat.dropMax)
    --> Nat 15

-}
atLeast :
    Nat (In newMin max)
    -> Nat (In min max)
    -> Nat (In newMin max)
atLeast lowerLimit =
    Internal.map (max (toInt lowerLimit))



-- ## compare


{-| Is the `Nat (In ...)`

  - `equalOrGreater` than a `Nat` or

  - `less`?

```
vote : { age : Nat (In (Nat18Plus orOlder) max) } -> Vote

tryToVote =
    InNat.lowerMin (nat0 |> NNat.toIn)
        >> InNat.isAtLeast nat18
            { min = nat0 }
            { less = Nothing --😓
            , equalOrGreater = \age -> Just (vote { age = age })
            }
```

-}
isAtLeast :
    Nat (N tried (Is a To (Nat1Plus triedMinus1PlusA)) (Is atLeastRange To max))
    -> { min : Nat (N min (Is (Nat1Plus lessRange) To tried) x) }
    ->
        { less : Nat (In min triedMinus1PlusA) -> result
        , equalOrGreater : Nat (In tried max) -> result
        }
    -> Nat (In min max)
    -> result
isAtLeast triedLowerLimit min cases =
    \inNat ->
        if bi (>=) inNat triedLowerLimit then
            .equalOrGreater cases (Internal.newRange inNat)

        else
            .less cases (Internal.newRange inNat)


{-| Is the `Nat (In ...)`

  - `equalOrLess` than a `Nat` or

  - `greater`?

```
goToU18Party : { age : Nat (In min Nat17) } -> List Snack

tryToGoToU18Party =
    InNat.lowerMin (nat0 |> NNat.toIn)
        >> InNat.isAtMost nat17
            { min = nat0 }
            { equalOrLess = \age -> Just (goToU18Party { age 0 age })
            , greater = Nothing
            }
```

-}
isAtMost :
    Nat (N tried (Is a To triedPlusA) (Is (Nat1Plus greaterRange) To max))
    -> { min : Nat (N min (Is atMostRange To tried) x) }
    ->
        { equalOrLess : Nat (In min triedPlusA) -> result
        , greater : Nat (In tried max) -> result
        }
    -> Nat (In min max)
    -> result
isAtMost triedUpperLimit min cases =
    \inNat ->
        if toInt inNat <= (triedUpperLimit |> toInt) then
            .equalOrLess cases (Internal.newRange inNat)

        else
            .greater cases (Internal.newRange inNat)


{-| Compare the `Nat (In ...)` to a `Nat (N ...)`. Is it `greater`, `less` or `equal`?

`min` ensures that the `Nat (N ...)` is bigger than the minimum.

    present =
        InNat.lowerMin (nat0 |> NNat.toIn)
            >> InNat.is nat18
                { min = nat0 }
                { less = \age -> appropriateToy { age = age }
                , greater = \age -> appropriateExperience { age = age }
                , equal = \() -> bigPresent
                }

    appropriateToy : { age : Nat (In Nat0 Nat17) } -> Toy

    appropriateExperience : { age : Nat (In Nat19 max) } -> Experience

-}
is :
    Nat (N tried (Is (Nat1Plus greaterRange) To max) (Is a To (Nat1Plus triedPlusAMinus1)))
    -> { min : Nat (N min (Is (Nat1Plus lessRange) To tried) x) }
    ->
        { equal : () -> result
        , less : Nat (In min triedPlusAMinus1) -> result
        , greater : Nat (In (Nat2Plus triedMinus1) max) -> result
        }
    -> Nat (In min max)
    -> result
is tried min cases =
    \inNat ->
        case bi compare inNat tried of
            EQ ->
                .equal cases ()

            GT ->
                .greater cases (Internal.newRange inNat)

            LT ->
                .less cases (Internal.newRange inNat)


{-| Compared to a range `first` to `last`, is the `Nat (In ...)`

  - `inRange`

  - `greater` than the `last` or

  - `less` than the `first`?

```
justIfBetween3And10 =
    InNat.lowerMin (nat0 |> NNat.toIn)
        >> InNat.isInRange { first = nat3, last = nat10 }
            { min = nat0 }
            { less = \_ -> Nothing
            , greater = \_ -> Nothing
            , inRange = Just
            }

justIfBetween3And10 (nat9 |> NNat.toIn)
--> Just (Nat 9)

justIfBetween3And10 (nat123 |> NNat.toIn)
--> Nothing
```

-}
isInRange :
    { first :
        Nat (N first (Is range To last) (Is a To (Nat1Plus firstMinus1PlusA)))
    , last :
        Nat (N last (Is (Nat1Plus greaterRange) To max) (Is a To lastPlusA))
    }
    -> { min : Nat (N min (Is (Nat1Plus lessRange) To first) x) }
    ->
        { inRange : Nat (In first lastPlusA) -> result
        , less : Nat (In min firstMinus1PlusA) -> result
        , greater : Nat (In (Nat1Plus last) max) -> result
        }
    -> Nat (In min max)
    -> result
isInRange interval min cases =
    \inNat ->
        if bi (<) inNat (.first interval) then
            .less cases (Internal.newRange inNat)

        else if bi (>) inNat (.last interval) then
            .greater cases (Internal.newRange inNat)

        else
            .inRange cases (Internal.newRange inNat)



-- ## modify


{-| Add a `Nat (In ...)`.

    NNat.toIn nat3
        |> InNat.add between1And12 nat1 nat12
    --> of type Nat (In Nat4 (Nat15Plus a))

-}
add :
    Nat (In addedMin addedMax)
    -> Nat (N addedMin (Is min To sumMin) x)
    -> Nat (N addedMax (Is max To sumMax) y)
    -> Nat (In min max)
    -> Nat (In sumMin sumMax)
add inNatToAdd addedMin addedMax =
    Internal.add inNatToAdd


{-| Add a fixed `Nat (N ...)` value.

    nat70 |> NNat.toIn
        |> InNat.addN nat7
    --> is of type Nat (In Nat77 (Nat77Plus a))

Use [`MinNat.addN`] if the maximum value is `Infinity`.

-}
addN :
    Nat (N added (Is min To sumMin) (Is max To sumMax))
    -> Nat (In min max)
    -> Nat (In sumMin sumMax)
addN nNatToAdd =
    Internal.add nNatToAdd


{-| Add a `Nat (In ...)`, but

  - keep the current minimum, instead of computing the exact value

  - use `Infinity` as the maximum instead of computing the exact value

    atLeast5 |> MinNat.addLossy atLeast2
    --> is of type Nat (Min Nat5)

    atLeast2 |> MinNat.addLossy atLeast5
    --> is of type Nat (Min Nat2)

Either of the 2 added `Nat`s can bhave a maximum of `Infinity`.

If you know the minimum and maximum added value at hand, use [`add`](InNat#add).

-}
addLossy :
    Nat (In addedMin addedMax)
    -> Nat (In min max)
    -> Nat (Min min)
addLossy inNatToAdd =
    Internal.add inNatToAdd


{-| Subtract a `Nat (In ...)`.

The 2 following arguments are

  - the minimum subtracted value
  - the maximum subtracted value

If you don't have both at hand, use [`subLossy`](InNat#subLossy).

    nat6 |> NNat.toIn
        |> InNat.sub between1And5 nat1 nat5
    --> is of type Nat (In Nat1 (Nat5Plus a))

-}
sub :
    Nat (In minSubtracted maxSubtracted)
    -> Nat (N minSubtracted (Is differenceMax To max) x)
    -> Nat (N maxSubtracted (Is differenceMin To min) y)
    -> Nat (In min max)
    -> Nat (In differenceMin differenceMax)
sub inNatToSubtract minSubtracted maxSubtracted =
    Internal.sub inNatToSubtract


{-| Subtract a `Nat (In ...)`. The second argument is the maximum of the subtracted `Nat (In ...)`.

    in6To10 |> InNat.subLossyMax in0To5 nat5
    --> is of type Nat (In Nat1 (Nat10Plus a))

If you also know the minimum subtracted value, use [`sub`](InNat#sub).

If you have don't the maximum subtracted value at hand, use [`subLossy`](InNat#subLossy).

-}
subLossyMax :
    Nat (In minSubtracted maxSubtracted)
    -> Nat (N maxSubtracted (Is differenceMin To min) x)
    -> Nat (In min max)
    -> Nat (In differenceMin max)
subLossyMax inNatToSubtract maxSubtracted =
    sub (inNatToSubtract |> lowerMin (nat0 |> NNat.toIn))
        nat0
        maxSubtracted


{-| Subtract a `Nat (In ..)` without

  - calculating the new minimum, the lowest possible value it can be after the subtraction is 0

```
nat6 |> NNat.dropMax
    |> InNat.subLossy between1And5
--> is of type Nat (In Nat0 Infinity)

nat6 |> NNat.toIn
    |> InNat.subLossy between1And5
--> is of type Nat (In Nat0 (Nat6Plus a))
```

If you know the maximum subtracted value, use [`subLossyMax`](InNat#subLossyMax).

If you also know the minimum subtracted value, use [`sub`](InNat#sub).

-}
subLossy :
    Nat (In minSubtracted min)
    -> Nat (In min max)
    -> Nat (In Nat0 max)
subLossy inNatToSubtract =
    Internal.sub inNatToSubtract


{-| Subtract a fixed `Nat` value.

    nat7 |> NNat.toIn
        |> InNat.subN nat7
    --> is of type Nat (In Nat0 a)

**Use [`MinNat.subN`](MinNat#subN) if the maximum value is `Infinity`**.

-}
subN :
    Nat (N subtracted (Is differenceMin To min) (Is differenceMax To max))
    -> Nat (In min max)
    -> Nat (In differenceMin differenceMax)
subN nNatToSubtract =
    Internal.sub nNatToSubtract


{-| Multiply by a `Nat (In ...)` >= 1.
we know that if `a >= 1`, `x * a >= x`.

    nat5 |> NNat.toIn |> MinNat.mul (nat2 |> NNat.toIn)
    --> Nat 10 of type Nat (Min Nat5)

    nat2 |> NNat.toIn |> MinNat.mul (nat5 |> NNat.toIn)
    --> Nat 10 of type Nat (Min Nat2)

The maximum value of both factors can be `Infinity`.

-}
mul :
    Nat (In (Nat1Plus multipliedMinMinus1) multipliedMax)
    -> Nat (In min max)
    -> Nat (Min min)
mul minNatToMultiply =
    Internal.map ((*) (toInt minNatToMultiply))


{-| Divide (`//`) by a `Nat (In ...)`.

  - `/ 0` is impossible

  - `x / d` is at most x

```
nat7 |> NNat.toIn
    |> InNat.div (nat3 |> NNat.dropMax)
--> Nat 2 of type Nat (In Nat0 (Nat7Plus a))
```

-}
div :
    Nat (In (Nat1Plus divMinMinus1) divMax)
    -> Nat (In min max)
    -> Nat (In Nat0 max)
div minNat =
    Internal.map (\x -> x // toInt minNat)


{-| The remainder after division.

  - `% 0` is impossible
  - `x % d` is at most `x`

```
NNat.toIn nat7 |> InNat.remainderBy (nat3 |> NNat.dropMax)
--> Nat 1 of type Nat (In Nat0 (Nat7Plus a))
```

-}
remainderBy :
    Nat (In (Nat1Plus divMinMinus1) divMax)
    -> Nat (In min max)
    -> Nat (In Nat0 max)
remainderBy minNat =
    Internal.map (Basics.remainderBy (minNat |> toInt))


{-| The `Nat (Min ...) ^ a Nat (Min ...)`.
We know that if `a >= 1  →  x ^ a >= x`

    five |> MinNat.toPower two
    --> Nat 25 of type Nat (Min Nat5)

    two |> MinNat.toPower five
    --> Nat 25 of type Nat (Min Nat2)

    two = nat2 |> NNat.toIn

    five = nat5 |> NNat.toIn

The maximum of both the base and the power can be `Infinity`.

-}
toPower :
    Nat (In (Nat1Plus powMinMinus1) powMax)
    -> Nat (In min max)
    -> Nat (Min min)
toPower power =
    Internal.map (\x -> x ^ toInt power)



--## drop information


{-| Convert an exact `Nat (In min ...)` to a `Nat (Min min)`.

    in4To10 |> NNat.dropMax
    --> is of type Nat (Min Nat4)

There is **only 1 situation you should use this.**

To make 2 `Nat`s the same type.

    [ atLeast1, in1To10 ]

Elm complains:

> But all the previous elements in the list are: `Nat (In Nat1 Infinity)`

    [ atLeast1
    , in1To10 |> InNat.dropMax
    ]

-}
dropMax : Nat (In min max) -> Nat (Min min)
dropMax =
    Internal.dropMax


{-| Set the minimum lower.

    [ NNat.toIn nat3, NNat.toIn nat4 ]

Elm complains:

> But all the previous elements in the list are: `Nat (In Nat3 ...)`

    [ NNat.toIn nat3
    , NNat.toIn nat4 |> InNat.lowerMin (nat3 |> NNat.toIn)
    ]

-}
lowerMin :
    Nat (In lowerMin min)
    -> Nat (In min max)
    -> Nat (In lowerMin max)
lowerMin =
    \_ -> Internal.newRange


{-| Make it fit into functions with higher maximum.

You should design type annotations as general as possible.

    onlyAtMost18 : Nat (In min Nat18)

    onlyAtMost18 between3And8 --fine

But once you implement `onlyAtMost18`, you might use the value in `onlyAtMost19`.

    onlyAtMost18 value =
        -- onlyAtMost19 value --error :(
        onlyAtMost19
            (value |> InNat.maxIs nat18 {- works :) -})

[`lowerMin`](InNat#lowerMin) is also handy in those situations.

-}
maxIs :
    Nat (N max (Is a To maxPlusA) x)
    -> Nat (In min max)
    -> Nat (In min maxPlusA)
maxIs =
    \_ -> Internal.newRange



-- ## more


{-| `Nat (In ...)`s from a first to a last value.

    from3To10 =
        InNat.range (nat3 |> NNat.toIn) (nat10 |> NNat.toIn)

The resulting `List` is never empty.

Notice that the maximum value of the last can be Infinity.

    InNat.range (nat3 |> NNat.toIn) (nat10 |> NNat.dropMax)
    --> List (Nat (In Nat3 Infinity))
    --> alias to List (Nat (Min Nat3))

-}
range :
    Nat (In firstMin lastMin)
    -> Nat (In lastMin lastMax)
    -> List (Nat (In firstMin lastMax))
range first last =
    bi List.range first last
        |> List.map Internal.Nat


{-| Generate a random `Nat (In ...)` in a range.
-}
random :
    Nat (In firstMin lastMin)
    -> Nat (In lastMin lastMax)
    -> Random.Generator (Nat (In firstMin lastMax))
random min max =
    bi Random.int min max
        |> Random.map Internal.Nat
