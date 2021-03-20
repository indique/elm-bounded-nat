module Nat.Bound exposing
    ( Min
    , In
    , Only
    , N, Is
    , Difference, To
    )

{-|


## Min

@docs Min


## In

@docs In


## Only

@docs Only


## N

@docs N, Is
@docs Difference, To

-}


{-| `Min minimum`: At least `minimum`.

       ↓ minimum
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓...

Any natural number:

    Nat (Min Nat0)

A number, at least 5:

    Nat (Min Nat5)

-}
type Min minimum
    = Min Never


{-| `In minimum maximum`: Somewhere within a minimum & maximum.

       ↓ minimum   ↓ maximum
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓] ⨯ ⨯ ⨯...

Note: maximum >= minimum for every existing `Nat (In ...)`:

    percent : Nat (In minimum Nat100)

→ `minimum <= Nat100`

-}
type In minimum maximum
    = In Never


{-| Just the exact number.

Only useful in function annotations.

    byte : Arr (Only Nat8) Bit -> Byte

→ A given [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/) must have _exact 8_ `Bit`s.

    repeat : Nat (Only n) -> element -> Arr (Only n)

    repeat (Nat.In.n nat6) "ok"
    --> Arr (Only Nat6)

→ repeating an `element` `n` times will give you a Arr of `n` elements.

→ Every `In NatXYZ (NatXYZPlus a)` is also a `Only NatXYZ`, _but not the other way around_

-}
type alias Only n =
    In n n


{-| No special meaning.

    N n Is difference

-}
type Is
    = Is Never


{-| No special meaning.

    Difference a To b

-}
type To
    = To Never


{-| `b - a`.

    Difference a To (Nat1Plus a)

would describe a difference of 1.

-}
type Difference a to b
    = Difference Never


{-| The _actual value_ is present in the type.

Looking at the type

    nat0 :
        -- natural number
        Nat
            (N
                -- 0 is the exact value at compile time
                Nat0
                Is
                -- 0 as a difference is a - a
                (Difference a To a)
            )

It is also used to describe a difference between two values.

    interval :
        { first : Nat (N first Is (Difference range To last))
        , last : Nat (Only last)
        }
        -> Interval

→ because `range` is 0 or positive, `last` must also be at least as high as `first`.

If you only want to ensure that it is within a minimum (& maximum), [`Min`](Nat-Bound#Min) or [`In`](Nat-Bound#In) is the right choice!
This is most of the time the better choice for calculations.

-}
type N n is difference
    = N Never
