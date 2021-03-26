module InNatTests exposing (suite)

{-| Especially type tests.
-}

import Expect
import InNat
import MinNat
import MinNatTests
import NNat
import NNats exposing (..)
import Nat exposing (Nat)
import Nat.Bound exposing (..)
import Nat.N.Type exposing (..)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "bounded-nat"
        [ describe "recursive"
            [ test "ultraSafeFactorial"
                (\() ->
                    ultraSafeFactorial (nat4 |> NNat.toIn)
                        |> Nat.toInt
                        |> Expect.equal 24
                )
            ]
        ]



--recurses idefinitely for negative integers


intFactorial : Int -> Int
intFactorial x =
    if x == 0 then
        1

    else
        x * intFactorial (x - 1)


natFactorial : Nat (In Nat0 max) -> Nat (Min Nat1)
natFactorial =
    MinNat.isAtLeast (nat1 |> NNat.toIn)
        { min = nat0 }
        { less = \_ -> nat1 |> NNat.toMin
        , equalOrGreater =
            \atLeast1 ->
                atLeast1
                    |> InNat.mul
                        (natFactorial
                            (atLeast1 |> MinNat.subN nat1)
                        )
        }


factorial : Nat (In min max) -> Nat (Min Nat1)
factorial =
    InNat.lowerMin (nat0 |> NNat.toIn) >> natFactorial


ultraSafeFactorial : Nat (In min Nat18) -> Nat (Min Nat1)
ultraSafeFactorial =
    MinNatTests.factorial



--


testAdd : Nat (In Nat4 (Nat22Plus a))
testAdd =
    Nat.intInRange (nat3 |> NNat.toIn) (nat10 |> NNat.toIn) 7
        |> InNat.add (Nat.intInRange (nat1 |> NNat.toIn) (nat12 |> NNat.toIn) 9) nat1 nat12


testAddN : Nat (In Nat15 (Nat19Plus a))
testAddN =
    Nat.intInRange (nat6 |> NNat.toIn) (nat10 |> NNat.toIn) 7
        |> InNat.addN nat9


testSub : Nat (In Nat1 (Nat9Plus a))
testSub =
    Nat.intInRange (nat6 |> NNat.toIn) (nat10 |> NNat.toIn) 7
        |> InNat.sub (Nat.intInRange (nat1 |> NNat.toIn) (nat5 |> NNat.toIn) 4)
            nat1
            nat5


testSubN : Nat (In Nat7 (Nat11Plus a))
testSubN =
    Nat.intInRange (nat16 |> NNat.toIn) (nat20 |> NNat.toIn) 17
        |> InNat.subN nat9


testLowerMin : List (Nat (In Nat3 (Nat4Plus a)))
testLowerMin =
    [ NNat.toIn nat3
    , NNat.toIn nat4 |> InNat.lowerMin (nat3 |> NNat.toIn)
    ]


rgbPer100 :
    Nat (In redMin Nat100)
    -> Nat (In greenMin Nat100)
    -> Nat (In blueMin Nat100)
    -> ()
rgbPer100 _ _ _ =
    ()


grey : Float -> ()
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
