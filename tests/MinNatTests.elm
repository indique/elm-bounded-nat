module MinNatTests exposing (factorial, suite)

{-| Especially type tests.
-}

import Expect
import Nat exposing (Nat)
import Nat.Bound exposing (In, Min, N)
import Nat.In
import Nat.Min
import Nat.N exposing (..)
import Nat.N.Type exposing (..)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "MinNat"
        [ test "factorial"
            (\() ->
                factorial (nat4 |> Nat.Min.n)
                    |> Nat.toInt
                    |> Expect.equal 24
            )
        ]



--recurses idefinitely for negative integers


intFactorial : Int -> Int
intFactorial x =
    if x == 0 then
        1

    else
        x * intFactorial (x - 1)


natFactorial : Nat (Min Nat0) -> Nat (Min Nat1)
natFactorial =
    Nat.Min.isAtLeast nat1
        { min = nat0 }
        { less = \_ -> Nat.Min.n nat1
        , equalOrGreater =
            \oneOrGreater ->
                oneOrGreater
                    |> Nat.Min.mul
                        (natFactorial
                            (oneOrGreater |> Nat.Min.subN nat1)
                        )
        }


factorial : Nat (Min min) -> Nat (Min Nat1)
factorial =
    Nat.Min.lowerMin nat0 >> natFactorial


listLength : List a -> Nat (Min Nat0)
listLength =
    List.foldl
        (\_ -> Nat.Min.addN nat1 >> Nat.Min.lowerMin nat0)
        (Nat.Min.n nat0)



-- type tests


testAdd : Nat (Min Nat4)
testAdd =
    Nat.Min.intAtLeast nat3 7
        |> Nat.Min.add (Nat.Min.intAtLeast nat1 9) nat1


testAddN : Nat (Min Nat15)
testAddN =
    Nat.Min.intAtLeast nat6 7
        |> Nat.Min.addN nat9


testSubIn : Nat (Min Nat1)
testSubIn =
    Nat.Min.intAtLeast nat6 7
        |> Nat.Min.subIn (Nat.In.intInRange nat1 nat5 4) nat5


testSubN : Nat (Min Nat7)
testSubN =
    Nat.Min.intAtLeast nat16 17
        |> Nat.Min.subN nat9


testLowerMin : List (Nat (Min Nat3))
testLowerMin =
    [ Nat.Min.n nat3
    , Nat.Min.n nat4 |> Nat.Min.lowerMin nat3
    ]
