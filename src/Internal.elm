module Internal exposing (Nat(..), add1, map, newRange, sub1, toInt)

import Nat.Bound exposing (Is, N, To)
import Nat.N.Type exposing (..)


type Nat range
    = Nat Int


toInt : Nat range -> Int
toInt =
    \(Nat int) -> int


map : (Int -> Int) -> Nat range -> Nat mappedRange
map update =
    toInt >> update >> Nat


newRange : Nat min -> Nat newMin
newRange =
    toInt >> Nat


add1 :
    Nat (N n (Is a To nPlusA) (Is b To nPlusB))
    ->
        Nat
            (N
                (Nat1Plus n)
                (Is a To (Nat1Plus nPlusA))
                (Is b To (Nat1Plus nPlusB))
            )
add1 =
    map ((+) 1)


sub1 :
    Nat
        (N
            (Nat1Plus nMinus1)
            (Is a To (Nat1Plus nMinus1PlusA))
            (Is b To (Nat1Plus nMinus1PlusB))
        )
    -> Nat (N nMinus1 (Is a To nMinus1PlusA) (Is b To nMinus1PlusB))
sub1 =
    map (\x -> x - 1)
