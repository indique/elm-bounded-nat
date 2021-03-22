module Nat.In exposing
    ( intInRange, atLeast, atMost
    , is, isInRange, isIntInRange, isAtLeast, isAtMost
    , addN, subN, add, sub, div, remainderBy
    , lowerMin, maxIs, dropMax
    , random, range
    )

{-| A natural number within a minimum & maximum.


## add information


### clamp

@docs intInRange, atLeast, atMost


### compare

@docs is, isInRange, isIntInRange, isAtLeast, isAtMost


## modify

@docs addN, subN, add, sub, div, remainderBy

If you want other operations like multiply, use [dropMax](Nat-In#dropMax).


## drop information

@docs lowerMin, maxIs, dropMax


## more

@docs random, range

-}

import Internal
import Nat exposing (Nat, toInt)
import Nat.Bound exposing (..)
import Nat.N.Type exposing (..)
import Nat.Ns exposing (..)
import Random



-- ## add information
-- ### clamp


{-| A `Nat (In ...)` from an `Int`, **clamped** between a minimum & maximum.

  - if the `Int < minimum`, `minimum` is returned
  - if the `Int > maximum`, `maximum` is returned

```
clampBetween3And12 =
    Nat.In.intInRange (nat3 |> Nat.N.toIn) (nat12 |> Nat.N.toIn)

9 |> clampBetween3And12 --> Nat 9

0 |> clampBetween3And12 --> Nat 3

99 |> clampBetween3And12 --> Nat 12
```

If you want to handle the cases `< minimum` & `> maximum` explicitly, use [`isIntInRange`](Nat-In#isIntInRange).

-}
intInRange :
    Nat (In min firstMax)
    -> Nat (In firstMax max)
    -> Int
    -> Nat (In min max)
intInRange lowerLimit upperLimit =
    max (lowerLimit |> toInt)
        >> min (upperLimit |> toInt)
        >> Internal.Nat


{-| **Cap** the `Nat (In ...)` to at most a number.

    nat5 |> Nat.N.toIn
        |> Nat.In.atMost nat10 { min = nat5 }
    --> Nat.In 5

    nat15 |> Nat.N.toIn
        |> Nat.In.lowerMin nat5
        |> Nat.In.atMost nat10 { min = nat5 }
    --> Nat 10

`min` ensures that that number is at least the minimum.

-}
atMost :
    Nat (N newMax Is (Difference a To newMaxPlusA))
    -> { min : Nat (N min Is (Difference newRange To newMax)) }
    -> Nat (In min oldMax)
    -> Nat (In min newMaxPlusA)
atMost higherLimit min =
    Internal.map (Basics.min (higherLimit |> toInt))


{-| If the `Nat (In ...)` is less than a number, return that number instead.

    nat5 |> Nat.N.toIn
        |> Nat.In.atLeast nat10
    --> Nat 10

    nat15 |> Nat.N.toIn
        |> Nat.In.atLeast (nat10 |> Nat.N.toIn)
    --> Nat 15

-}
atLeast :
    Nat (In newMin max)
    -> Nat (In min max)
    -> Nat (In newMin max)
atLeast lowerLimit =
    Internal.map (max (toInt lowerLimit))



-- ## compare


{-| An `Int` compared to a range from `first` to `last`.

    rejectOrAcceptUserInt =
        isIntInRange { first = nat1, last = nat100 }
            { less = Err "must be >= 1"
            , more = Err "must be <= 100"
            , inRange = Ok
            }

    rejectOrAcceptUserInt (Nat.N.toIn nat0)
    --> Err "must be >= 1"

-}
isIntInRange :
    { first : Nat (N first Is (Difference range To last))
    , last : Nat (N last Is (Difference a To lastPlusA))
    }
    ->
        { less : () -> result
        , greater : Nat (Min (Nat1Plus last)) -> result
        , inRange : Nat (In first lastPlusA) -> result
        }
    -> Int
    -> result
isIntInRange interval cases int =
    if int < toInt (.first interval) then
        .less cases ()

    else if int > toInt (.last interval) then
        .greater cases (int |> Internal.Nat)

    else
        .inRange cases (int |> Internal.Nat)


{-| Is the `Nat (In ...)`

  - `equalOrGreater` than a `Nat` or

  - `less`?

```
vote : { age : Nat (In (Nat18Plus orOlder) max) } -> Vote

tryToVote =
    Nat.In.lowerMin nat0
        >> Nat.In.isAtLeast ( nat18, nat18 )
            { min = nat0 }
            { less = Nothing --😓
            , equalOrGreater = \age -> Just (vote { age = age })
            }
```

-}
isAtLeast :
    ( Nat (N tried Is (Difference a To (Nat1Plus triedMinus1PlusA)))
    , Nat (N tried Is (Difference atLeastRange To max))
    )
    -> { min : Nat (N min Is (Difference (Nat1Plus lessRange) To tried)) }
    ->
        { less : Nat (In min triedMinus1PlusA) -> result
        , equalOrGreater : Nat (In tried max) -> result
        }
    -> Nat (In min max)
    -> result
isAtLeast triedLowerLimit min cases =
    \inNat ->
        if Internal.toInt inNat >= Internal.toInt (triedLowerLimit |> Tuple.first) then
            .equalOrGreater cases (Internal.newRange inNat)

        else
            .less cases (Internal.newRange inNat)


{-| Is the `Nat (In ...)`

  - `equalOrLess` than a `Nat` or

  - `greater`?

```
goToU18Party : { age : Nat (In min Nat17) } -> List Snack

tryToGoToU18Party =
    Nat.In.lowerMin (nat0 |> Nat.N.toIn)
        >> Nat.In.isAtMost ( nat17, nat17 )
            { min = nat0 }
            { equalOrLess = \age -> Just (goToU18Party { age 0 age })
            , greater = Nothing
            }
```

-}
isAtMost :
    ( Nat (N tried Is (Difference a To triedPlusA))
    , Nat (N tried Is (Difference (Nat1Plus greaterRange) To max))
    )
    -> { min : Nat (N min Is (Difference atMostRange To tried)) }
    ->
        { equalOrLess : Nat (In min triedPlusA) -> result
        , greater : Nat (In tried max) -> result
        }
    -> Nat (In min max)
    -> result
isAtMost triedUpperLimit min cases =
    \inNat ->
        if toInt inNat <= toInt (triedUpperLimit |> Tuple.first) then
            .equalOrLess cases (Internal.newRange inNat)

        else
            .greater cases (Internal.newRange inNat)


{-| Compare the `Nat (In ...)` to a `Nat (N ...)`. Is it `greater`, `less` or `equal`?

`min` ensures that the `Nat (N ...)` is bigger than the minimum.

    present =
        Nat.In.lowerMin (nat0 |> Nat.N.toIn)
            >> Nat.In.is ( nat18, nat18 )
                { min = nat0 }
                { less = \age -> appropriateToy { age = age }
                , greater = \age -> appropriateExperience { age = age }
                , equal = \() -> bigPresent
                }

    appropriateToy : { age : Nat (In Nat0 Nat17) } -> Toy

    appropriateExperience : { age : Nat (In Nat19 max) } -> Experience

-}
is :
    ( Nat (N tried Is (Difference (Nat1Plus greaterRange) To max))
    , Nat (N tried Is (Difference a To (Nat1Plus triedPlusAMinus1)))
    )
    -> { min : Nat (N min Is (Difference (Nat1Plus lessRange) To tried)) }
    ->
        { equal : () -> result
        , less : Nat (In min triedPlusAMinus1) -> result
        , greater : Nat (In (Nat2Plus triedMinus1) max) -> result
        }
    -> Nat (In min max)
    -> result
is tried min cases =
    \inNat ->
        case compare (toInt inNat) (toInt (tried |> Tuple.first)) of
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
    Nat.In.lowerMin nat0
        >> Nat.In.isInRange
            { first = ( nat3, nat3 ), last = ( nat10, nat10 ) }
            { min = nat0 }
            { less = \_ -> Nothing
            , greater = \_ -> Nothing
            , inRange = Just
            }

justIfBetween3And10 (nat9 |> Nat.N.toIn)
--> Just (Nat 9)

justIfBetween3And10 (nat123 |> Nat.N.toIn)
--> Nothing
```

-}
isInRange :
    { first :
        ( Nat (N first Is (Difference range To last))
        , Nat (N first Is (Difference a To (Nat1Plus firstMinus1PlusA)))
        )
    , last :
        ( Nat (N last Is (Difference (Nat1Plus greaterRange) To max))
        , Nat (N last Is (Difference a To lastPlusA))
        )
    }
    -> { min : Nat (N min Is (Difference (Nat1Plus lessRange) To first)) }
    ->
        { inRange : Nat (In first lastPlusA) -> result
        , less : Nat (In min firstMinus1PlusA) -> result
        , greater : Nat (In (Nat1Plus last) max) -> result
        }
    -> Nat (In min max)
    -> result
isInRange interval min cases =
    \inNat ->
        let
            firstInt =
                .first interval |> Tuple.first |> toInt

            lastInt =
                .last interval |> Tuple.first |> toInt
        in
        if toInt inNat < firstInt then
            .less cases (Internal.newRange inNat)

        else if toInt inNat > lastInt then
            .greater cases (Internal.newRange inNat)

        else
            .inRange cases (Internal.newRange inNat)



-- ## modify


{-| Add a `Nat (In ...)`.

    Nat.N.toIn nat3
        |> Nat.In.add between1And12 nat1 nat12
    --> of type Nat (In Nat4 (Nat15Plus a))

-}
add :
    Nat (In addedMin addedMax)
    -> Nat (N addedMin Is (Difference min To sumMin))
    -> Nat (N addedMax Is (Difference max To sumMax))
    -> Nat (In min max)
    -> Nat (In sumMin sumMax)
add added addedMin addedMax =
    Internal.map ((+) (toInt added))


{-| Add a fixed `Nat (N ...)` value.

    Nat.N.toIn nat70
        |> Nat.In.addN ( nat7, nat7 )
    --> is of type Nat (In Nat77 (Nat77Plus a))

-}
addN :
    ( Nat (N added Is (Difference min To sumMin))
    , Nat (N added Is (Difference max To sumMax))
    )
    -> Nat (In min max)
    -> Nat (In sumMin sumMax)
addN addedNat =
    Internal.map (\inNat -> inNat + toInt (addedNat |> Tuple.first))


{-| Subtract a `Nat (In ...)`.

    nat6 |> Nat.N.toIn
        |> Nat.In.sub between1And5 nat1 nat5
    --> is of type Nat (In Nat1 (Nat5Plus a))

-}
sub :
    Nat (In subtractedMin subtractedMax)
    -> Nat (N subtractedMin Is (Difference differenceMax To max))
    -> Nat (N subtractedMax Is (Difference differenceMin To min))
    -> Nat (In min max)
    -> Nat (In differenceMin differenceMax)
sub subtractedInNat subtractedMin subtractedMax =
    Internal.map (\inNat -> inNat - toInt subtractedInNat)


{-| Subtract a fixed `Nat` value.

    nat7 |> Nat.N.toIn
        |> Nat.In.subN ( nat7, nat7 )
    --> is of type Nat (In Nat0 a)

-}
subN :
    ( Nat (N subtracted Is (Difference differenceMin To min))
    , Nat (N subtracted Is (Difference differenceMax To max))
    )
    -> Nat (In min max)
    -> Nat (In differenceMin differenceMax)
subN subtractedNNat =
    Internal.map
        (\inNat ->
            inNat - toInt (subtractedNNat |> Tuple.first)
        )


{-| Divide (`//`) by a `Nat (Min ...)`. `div 0` is impossible.

    Nat.N.toIn nat7 |> Nat.In.div (nat3 |> Nat.N.toMin)
    --> Nat 2 of type Nat (In Nat0 (Nat7Plus a))

-}
div :
    Nat (Min (Nat1Plus dMinMinus1))
    -> Nat (In min max)
    -> Nat (In Nat0 max)
div minNat =
    Internal.map (\base -> base // Internal.toInt minNat)


{-| The remainder after division. `remainderBy 0` is impossible.

    Nat.N.toIn nat7 |> Nat.In.remainderBy (nat3 |> Nat.N.toMin)
    --> Nat 1 of type Nat (In Nat0 (Nat7Plus a))

-}
remainderBy :
    Nat (Min (Nat1Plus dMinMinus1))
    -> Nat (In min max)
    -> Nat (In Nat0 max)
remainderBy minNat =
    Internal.map (Basics.remainderBy (minNat |> Internal.toInt))



--## drop information


{-| Set the minimum lower.

    [ Nat.N.toIn nat3, Nat.N.toIn nat4 ]

Elm complains:

> But all the previous elements in the list are: `Nat (In Nat3 ...)`

    [ Nat.N.toIn nat3
    , Nat.N.toIn nat4 |> Nat.In.lowerMin nat3
    ]

-}
lowerMin :
    Nat (N lowerMin Is (Difference currentMinusAlsoValidmin To min))
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
            (value |> Nat.In.maxIs nat18 {- works :) -})

[`lowerMin`](Nat-In#lowerMin) is also handy in those situations.

-}
maxIs :
    Nat (N max Is (Difference a To maxPlusA))
    -> Nat (In min max)
    -> Nat (In min maxPlusA)
maxIs =
    \_ -> Internal.newRange


{-| Convert a `Nat (In ...)` to a `Nat (Min ...)`.

    squareAInNat =
        Nat.In.dropMax >> Nat.Min.toPower (nat2 |> Nat.N.toMin)

-}
dropMax : Nat (In min max) -> Nat (Min min)
dropMax =
    Internal.newRange



-- ## more


{-| `Nat (In ...)`s from a first to a last value.

    from3To10 =
        Nat.In.range (nat3 |> Nat.N.toIn) (nat10 |> Nat.N.toIn)

-}
range :
    Nat (In firstMin lastMin)
    -> Nat (In lastMin lastMax)
    -> List (Nat (In firstMin lastMax))
range first last =
    List.range (toInt first) (toInt last)
        |> List.map Internal.Nat


{-| Generate a random `Nat (In ...)` in a range.
-}
random :
    Nat (In firstMin lastMin)
    -> Nat (In lastMin lastMax)
    -> Random.Generator (Nat (In firstMin lastMax))
random min max =
    Random.int (toInt min) (toInt max)
        |> Random.map Internal.Nat
