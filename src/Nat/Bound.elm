module Nat.Bound exposing
    ( In
    , Min, Infinity
    , Only
    , N, Is, To
    )

{-|


## In

@docs In


### Min

@docs Min, Infinity


### Only

@docs Only


## N

@docs N, Is, To

-}


{-| Sometimes, you simply cannot compute a maximum.

    abs : Int -> Nat (In Nat0 ??)

We just say the maximum value is `Infinity` and we're done.

    abs : Int -> Nat (In Nat0 Infinity)

A short form is [`Min`](Nat-Bound#Min)

    abs : Int -> Nat (Min Nat0)

Note: if you want an argument to just be at least a minimum value, do

    --incomplete
    divideBy : Nat (In (Nat1Plus minMinus1) max)

So that way, both `In Nat7 Nat123` & `In Nat7 Infinity`/`Min Nat7` fit.

Only **return types should contain `Infinity`**, whereas **prarameters should never contain `Infinity`.**

-}
type Infinity
    = Infinity Never


{-| `In minimum maximum`: Somewhere within a minimum & maximum.

       ↓ minimum   ↓ maximum
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓] ⨯ ⨯ ⨯...

Note: maximum >= minimum for every existing `Nat (In ...)`:

    percent : Nat (In minimum Nat100)

→ `minimum <= Nat100`

If you want a number where you just care about the minimum, leave the `max` as a type _variable_.

       ↓ minimum    ↓ maximum or  →
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓...

Any natural number:

    Nat (In Nat0 max)

A number, at least 5:

    Nat (In Nat5 max)

`max` can then either be a value or [`Infinity`](Nat-Bound#Infinity).

-}
type In minimum maximum
    = In Never


{-| Sometimes, you simply cannot compute a maximum.

    abs : Int -> Nat (In Nat0 ??)

We just say the maximum value is [`Infinity`](Nat-Bound#Infinity) and we're done.

    abs : Int -> Nat (In Nat0 Infinity)

`Min` is just a shorthand.

    abs : Int -> Nat (Min Nat0)

Note: if you want an argument to just be at least a minimum value, do

    --incomplete
    divideBy : Nat (In (Nat1Plus minMinus1) max)

So that way, both `In Nat7 Nat123` & `In Nat7 Infinity`/`Min Nat7` fit.

Only **return types should be `Min`**, whereas **prarameters should never be `Min`.**

-}
type alias Min minimum =
    In minimum Infinity


{-| Just the exact number.

Only useful in function annotations.

    byte : Arr (Only Nat8) Bit -> Byte

→ A given [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/) must have _exact 8_ `Bit`s.

Every `In NatXYZ (NatXYZPlus a)` is also a `Only NatXYZ`, _but not the other way around_

-}
type alias Only n =
    In n n


{-| No special meaning.

    Is a To b

-}
type To
    = To Never


{-| Describe an exact value as the diffference `b - a`.

    N Nat5 (Is myAge To sistersAge) (Is mothersAge To fathersAge)

  - `myAge + 5 = sistersAge`
  - `mothersAge + 5 = fathersAge`

-}
type Is a to b
    = Is Never


{-| The _actual value_ is present in the type.

Looking at the type

    nat0 :
        -- natural number
        Nat
            (N
                -- 0 is the exact value at compile time
                Nat0
                -- 0 as a difference is a - a & b - b
                (Is a To a)
                (Is b To b)
            )

An example is [`InNat.addN`](InNat#addN)

    addN :
        Nat (N added (Is min To sumMin) (Is max To sumMax))
        -> Nat (In min max)
        -> Nat (In sumMin sumMax)

You can just ignore the second difference if you don't need it ([`MinNat.addN`](MinNat#addN)).

    addN :
        Nat (N added (Is min To sumMin) x)
        -> Nat (Min min)
        -> Nat (Min sumMin)

If you only want to ensure that it is within a minimum (& maximum), [`Min`](Nat-Bound#Min) or [`In`](Nat-Bound#In) is the right choice!
This is the better choice for most calculations.

-}
type N n difference otherDifference
    = N Never
