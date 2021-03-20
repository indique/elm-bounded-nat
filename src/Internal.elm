module Internal exposing (Nat(..), map, newRange, toInt)


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
