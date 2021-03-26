## elm-bounded-nat

The goal for of this library is to supply you with more type-safe natural numbers (`>= 0`).

Writing

```elm
toHexChar : Nat (In min Nat15) -> Char
```

_No number below 0 or above 15_ can be passed in as an argument!

This package contains many ways to ensure that a `Nat` is in a range _at compile-time_.

- `In` knows its _minimum_ value: `⨯[✓✓✓✓✓✓✓...`
    - you might also know the _maximum_: `⨯⨯[✓✓✓]⨯⨯...`
- `N` & `Only` know the _actual value_: `⨯✓⨯⨯⨯⨯...`

Setup

```elm
import Nat exposing (Nat)
import Nat.Bound exposing (..)
    --In, Min, Only, N, Is, To
import MinNat
import InNat
import NNat
import NNats exposing (..) --nat0 to nat192

import Nat.N.Type exposing (..)
    --Nat0 to Nat192 & Nat0Plus to Nat192Plus
```

## examples


### color

```elm
rgb : Float -> Float -> Float -> Color
```

This is common, but _the one implementing_ the function has to handle the case where a value is not between 0 and 1.

```elm
rgbPer100 :
    Nat (In redMin Nat100)
    -> Nat (In greenMin Nat100)
    -> Nat (In blueMin Nat100)
    -> Color
```
Here, _the one using_ this function must make sure to you that the numbers are actually between 0 and 100.

They can prove it by

- clamping
```elm
grey float =
    let
        greyLevel =
            float
                * 100
                |> round
                |> Nat.intInRange
                    (nat0 |> NNat.toIn)
                    (nat100 |> NNat.toIn)
    in
    rgbPer100 greyLevel greyLevel greyLevel
```
- already knowing
```elm
-- the exact value Nat (N Nat100 ...) at compile-time
nat100
    |> NNat.toIn
    -- → is also in between 100 and 100 (+1 / +2 /...)

red =
    rgbPer100
        (nat100 |> NNat.toIn)
        (nat0 |> NNat.toIn)
        (nat0 |> NNat.toIn)
    -- 👍
```
- checking
```elm
isUserIntANat : Int -> Maybe (Nat (Min Nat0))
isUserIntANat =
    Nat.isIntAtLeast (nat0 |> NNat.toIn)
        { equalOrGreater = Just
        , less = \_-> Nothing
        }
```

- There are more ways, but you get the idea 🙂.

&emsp;


### digit

```elm
toDigit : Char -> Maybe Int
```

You might be able to do anything with this `Int` value, but you lost useful information.

- Can the result even be negative?
- Could the number have multiple digits?

```elm
toDigit : Char -> Maybe Digit

type alias Digit =
    Nat (In Nat0 Nat9)
```

&emsp;


### factorial

```elm
intFactorial : Int -> Int
intFactorial x =
    if x == 0 then
        1

    else
        x * intFactorial (x - 1)
```

This forms an infinite loop if we call `intFactorial -1`...

Let's disallow negative numbers here!

```elm
factorial : Nat (In min max) -> Nat (Min Nat1)
```
Says: for every natural number `n >= 0`, `n! >= 1`.
```elm
factorialHelp =
    MinNat.isAtLeast (nat1 |> NNat.toIn)
        { min = nat0 } -- the minimum of the x
        { less = \_ -> nat1 |> NNat.toMin -- x < 1 ? → then 1
        , equalOrGreater =
            \atLeast1 -> -- we now know it is a Nat (Min Nat1)
                atLeast1
                    |> InNat.mul
                        (factorialHelp
                            (atLeast1 |> MinNat.subN nat1)
                            -- so we can safely subtract 1 👍
                        )
        }
```
As the minimum is allowed to be anything `>= 0`:
```elm
factorial =
    InNat.lowerMin (nat0 |> NNat.toIn)
        >> factorialHelp
```

→ `factorial (nat4 |> NNat.toMin) --> Nat 24`

→ There is no way to put a negative number in.

→ We have the extra promise, that every result is `>= 1`

We can do even better!
We know that `!19` is already bigger than the maximum safe `Int` `2^53 - 1`.

```elm
safeFactorial : Nat (In min Nat18) -> Nat (Min Nat1)
safeFactorial =
    factorial
```

No extra work.


## tips

- keep _as much type information as possible_ and drop it only where you need to.
```elm
squares2To10 =
    -- Nats from 2 to 10
    -- every Nat is In Nat2 Nat10
    InNat.range (nat2 |> NNat.toIn) (nat10 |> NNat.toIn)
        |> List.map
            (InNat.toPower (nat2 |> NNat.toIn)
            -- we can't compute the exact minimum
            -- but we know its at least Nat2
            )
```
- keep your _function annotations as general as possible_
    
    Instead of accepting only values where you know the values exact
```elm
rgb : Nat (N red (Is inverseRed To Nat100) x) -> --...
```
    accept values that are somewhere in a range.
```elm
rgb : Nat (In redMin Nat100) -> --...
```
    or instead of
```elm
charFromCode : Nat (Min min) -> Char
```
    which you should never do, allow `Nat (In min ..)` with any max to fit in as well!
```elm
charFromCode : Nat (In min max) -> Char
```

Take a look at [`elm-bounded-array`][bounded-array] to see a lot of this in action!

You get to know that a `Nat (In ...)` is very useful as an index!

[bounded-array]: https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/
