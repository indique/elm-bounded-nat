module Internal exposing (Nat(..), add1, map, newRange, sub1, toInt)

import Nat.Bound exposing (Difference, Is, N, To)
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
    Nat (N n Is (Difference a To nPlusA))
    -> Nat (N (Nat1Plus n) Is (Difference a To (Nat1Plus nPlusA)))
add1 =
    map ((+) 1)


sub1 :
    Nat (N (Nat1Plus nMinus1) Is (Difference a To (Nat1Plus nMinus1PlusA)))
    -> Nat (N nMinus1 Is (Difference a To nMinus1PlusA))
sub1 =
    map (\x -> x - 1)
