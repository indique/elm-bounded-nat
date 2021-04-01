module InNat exposing
    ( atMost
    , is, isInRange, isAtLeast, isAtMost
    , addN, subN, add, sub, subLossy, addLossy
    , maxIs
    , toMin
    )

{-| Operations when you know the `maximum` of the `Nat (In minimum maximum ...)`.


## add information


### clamp

@docs atMost


### compare

@docs is, isInRange, isAtLeast, isAtMost


## modify

@docs addN, subN, add, sub, div, subLossy, addLossy


## drop information

@docs maxIs, toMin

In many situations, the maximum is unimportant. Those operations are in `MinNat`, as they apply for `Nat (ValueMin ...)`s as well.

-}

import Internal
import NNats exposing (..)
import Nat exposing (Nat, bi, toInt)
import Nat.Bound exposing (..)
import TypeNats exposing (..)



-- ## add information
-- ### clamp


{-| **Cap** the `Nat (In ...)` to at most a number.

    nat5 |> NNat.toIn
        |> InNat.atMost nat10 { min = nat5 }
    --> InNat 5

    nat15 |> NNat.toIn |> InNat.lowerMin nat5
        |> InNat.atMost nat10 { min = nat5 }
    --> Nat 10

`min` ensures that that number is at least the minimum.

-}
atMost :
    Nat (In minNewMax newMaxPlusA newMaxMaybeN)
    -> { min : Nat (N min minNewMax x y) }
    -> Nat (In min max maybeN)
    -> Nat (ValueIn min newMaxPlusA)
atMost higherLimit min =
    Internal.map (Basics.min (higherLimit |> toInt))



-- ## compare


{-| Is the `Nat (In ...)`

  - `equalOrGreater` than a `Nat` or

  - `less`?

```
vote : { age : Nat (In (Nat18Plus orOlder) max) } -> Vote

tryToVote =
    InNat.lowerMin nat0
        >> InNat.isAtLeast nat18
            { min = nat0 }
            { less = Nothing --😓
            , equalOrGreater = \age -> Just (vote { age = age })
            }
```

-}
isAtLeast :
    Nat (N tried (Nat1Plus triedMinus1PlusA) (Is atLeastRange To max) x)
    -> { min : Nat (N min minPlusA (Is (Nat1Plus lessRange) To tried) y) }
    ->
        { less : Nat (ValueIn min triedMinus1PlusA) -> result
        , equalOrGreater : Nat (ValueIn tried max) -> result
        }
    -> Nat (In min max maybeN)
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
    InNat.lowerMin nat0
        >> InNat.isAtMost nat17
            { min = nat0 }
            { equalOrLess = \age -> Just (goToU18Party { age 0 age })
            , greater = Nothing
            }
```

-}
isAtMost :
    Nat (N tried triedPlusA (Is (Nat1Plus greaterRange) To max) x)
    -> { min : Nat (N min tried y z) }
    ->
        { equalOrLess : Nat (ValueIn min triedPlusA) -> result
        , greater : Nat (ValueIn tried max) -> result
        }
    -> Nat (In min max maybeN)
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
        InNat.lowerMin nat0
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
    Nat (N tried max (Is a To (Nat1Plus triedPlusAMinus1)) x)
    -> { min : Nat (N min tried y z) }
    ->
        { equal : () -> result
        , less : Nat (ValueIn min triedPlusAMinus1) -> result
        , greater : Nat (ValueIn (Nat2Plus triedMinus1) max) -> result
        }
    -> Nat (In min max maybeN)
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
    InNat.lowerMin nat0
        >> InNat.isInRange { first = nat3, last = nat10 }
            { min = nat0 }
            { less = \_ -> Nothing
            , greater = \_ -> Nothing
            , inRange = Just
            }

justIfBetween3And10 nat9
--> Just (Nat 9)

justIfBetween3And10 nat123
--> Nothing
```

-}
isInRange :
    { first :
        Nat (N first last (Is a To (Nat1Plus firstMinus1PlusA)) x)
    , last :
        Nat (N last max (Is a To lastPlusA) y)
    }
    -> { min : Nat (N min first z w) }
    ->
        { inRange : Nat (ValueIn first lastPlusA) -> result
        , less : Nat (ValueIn min firstMinus1PlusA) -> result
        , greater : Nat (ValueIn (Nat1Plus last) max) -> result
        }
    -> Nat (In min max maybeN)
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
    Nat (In addedMin addedMax addedMaybeMax)
    -> Nat (N addedMin addedMinPlusA (Is min To sumMin) x)
    -> Nat (N addedMax addedMaxPlusA (Is max To sumMax) y)
    -> Nat (In min max maybeN)
    -> Nat (ValueIn sumMin sumMax)
