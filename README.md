## elm-bounded-nat

Current attempts of represening natural numbers `>= 0` only have quite lose promises.

- If you know that your `Nat` is >= 3, why can't you subtract 1 or 2 or 3?

This package contains many ways to ensure that a `Nat` is in a range _at compile-time_.

- `Min` knows the _minimum_ possible value:  `⨯[✓✓✓✓✓✓✓...`
- `In` knows the _range_ it's in:  `⨯⨯[✓✓✓]⨯⨯...`
- `N` & `Only` know the _actual value_: `⨯✓⨯⨯⨯⨯...`

Setup

```elm
import Nat exposing (Nat)
import Nat.Bound exposing (..)
    --In, Min, Only, N, Is, To
import Nat.Min
import Nat.In
import Nat.N
import Nat.Ns exposing (..) --nat0 to nat192

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
    -> Nat.In (In blueMin Nat100)
    -> Color
```
Here, _the one using_ this function must make sure to you that the numbers are actually between 0 and 100.

They can prove it by

- clamping
  ```elm
  grey float =
      let
          from0To100 =
              float
                  * 100
                  >> floor
                  >> Nat.In.intInRange
                      (nat0 |> Nat.N.toIn)
                      (nat100 |> Nat.N.toIn)
      in
      rgbPer100 from0To100 from0To100 from0To100
  ```
- already knowing
  ```elm
  nat100
  -- of type Nat (N Nat100 ...)
  -- → We know the EXACT value
      |> Nat.N.toIn
      -- → it must also be in range 100 to 100 + ...
  
  red =
      rgbPer100
          (nat100 |> Nat.N.toIn)
          (nat0 |> Nat.N.toIn)
          (nat0 |> Nat.N.toIn)
        -- 👍
  ```
- checking
  ```elm
  isUserIntANat : Int -> Maybe (Nat (Min Nat0))
  isUserIntANat =
      Nat.Min.intAtLeast (nat0 |> Nat.N.toIn)
          { equalOrGreater = Just
          , less = \_-> Nothing
          }
  ```

- There are more ways, but this is enough to understand the idea 🙂.

&emsp;


### digit

```elm
toDigit : Char -> Maybe Int
```

You might be able to do anything with this `Int` value, but you lost useful information.

- How can this be negative?
- How can this have multiple digits?

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
factorial : Nat (Min min) -> Nat (Min Nat1)
```
Says: for every natural number `n >= 0`, `n! >= 1`.
```elm
factorialHelp =
    Nat.Min.isAtLeast (nat1 |> Nat.N.toIn)
        { min = nat0 } -- the minimum of the x
        { less = \_ -> Nat.N.toMin nat1 -- x < 1 ? → then 1
        , equalOrGreater = -- x >= 1 ?
            \oneOrGreater -> --we now know it is a Nat.Min Nat1
                oneOrGreater
                    |> Nat.Min.mul
                        (factorialHelp
                            (oneOrGreater |> Nat.Min.subN nat1)
                            -- so we can safely subtract 1 👍
                        )
        }
```
As the minimum is allowed to be anything `>= 0`:
```elm
factorial =
    Nat.Min.lowerMin (nat0 |> Nat.N.toIn)
        >> factorialHelp
```

→ `factorial (nat4 |> Nat.N.toMin) --> Nat 24`

→ There is no way to put a negative number in.

→ We have the extra promise, that every result is `>= 1`

We can do even better!
We know that `!19` is already bigger than the maximum safe `Int` `2^53 - 1`.

```elm
safeFactorial : Nat (In min Nat18) -> Nat (Min Nat1)
safeFactorial =
    Nat.In.dropMax >> factorial
```


## tips

- keep _as much type information as possible_ and drop it only where you need to.
    ```elm
    squaresTo10 =
        Nat.In.range (nat0 |> Nat.N.toIn) (nat10 |> Nat.N.toIn)
            --nats from 0 to 10
            |> List.map
                (Nat.Min.dropMax
                    --we can no longer compute the maximum
                    >> Nat.Min.toPower 2
                    --we can't compute the exact minimum
                    --but we know its at least Nat0
                )
    ```
- keep your _function annotations as general as possible_
    
    Instead of accepting only values where you know the values exact
  ```elm
  rgb : Nat (N red (Is inverseRed To Nat100) x) --...
  ```
    accept values that are somewhere in a range.
  ```elm
  rgb : Nat (In redMin Nat100) --...
  ```

Take a look at [`elm-bounded-array`][bounded-array] to see a lot of this in action!

[bounded-array]: https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/
