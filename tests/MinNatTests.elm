module MinNatTests exposing (factorial, suite)

{-| Especially type tests.
-}

import Expect
import Nat exposing (Nat)
import Nat.Bound exposing (Min)
import Nat.In
import Nat.Min
import Nat.N
import Nat.N.Type exposing (..)
import Nat.Ns exposing (..)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "MinNat"
        [ test "factorial"
            (\() ->
                factorial (nat4 |> Nat.N.toMin)
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


factorialHelp : Nat (Min Nat0) -> Nat (Min Nat1)
factorialHelp =
    Nat.Min.isAtLeast (nat1 |> Nat.N.toIn)
        { min = nat0 }
        { less = \_ -> nat1 |> Nat.N.toMin
        , equalOrGreater =
            \gt0 ->
                Nat.Min.mul
                    (factorialHelp (gt0 |> Nat.Min.subN nat1))
                    gt0
        }


factorial : Nat (Min min) -> Nat (Min Nat1)
factorial =
    Nat.Min.lowerMin (nat0 |> Nat.N.toIn) >> factorialHelp


listLength : List a -> Nat (Min Nat0)
listLength =
    List.foldl
        (\_ -> Nat.Min.addN nat1 >> Nat.Min.lowerMin (nat0 |> Nat.N.toIn))
        (Nat.N.toMin nat0)



-- type tests


testAdd : Nat (Min Nat4)
testAdd =
    Nat.Min.intAtLeast (nat3 |> Nat.N.toMin) 7
        |> Nat.Min.add (Nat.Min.intAtLeast (nat1 |> Nat.N.toMin) 9) nat1


testAddN : Nat (Min Nat15)
testAddN =
    Nat.Min.intAtLeast (nat6 |> Nat.N.toMin) 7
        |> Nat.Min.addN nat9


testSubIn : Nat (Min Nat1)
testSubIn =
    Nat.Min.intAtLeast (nat6 |> Nat.N.toMin) 7
        |> Nat.Min.subIn
            (Nat.In.intInRange (nat1 |> Nat.N.toIn) (nat5 |> Nat.N.toIn) 4)
            nat5


testSubN : Nat (Min Nat7)
testSubN =
    Nat.Min.intAtLeast (nat16 |> Nat.N.toMin) 17
        |> Nat.Min.subN nat9


testLowerMin : List (Nat (Min Nat3))
testLowerMin =
    [ Nat.N.toMin nat3
    , Nat.N.toMin nat4 |> Nat.Min.lowerMin (nat3 |> Nat.N.toIn)
    ]
