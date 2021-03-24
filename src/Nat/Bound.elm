module Nat.Bound exposing
    ( Min
    , In
    , Only
    , N, Is, To
    )

{-|


## Min

@docs Min


## In

@docs In


## Only

@docs Only


## N

@docs N, Is, To

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

An example is [`Nat.In.addN`](Nat-In#addN)

    addN :
        Nat (N added (Is min To sumMin) (Is max To sumMax))
        -> Nat (In min max)
        -> Nat (In sumMin sumMax)

You can just ignore the second difference if you don't need it ([`Nat.Min.addN`](Nat-Min#addN)).

    addN :
        Nat (N added (Is min To sumMin) x)
        -> Nat (Min min)
        -> Nat (Min sumMin)

If you only want to ensure that it is within a minimum (& maximum), [`Min`](Nat-Bound#Min) or [`In`](Nat-Bound#In) is the right choice!
This is the better choice for most calculations.

-}
type N n difference otherDifference
    = N Never
