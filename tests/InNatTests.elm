module InNatTests exposing (suite)

{-| Especially type tests.
-}

import Expect
import MinNatTests
import Nat exposing (Nat)
import Nat.Bound exposing (..)
import Nat.In
import Nat.Min
import Nat.N.Type exposing (..)
import Nat.Ns exposing (..)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "bounded-nat"
        [ describe "recursive"
            [ test "ultraSafeFactorial"
                (\() ->
                    ultraSafeFactorial (nat4 |> Nat.In.n)
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


ultraSafeFactorial : Nat (In min Nat18) -> Nat (Min Nat1)
ultraSafeFactorial =
    Nat.In.dropMax >> MinNatTests.factorial



--


testAdd : Nat (In Nat4 (Nat22Plus a))
testAdd =
    Nat.In.intInRange nat3 nat10 7
        |> Nat.In.add (Nat.In.intInRange nat1 nat12 9) nat1 nat12


testAddN : Nat (In Nat15 (Nat19Plus a))
testAddN =
    Nat.In.intInRange nat6 nat10 7
        |> Nat.In.addN ( nat9, nat9 )


testSub : Nat (In Nat1 (Nat9Plus a))
testSub =
    Nat.In.intInRange nat6 nat10 7
        |> Nat.In.sub (Nat.In.intInRange nat1 nat5 4) nat1 nat5


testSubN : Nat (In Nat7 (Nat11Plus a))
testSubN =
    Nat.In.intInRange nat16 nat20 17
        |> Nat.In.subN ( nat9, nat9 )


testLowerMin : List (Nat (In Nat3 (Nat4Plus a)))
testLowerMin =
    [ Nat.In.n nat3
    , Nat.In.n nat4 |> Nat.In.lowerMin nat3
    ]
