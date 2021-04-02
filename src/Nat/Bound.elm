module Nat.Bound exposing
    ( In
    , Only
    , N, Is, To, And
    , ValueMin, ValueIn
    , ValueOnly
    )

{-|


## function argument

@docs In

@docs Only


### N

@docs N, Is, To, And


## value / return type

@docs ValueMin, ValueIn

`ValueOnly` is useful for [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/)s,
but you will never need it in combination with `Nat`s.

@docs ValueOnly

-}

import N as Internal


{-| `ValueIn minimum maximum`: A value somewhere within a minimum & maximum. We don't know the exact value, though.

       ↓ minimum   ↓ maximum
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓] ⨯ ⨯ ⨯...

To be used as a return type, **not** as a function argument.

A number between 3 and 5

    Nat (ValueIn Nat3 (Nat5Plus a))

A number, at least 5:

    Nat (ValueIn Nat5 (Nat5Plus a))

-}
type alias ValueIn minimum maximum =
    In minimum maximum NoN


{-| `In minimum maximum maybeN`: Somewhere within a minimum & maximum.

       ↓ minimum   ↓ maximum
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓] ⨯ ⨯ ⨯...

Note: maximum >= minimum for every existing `Nat (In min max ...)`:

    percent : Nat (In min Nat100 maybeN) -> Percent

→ `min <= Nat100`

If you want a number where you just care about the minimum, leave the `max` as a type _variable_.

       ↓ minimum    ↓ maximum or  →
    ⨯ [✓ ✓ ✓ ✓ ✓ ✓ ✓...

Any natural number:

    Nat (In min max maybeN)

A number, at least 5:

    Nat (In (Nat5Plus minMinus5) max maybeN)

  - `max` could be a maximum value if there is one

  - `maybeN` could contain extra information for `N ...` if the number was exact

-}
type alias In minimum maximum maybeN =
    Internal.In minimum maximum maybeN


{-| Only **value / return types should be `Min`**.

Sometimes, you simply cannot compute a maximum.

    abs : Int -> Nat (ValueIn Nat0 ??)

This is where to use `Min`.

    abs : Int -> Nat (Min Nat0)

Every `Min min` is of type `In min ...`.

-}
type alias ValueMin minimum =
    ValueIn minimum Infinity


{-| Just the exact number.

Only useful as a function **argument** type.

Every `In NatXYZ (NatXYZPlus a) maybeN` is a `Only NatXYZ maybeN`.

    byte : Arr (Only maybeN Nat8) Bit -> Byte

→ A given [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/) must have _exact 8_ `Bit`s.

`Only` is useful for [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/)s,
but you will never need it in combination with `Nat`s.

-}
type alias Only n maybeN =
    In n n maybeN


{-| Just the exact number.

Only useful as a **value & return** type.

    repeatOnly :
        Nat (Only n maybeN)
        -> element
        -> Arr (ValueOnly n) element

→ A given [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/) must has _exactly `n`_ `element`s.

`Only` is useful for [`Arr`](https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/)s,
but you will never need it in combination with `Nat`s.

-}
type alias ValueOnly n =
    ValueIn n n


{-| No special meaning.

    Is a To b

→ distance `b - a`.

-}
type alias To =
    Internal.To


{-| `And a To b`: an exact value as the diffference `b - a`.

    N Nat5
        (Is myAge To)
        sistersAge
        (And mothersAge To fathersAge)

  - `myAge + 5 = sistersAge`
  - `mothersAge + 5 = fathersAge`

-}
type alias And a to b =
    Internal.And a to b


{-| An exact value as a diffference.

    N Nat5
        (Is myAge To)
        sistersAge
        (And mothersAge To fathersAge)

  - `myAge + 5 = sistersAge`
  - `mothersAge + 5 = fathersAge`

-}
type alias Is a to =
    Internal.Is a to


{-| The most detailed description of a number at compile-time.

Every `N n atLeastN ...` is of type `In n atLeastN`.

Looking at the types

    nat0 :
        Nat
            (N
                -- 0 is the exact value at compile time
                Nat0
                -- 0 as a difference is a - a & b - b
                (Is a To)
                a
                (And b To b)
            )

An example is [`InNat.addN`](InNat#addN)

    addN :
        Nat (N added (Is min To) sumMin (And max To sumMax))
        -> Nat (In min max)
        -> Nat (In sumMin sumMax)

You can just ignore the second difference if you don't need it ([`MinNat.addN`](MinNat#addN)).

    addN :
        Nat (N added (Is min To) sumMin x)
        -> Nat (Min min)
        -> Nat (Min sumMin)

-}
type alias N n isATo nPlusA asAnotherDifference =
    In n nPlusA ( isATo, asAnotherDifference )


{-| We can't guess the highest possible number.
-}
type Infinity
    = Infinity Never


{-| Not an `N ...`.
-}
type NoN
    = NoN Never
