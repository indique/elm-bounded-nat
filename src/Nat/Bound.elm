module Nat.Bound exposing
    ( Min
    , In
    , Only
    , N, Is, IsBoth, And, To
    )

{-|


## Min

@docs Min


## In

@docs In


## Only

@docs Only


## N

@docs N, Is, IsBoth, And, To

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

    repeat (Nat.N.toIn nat6) "ok"
    --> Arr (Only Nat6)

→ repeating an `element` `n` times will give you a Arr of `n` elements.

→ Every `In NatXYZ (NatXYZPlus a)` is also a `Only NatXYZ`, _but not the other way around_

-}
type alias Only n =
    In n n


{-| No special meaning.

    Is a To b

-}
type To
    = To Never


{-| No special meaning.

    IsBoth a To b And c To d

-}
type And
    = And Never


{-| `b - a`.

    Is a To (Nat1Plus a)

would describe a difference of 1.

-}
type alias Is a to b =
    IsBoth a to b And a to b


{-| `b - a` & `d - c`.

    IsBoth a To (Nat1Plus a) And b To (Nat1Plus b)

would describe a difference of 1.

-}
type IsBoth a to b and c to_ d
    = IsBoth Never


{-| The _actual value_ is present in the type.

Looking at the type

    nat0 :
        -- natural number
        Nat
            (N
                -- 0 is the exact value at compile time
                Nat0
                (-- 0 as a difference is a - a & b - b
                 IsBoth a To a And b To b
                )
            )

It is also used to describe a difference between two values.

    interval :
        { first : Nat (N first (Is range To last))
        , last : Nat (Only last)
        }
        -> Interval

→ because `range` is 0 or positive, `last` must also be at least as high as `first`.

If you only want to ensure that it is within a minimum (& maximum), [`Min`](Nat-Bound#Min) or [`In`](Nat-Bound#In) is the right choice!
This is most of the time the better choice for calculations.

-}
type N n isDifference
    = N Never