add inNatToAdd addedMin addedMax =
    Internal.add inNatToAdd


{-| Add a fixed `Nat (N ...)` value.

    nat70 |> NNat.toIn
        |> InNat.addN nat7
    --> is of type Nat (In Nat77 (Nat77Plus a))

-}
addN :
    Nat (N added addedPlusA (Is min To sumMin) (Is max To sumMax))
    -> Nat (In min max maybeN)
    -> Nat (ValueIn sumMin sumMax)
addN nNatToAdd =
    Internal.add nNatToAdd


{-| Add a `Nat (In ...)`, but

  - keep the current minimum, instead of computing the exact value

  - use `Infinity` as the maximum instead of computing the exact value

    atLeast5 |> MinNat.addLossy atLeast2
    --> is of type Nat (ValueMin Nat5)

    atLeast2 |> MinNat.addLossy atLeast5
    --> is of type Nat (ValueMin Nat2)

If you know the minimum and maximum added value, use [`add`](InNat#add).

-}
addLossy :
    Nat (In addedMin addedMax addedMaybeN)
    -> Nat (In min max maybeN)
    -> Nat (ValueMin min)
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
    Nat (In minSubbed maxSubbed subbedMaybeN)
    -> Nat (N minSubbed atLeastMinSubbed (Is differenceMax To max) x)
    -> Nat (N maxSubbed atLeastMaxSubbed (Is differenceMin To min) y)
    -> Nat (In min max maybeN)
    -> Nat (ValueIn differenceMin differenceMax)
sub inNatToSubtract minSubtracted maxSubtracted =
    Internal.sub inNatToSubtract


{-| Subtract a `Nat (In ..)` without

  - calculating the new minimum, the lowest possible value it can be after the subtraction is 0

```
nat6 |> NNat.toMin
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
    Nat (In minSubbed min subbedMaybeN)
    -> Nat (In min max maybeN)
    -> Nat (ValueIn Nat0 max)
subLossy inNatToSubtract =
    Internal.sub inNatToSubtract


{-| Subtract a fixed `Nat` value.

    nat7 |> NNat.toIn
        |> InNat.subN nat7
    --> is of type Nat (In Nat0 a)

**Use [`MinNat.subN`](MinNat#subN) if the maximum value is `Infinity`**.

-}
subN :
    Nat (N sub atLeastSub (Is differenceMin To min) (Is differenceMax To max))
    -> Nat (In min max maybeN)
    -> Nat (ValueIn differenceMin differenceMax)
subN nNatToSubtract =
    Internal.sub nNatToSubtract



--## drop information


{-| Convert an exact `Nat (In min ...)` to a `Nat (ValueMin min)`.

    in4To10 |> NNat.toMin
    --> is of type Nat (ValueMin Nat4)

There is **only 1 situation you should use this.**

To make these the same type.

    [ atLeast1, in1To10 ]

Elm complains:

> But all the previous elements in the list are: `Nat (ValueMin Nat1)`

    [ atLeast1
    , in1To10 |> InNat.toMin
    ]

-}
toMin : Nat (In min max maybeN) -> Nat (ValueMin min)
toMin =
    Internal.toMin


{-| Make it fit into functions with require a higher maximum.

You should design type annotations as general as possible.

    onlyAtMost18 : Nat (In min Nat18 maybeN)

    onlyAtMost18 between3And8 --fine

But once you implement `onlyAtMost18`, you might use the value in `onlyAtMost19`.

    onlyAtMost18 value =
        -- onlyAtMost19 value --error :(
        onlyAtMost19
            (value |> InNat.maxIs nat18 {- works :) -})

[`lowerMin`](InNat#lowerMin) is also handy in those situations.

-}
maxIs :
    Nat (N max atLeastMax x y)
    -> Nat (In min max maybeN)
    -> Nat (ValueIn min atLeastMax)
maxIs =
    \_ -> Internal.newRange
