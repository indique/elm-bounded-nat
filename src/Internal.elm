module Internal exposing
    ( add, sub
    , isIntInRange, isIntAtLeast
    , intInRange
    , dropMax
    , Nat(..), add1, map, newRange, sub1, toInt
    )

{-|


## presets

@docs add, sub


## compare

@docs isIntInRange, isIntAtLeast


## clamp

@docs intInRange


## drop information

@docs dropMax

-}

import Nat.Bound exposing (In, Is, Min, N, To)
import Nat.N.Type exposing (..)


type Nat range
    = Nat Int


toInt : Nat range -> Int
toInt =
    \(Nat int) -> int


map : (Int -> Int) -> Nat range -> Nat mappedRange
map update =
    toInt >> update >> Nat


newRange : Nat min -> Nat newMin
newRange =
    toInt >> Nat


dropMax : Nat (In min max) -> Nat (Min min)
dropMax =
    newRange


add1 :
    Nat (N n (Is a To nPlusA) (Is b To nPlusB))
    ->
        Nat
            (N
                (Nat1Plus n)
                (Is a To (Nat1Plus nPlusA))
                (Is b To (Nat1Plus nPlusB))
            )
add1 =
    map ((+) 1)


sub1 :
    Nat
        (N
            (Nat1Plus nMinus1)
            (Is a To (Nat1Plus nMinus1PlusA))
            (Is b To (Nat1Plus nMinus1PlusB))
        )
    -> Nat (N nMinus1 (Is a To nMinus1PlusA) (Is b To nMinus1PlusB))
sub1 =
    map (\x -> x - 1)



-- ## compare


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
    if int < toInt (.first interval) then
        .less cases ()

    else if int > toInt (.last interval) then
        .greater cases (int |> Nat)

    else
        .inRange cases (int |> Nat)


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
    Basics.min (upperLimit |> toInt)
        >> Basics.max (lowerLimit |> toInt)
        >> Nat


{-| If the `Int >= a minimum`, `Just` the `Nat (Min minimum)`, else `Nothing`.

    4 |> Nat.isIntAtLeast (nat5 |> NNat.toIn) --> Nothing

    1234 |> Nat.isIntAtLeast (nat5 |> NNat.toIn) --> Just (Nat 1234)

-}
isIntAtLeast : Nat (In min max) -> Int -> Maybe (Nat (Min min))
isIntAtLeast minimum int =
    if int >= toInt minimum then
        Just (Nat int)

    else
        Nothing



-- ## presets


add : Nat addedRange -> Nat range -> Nat sumRange
add natToAdd =
    map ((+) (toInt natToAdd))


sub : Nat subtractedRange -> Nat range -> Nat differenceRange
sub natToSubtract =
    map (\x -> x - toInt natToSubtract)
