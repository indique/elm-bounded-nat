module MinNatTests exposing (factorial, suite)

{-| Especially type tests.
-}

import Expect
import InNat
import MinNat
import NNat
import NNats exposing (..)
import Nat exposing (Nat)
import Nat.Bound exposing (In, Min)
import Nat.N.Type exposing (..)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "MinNat"
        [ test "factorial"
            (\() ->
                factorial (nat4 |> NNat.toMin)
                    |> Nat.toInt
                    |> Expect.equal 24
            )
        ]


{-| recurses idefinitely for negative integers
-}
intFactorial : Int -> Int
intFactorial x =
    if x == 0 then
        1

    else
        x * intFactorial (x - 1)


factorialHelp : Nat (In Nat0 max) -> Nat (Min Nat1)
factorialHelp =
    MinNat.isAtLeast (nat1 |> NNat.toIn)
        { min = nat0 }
        { less = \_ -> nat1 |> NNat.toMin
        , equalOrGreater =
            \atLeast1 ->
                InNat.mul
                    (factorialHelp (atLeast1 |> MinNat.subN nat1))
                    atLeast1
        }


factorial : Nat (In min max) -> Nat (Min Nat1)
factorial =
    InNat.lowerMin (nat0 |> NNat.toIn) >> factorialHelp


listLength : List a -> Nat (Min Nat0)
listLength =
    List.foldl
        (\_ ->
            MinNat.addN nat1
                >> InNat.lowerMin (nat0 |> NNat.toIn)
        )
        (nat0 |> NNat.toMin)



-- type tests


testAdd : Nat (Min Nat4)
testAdd =
    Nat.intAtLeast (nat3 |> NNat.toMin) 7
        |> MinNat.add (Nat.intAtLeast (nat1 |> NNat.toMin) 9) nat1


testAddN : Nat (Min Nat15)
testAddN =
    Nat.intAtLeast (nat6 |> NNat.toMin) 7
        |> MinNat.addN nat9


testSubIn : Nat (Min Nat1)
testSubIn =
    Nat.intAtLeast (nat6 |> NNat.toMin) 7
        |> MinNat.sub
            (Nat.intInRange (nat1 |> NNat.toIn) (nat5 |> NNat.toIn) 4)
            nat5


testSubN : Nat (Min Nat7)
testSubN =
    Nat.intAtLeast (nat16 |> NNat.toMin) 17
        |> MinNat.subN nat9


testLowerMin : List (Nat (Min Nat3))
testLowerMin =
    [ NNat.toMin nat3
    , NNat.toMin nat4 |> InNat.lowerMin (nat3 |> NNat.toIn)
    ]
