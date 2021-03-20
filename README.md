## elm-bounded-nat

Current attempts of represening natural numbers `>= 0` only have quite lose promises.

- If you know that your `Nat` is >= 3, why can't you subtract 1 or 2 or 3?

This package contains many ways to ensure that a `Nat` is in a range _at compile-time_.

- `Min` knows what a minimum value:  `⨯[✓✓✓✓✓✓✓...`
- `In` knows the range it's in:  `⨯⨯[✓✓✓]⨯⨯...`
- `N` & `Only`, know the _actual value_: `⨯✓⨯⨯⨯⨯...`

Setup

```noformatingplease
elm install indique/elm-bounded-nat
```

```elm
import Nat exposing (Nat)
import Nat.Bound exposing (..)
    --In, Min, Only, N, Difference, Is, To
import Nat.Min
import Nat.In
import Nat.N exposing (..) --nat0 to nat192

import Nat.N.Type exposing (..)
    --Nat0 to Nat192 & Nat0Plus to Nat192Plus
```

## 2 examples


### `color`

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
              (float * 100) |> floor
                  |> Nat.In.intInRange nat0 nat100 --easy
      in
      rgbPer100 from0To100 from0To100 from0To100
  ```
- already knowing
  ```elm
  nat100
  -- of type NNat Nat100
  -- → We know the EXACT value
      |> Nat.In.n
      -- → it must also be in range 100 to 100 + ...
  red =
    rgbPer100 (nat100 |> Nat.In.n)
        (nat0 |> Nat.In.n) (nat0 |> Nat.In.n)
        -- 👍
  ```
- checking
  ```elm
  isUserIntANat : Int -> Maybe (Nat (Min Nat0))
  isUserIntANat =
      Nat.Min.isAtLeast nat0
          { equalOrGreater = Just
          , less = \_-> Nothing
          }
  ```

- There are more ways, but this is enough to understand the idea 🙂.

&emsp;



### `factorial`

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
    Nat.Min.isAtLeast nat1
        { min = nat0 } -- the minimum of the x
        { less = \_ -> Nat.Min.n nat1 -- x < 1 ? → then 1
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
    Nat.Min.lowerMin nat0 >> factorialHelp
```

→ `factorial (Nat.Min.n nat4) |> Nat.Min.toInt --> 24`

→ There is no way to put a negative number in.

→ We have the extra promise, that every result `is >= 1`

We can do even better!
We know that `!19` is already bigger than the maximum safe `Int` `2^53 - 1`.

```elm
safeFactorial : Nat (In min N18Nat) -> Nat (Min Nat1)
safeFactorial =
    Nat.Min.fromIn >> factorial
```


## tips

- keep as much type information as possible and drop it only where you don't need it.
    ```elm
    squaresTo10 =
        Nat.In.range nat0 nat10
            --nats from 0 to 10
            |> List.map
                (Nat.Min.dropMax
                    --we can no longer compute the maximum
                    >> Nat.Min.toPower 2
                    --we can't compute the exact minimum
                    --but we know its at least Nat0
                )
    ```
- keep your function annotations as general as possible
    
    Instead of accepting only values where you know the values exact
  ```elm
  rgb : Nat (N red Is (Difference inverseRed To Nat100)) --...
  ```
    accept values that are somewhere in a range.
  ```elm
  rgb : Nat (In redMin Nat100) --...
  ```

Take a look at [`elm-bounded-array`][bounded-array] to see `Nat.In` in action!

[bounded-array]: https://package.elm-lang.org/packages/indique/elm-bounded-array/latest/
