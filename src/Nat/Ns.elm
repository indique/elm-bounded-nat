module Nat.Ns exposing (nat0, nat1, nat10, nat100, nat101, nat102, nat103, nat104, nat105, nat106, nat107, nat108, nat109, nat11, nat110, nat111, nat112, nat113, nat114, nat115, nat116, nat117, nat118, nat119, nat12, nat120, nat121, nat122, nat123, nat124, nat125, nat126, nat127, nat128, nat129, nat13, nat130, nat131, nat132, nat133, nat134, nat135, nat136, nat137, nat138, nat139, nat14, nat140, nat141, nat142, nat143, nat144, nat145, nat146, nat147, nat148, nat149, nat15, nat150, nat151, nat152, nat153, nat154, nat155, nat156, nat157, nat158, nat159, nat16, nat160, nat161, nat162, nat163, nat164, nat165, nat166, nat167, nat168, nat169, nat17, nat170, nat171, nat172, nat173, nat174, nat175, nat176, nat177, nat178, nat179, nat18, nat180, nat181, nat182, nat183, nat184, nat185, nat186, nat187, nat188, nat189, nat19, nat190, nat191, nat192, nat2, nat20, nat21, nat22, nat23, nat24, nat25, nat26, nat27, nat28, nat29, nat3, nat30, nat31, nat32, nat33, nat34, nat35, nat36, nat37, nat38, nat39, nat4, nat40, nat41, nat42, nat43, nat44, nat45, nat46, nat47, nat48, nat49, nat5, nat50, nat51, nat52, nat53, nat54, nat55, nat56, nat57, nat58, nat59, nat6, nat60, nat61, nat62, nat63, nat64, nat65, nat66, nat67, nat68, nat69, nat7, nat70, nat71, nat72, nat73, nat74, nat75, nat76, nat77, nat78, nat79, nat8, nat80, nat81, nat82, nat83, nat84, nat85, nat86, nat87, nat88, nat89, nat9, nat90, nat91, nat92, nat93, nat94, nat95, nat96, nat97, nat98, nat99)

{-| `Nat (N Nat0 ...)` to `Nat (N Nat192 ...)`.


See [`Nat.Bound.N`](Nat-Bound#N) & [`Nat.N`](Nat#N) for a explanation.


@docs nat0, nat1, nat10, nat100, nat101, nat102, nat103, nat104, nat105, nat106, nat107
@docs nat108, nat109, nat11, nat110, nat111, nat112, nat113, nat114, nat115, nat116
@docs nat117, nat118, nat119, nat12, nat120, nat121, nat122, nat123, nat124, nat125
@docs nat126, nat127, nat128, nat129, nat13, nat130, nat131, nat132, nat133, nat134
@docs nat135, nat136, nat137, nat138, nat139, nat14, nat140, nat141, nat142, nat143
@docs nat144, nat145, nat146, nat147, nat148, nat149, nat15, nat150, nat151, nat152
@docs nat153, nat154, nat155, nat156, nat157, nat158, nat159, nat16, nat160, nat161
@docs nat162, nat163, nat164, nat165, nat166, nat167, nat168, nat169, nat17, nat170
@docs nat171, nat172, nat173, nat174, nat175, nat176, nat177, nat178, nat179, nat18
@docs nat180, nat181, nat182, nat183, nat184, nat185, nat186, nat187, nat188, nat189
@docs nat19, nat190, nat191, nat192, nat2, nat20, nat21, nat22, nat23, nat24, nat25, nat26
@docs nat27, nat28, nat29, nat3, nat30, nat31, nat32, nat33, nat34, nat35, nat36, nat37, nat38
@docs nat39, nat4, nat40, nat41, nat42, nat43, nat44, nat45, nat46, nat47, nat48, nat49, nat5
@docs nat50, nat51, nat52, nat53, nat54, nat55, nat56, nat57, nat58, nat59, nat6, nat60, nat61
@docs nat62, nat63, nat64, nat65, nat66, nat67, nat68, nat69, nat7, nat70, nat71, nat72, nat73
@docs nat74, nat75, nat76, nat77, nat78, nat79, nat8, nat80, nat81, nat82, nat83, nat84, nat85
@docs nat86, nat87, nat88, nat89, nat9, nat90, nat91, nat92, nat93, nat94, nat95, nat96, nat97
@docs nat98, nat99
-}

import Internal exposing (add1)
import Nat exposing (Nat)
import Nat.Bound exposing (And, IsBoth, N, To)
import Nat.N.Type exposing (..)


{-| The `Nat` 0.


-}
nat0 : Nat (N Nat0 (IsBoth a To a And b To b))
nat0 =
    Internal.Nat 0


{-| The `Nat` 1.


-}
nat1 :
    Nat (N Nat1 (IsBoth a To (Nat1Plus a) And b To (Nat1Plus b)))
nat1 =
    nat0 |> add1


{-| The `Nat` 2.


-}
nat2 :
    Nat (N Nat2 (IsBoth a To (Nat2Plus a) And b To (Nat2Plus b)))
nat2 =
    nat1 |> add1


{-| The `Nat` 3.


-}
nat3 :
    Nat (N Nat3 (IsBoth a To (Nat3Plus a) And b To (Nat3Plus b)))
nat3 =
    nat2 |> add1


{-| The `Nat` 4.


-}
nat4 :
    Nat (N Nat4 (IsBoth a To (Nat4Plus a) And b To (Nat4Plus b)))
nat4 =
    nat3 |> add1


{-| The `Nat` 5.


-}
nat5 :
    Nat (N Nat5 (IsBoth a To (Nat5Plus a) And b To (Nat5Plus b)))
nat5 =
    nat4 |> add1


{-| The `Nat` 6.


-}
nat6 :
    Nat (N Nat6 (IsBoth a To (Nat6Plus a) And b To (Nat6Plus b)))
nat6 =
    nat5 |> add1


{-| The `Nat` 7.


-}
nat7 :
    Nat (N Nat7 (IsBoth a To (Nat7Plus a) And b To (Nat7Plus b)))
nat7 =
    nat6 |> add1


{-| The `Nat` 8.


-}
nat8 :
    Nat (N Nat8 (IsBoth a To (Nat8Plus a) And b To (Nat8Plus b)))
nat8 =
    nat7 |> add1


{-| The `Nat` 9.


-}
nat9 :
    Nat (N Nat9 (IsBoth a To (Nat9Plus a) And b To (Nat9Plus b)))
nat9 =
    nat8 |> add1


{-| The `Nat` 10.


-}
nat10 :
    Nat (N Nat10 (IsBoth a To (Nat10Plus a) And b To (Nat10Plus b)))
nat10 =
    nat9 |> add1


{-| The `Nat` 11.


-}
nat11 :
    Nat (N Nat11 (IsBoth a To (Nat11Plus a) And b To (Nat11Plus b)))
nat11 =
    nat10 |> add1


{-| The `Nat` 12.


-}
nat12 :
    Nat (N Nat12 (IsBoth a To (Nat12Plus a) And b To (Nat12Plus b)))
nat12 =
    nat11 |> add1


{-| The `Nat` 13.


-}
nat13 :
    Nat (N Nat13 (IsBoth a To (Nat13Plus a) And b To (Nat13Plus b)))
nat13 =
    nat12 |> add1


{-| The `Nat` 14.


-}
nat14 :
    Nat (N Nat14 (IsBoth a To (Nat14Plus a) And b To (Nat14Plus b)))
nat14 =
    nat13 |> add1


{-| The `Nat` 15.


-}
nat15 :
    Nat (N Nat15 (IsBoth a To (Nat15Plus a) And b To (Nat15Plus b)))
nat15 =
    nat14 |> add1


{-| The `Nat` 16.


-}
nat16 :
    Nat (N Nat16 (IsBoth a To (Nat16Plus a) And b To (Nat16Plus b)))
nat16 =
    nat15 |> add1


{-| The `Nat` 17.


-}
nat17 :
    Nat (N Nat17 (IsBoth a To (Nat17Plus a) And b To (Nat17Plus b)))
nat17 =
    nat16 |> add1


{-| The `Nat` 18.


-}
nat18 :
    Nat (N Nat18 (IsBoth a To (Nat18Plus a) And b To (Nat18Plus b)))
nat18 =
    nat17 |> add1


{-| The `Nat` 19.


-}
nat19 :
    Nat (N Nat19 (IsBoth a To (Nat19Plus a) And b To (Nat19Plus b)))
nat19 =
    nat18 |> add1


{-| The `Nat` 20.


-}
nat20 :
    Nat (N Nat20 (IsBoth a To (Nat20Plus a) And b To (Nat20Plus b)))
nat20 =
    nat19 |> add1


{-| The `Nat` 21.


-}
nat21 :
    Nat (N Nat21 (IsBoth a To (Nat21Plus a) And b To (Nat21Plus b)))
nat21 =
    nat20 |> add1


{-| The `Nat` 22.


-}
nat22 :
    Nat (N Nat22 (IsBoth a To (Nat22Plus a) And b To (Nat22Plus b)))
nat22 =
    nat21 |> add1


{-| The `Nat` 23.


-}
nat23 :
    Nat (N Nat23 (IsBoth a To (Nat23Plus a) And b To (Nat23Plus b)))
nat23 =
    nat22 |> add1


{-| The `Nat` 24.


-}
nat24 :
    Nat (N Nat24 (IsBoth a To (Nat24Plus a) And b To (Nat24Plus b)))
nat24 =
    nat23 |> add1


{-| The `Nat` 25.


-}
nat25 :
    Nat (N Nat25 (IsBoth a To (Nat25Plus a) And b To (Nat25Plus b)))
nat25 =
    nat24 |> add1


{-| The `Nat` 26.


-}
nat26 :
    Nat (N Nat26 (IsBoth a To (Nat26Plus a) And b To (Nat26Plus b)))
nat26 =
    nat25 |> add1


{-| The `Nat` 27.


-}
nat27 :
    Nat (N Nat27 (IsBoth a To (Nat27Plus a) And b To (Nat27Plus b)))
nat27 =
    nat26 |> add1


{-| The `Nat` 28.


-}
nat28 :
    Nat (N Nat28 (IsBoth a To (Nat28Plus a) And b To (Nat28Plus b)))
nat28 =
    nat27 |> add1


{-| The `Nat` 29.


-}
nat29 :
    Nat (N Nat29 (IsBoth a To (Nat29Plus a) And b To (Nat29Plus b)))
nat29 =
    nat28 |> add1


{-| The `Nat` 30.


-}
nat30 :
    Nat (N Nat30 (IsBoth a To (Nat30Plus a) And b To (Nat30Plus b)))
nat30 =
    nat29 |> add1


{-| The `Nat` 31.


-}
nat31 :
    Nat (N Nat31 (IsBoth a To (Nat31Plus a) And b To (Nat31Plus b)))
nat31 =
    nat30 |> add1


{-| The `Nat` 32.


-}
nat32 :
    Nat (N Nat32 (IsBoth a To (Nat32Plus a) And b To (Nat32Plus b)))
nat32 =
    nat31 |> add1


{-| The `Nat` 33.


-}
nat33 :
    Nat (N Nat33 (IsBoth a To (Nat33Plus a) And b To (Nat33Plus b)))
nat33 =
    nat32 |> add1


{-| The `Nat` 34.


-}
nat34 :
    Nat (N Nat34 (IsBoth a To (Nat34Plus a) And b To (Nat34Plus b)))
nat34 =
    nat33 |> add1


{-| The `Nat` 35.


-}
nat35 :
    Nat (N Nat35 (IsBoth a To (Nat35Plus a) And b To (Nat35Plus b)))
nat35 =
    nat34 |> add1


{-| The `Nat` 36.


-}
nat36 :
    Nat (N Nat36 (IsBoth a To (Nat36Plus a) And b To (Nat36Plus b)))
nat36 =
    nat35 |> add1


{-| The `Nat` 37.


-}
nat37 :
    Nat (N Nat37 (IsBoth a To (Nat37Plus a) And b To (Nat37Plus b)))
nat37 =
    nat36 |> add1


{-| The `Nat` 38.


-}
nat38 :
    Nat (N Nat38 (IsBoth a To (Nat38Plus a) And b To (Nat38Plus b)))
nat38 =
    nat37 |> add1


{-| The `Nat` 39.


-}
nat39 :
    Nat (N Nat39 (IsBoth a To (Nat39Plus a) And b To (Nat39Plus b)))
nat39 =
    nat38 |> add1


{-| The `Nat` 40.


-}
nat40 :
    Nat (N Nat40 (IsBoth a To (Nat40Plus a) And b To (Nat40Plus b)))
nat40 =
    nat39 |> add1


{-| The `Nat` 41.


-}
nat41 :
    Nat (N Nat41 (IsBoth a To (Nat41Plus a) And b To (Nat41Plus b)))
nat41 =
    nat40 |> add1


{-| The `Nat` 42.


-}
nat42 :
    Nat (N Nat42 (IsBoth a To (Nat42Plus a) And b To (Nat42Plus b)))
nat42 =
    nat41 |> add1


{-| The `Nat` 43.


-}
nat43 :
    Nat (N Nat43 (IsBoth a To (Nat43Plus a) And b To (Nat43Plus b)))
nat43 =
    nat42 |> add1


{-| The `Nat` 44.


-}
nat44 :
    Nat (N Nat44 (IsBoth a To (Nat44Plus a) And b To (Nat44Plus b)))
nat44 =
    nat43 |> add1


{-| The `Nat` 45.


-}
nat45 :
    Nat (N Nat45 (IsBoth a To (Nat45Plus a) And b To (Nat45Plus b)))
nat45 =
    nat44 |> add1


{-| The `Nat` 46.


-}
nat46 :
    Nat (N Nat46 (IsBoth a To (Nat46Plus a) And b To (Nat46Plus b)))
nat46 =
    nat45 |> add1


{-| The `Nat` 47.


-}
nat47 :
    Nat (N Nat47 (IsBoth a To (Nat47Plus a) And b To (Nat47Plus b)))
nat47 =
    nat46 |> add1


{-| The `Nat` 48.


-}
nat48 :
    Nat (N Nat48 (IsBoth a To (Nat48Plus a) And b To (Nat48Plus b)))
nat48 =
    nat47 |> add1


{-| The `Nat` 49.


-}
nat49 :
    Nat (N Nat49 (IsBoth a To (Nat49Plus a) And b To (Nat49Plus b)))
nat49 =
    nat48 |> add1


{-| The `Nat` 50.


-}
nat50 :
    Nat (N Nat50 (IsBoth a To (Nat50Plus a) And b To (Nat50Plus b)))
nat50 =
    nat49 |> add1


{-| The `Nat` 51.


-}
nat51 :
    Nat (N Nat51 (IsBoth a To (Nat51Plus a) And b To (Nat51Plus b)))
nat51 =
    nat50 |> add1


{-| The `Nat` 52.


-}
nat52 :
    Nat (N Nat52 (IsBoth a To (Nat52Plus a) And b To (Nat52Plus b)))
nat52 =
    nat51 |> add1


{-| The `Nat` 53.


-}
nat53 :
    Nat (N Nat53 (IsBoth a To (Nat53Plus a) And b To (Nat53Plus b)))
nat53 =
    nat52 |> add1


{-| The `Nat` 54.


-}
nat54 :
    Nat (N Nat54 (IsBoth a To (Nat54Plus a) And b To (Nat54Plus b)))
nat54 =
    nat53 |> add1


{-| The `Nat` 55.


-}
nat55 :
    Nat (N Nat55 (IsBoth a To (Nat55Plus a) And b To (Nat55Plus b)))
nat55 =
    nat54 |> add1


{-| The `Nat` 56.


-}
nat56 :
    Nat (N Nat56 (IsBoth a To (Nat56Plus a) And b To (Nat56Plus b)))
nat56 =
    nat55 |> add1


{-| The `Nat` 57.


-}
nat57 :
    Nat (N Nat57 (IsBoth a To (Nat57Plus a) And b To (Nat57Plus b)))
nat57 =
    nat56 |> add1


{-| The `Nat` 58.


-}
nat58 :
    Nat (N Nat58 (IsBoth a To (Nat58Plus a) And b To (Nat58Plus b)))
nat58 =
    nat57 |> add1


{-| The `Nat` 59.


-}
nat59 :
    Nat (N Nat59 (IsBoth a To (Nat59Plus a) And b To (Nat59Plus b)))
nat59 =
    nat58 |> add1


{-| The `Nat` 60.


-}
nat60 :
    Nat (N Nat60 (IsBoth a To (Nat60Plus a) And b To (Nat60Plus b)))
nat60 =
    nat59 |> add1


{-| The `Nat` 61.


-}
nat61 :
    Nat (N Nat61 (IsBoth a To (Nat61Plus a) And b To (Nat61Plus b)))
nat61 =
    nat60 |> add1


{-| The `Nat` 62.


-}
nat62 :
    Nat (N Nat62 (IsBoth a To (Nat62Plus a) And b To (Nat62Plus b)))
nat62 =
    nat61 |> add1


{-| The `Nat` 63.


-}
nat63 :
    Nat (N Nat63 (IsBoth a To (Nat63Plus a) And b To (Nat63Plus b)))
nat63 =
    nat62 |> add1


{-| The `Nat` 64.


-}
nat64 :
    Nat (N Nat64 (IsBoth a To (Nat64Plus a) And b To (Nat64Plus b)))
nat64 =
    nat63 |> add1


{-| The `Nat` 65.


-}
nat65 :
    Nat (N Nat65 (IsBoth a To (Nat65Plus a) And b To (Nat65Plus b)))
nat65 =
    nat64 |> add1


{-| The `Nat` 66.


-}
nat66 :
    Nat (N Nat66 (IsBoth a To (Nat66Plus a) And b To (Nat66Plus b)))
nat66 =
    nat65 |> add1


{-| The `Nat` 67.


-}
nat67 :
    Nat (N Nat67 (IsBoth a To (Nat67Plus a) And b To (Nat67Plus b)))
nat67 =
    nat66 |> add1


{-| The `Nat` 68.


-}
nat68 :
    Nat (N Nat68 (IsBoth a To (Nat68Plus a) And b To (Nat68Plus b)))
nat68 =
    nat67 |> add1


{-| The `Nat` 69.


-}
nat69 :
    Nat (N Nat69 (IsBoth a To (Nat69Plus a) And b To (Nat69Plus b)))
nat69 =
    nat68 |> add1


{-| The `Nat` 70.


-}
nat70 :
    Nat (N Nat70 (IsBoth a To (Nat70Plus a) And b To (Nat70Plus b)))
nat70 =
    nat69 |> add1


{-| The `Nat` 71.


-}
nat71 :
    Nat (N Nat71 (IsBoth a To (Nat71Plus a) And b To (Nat71Plus b)))
nat71 =
    nat70 |> add1


{-| The `Nat` 72.


-}
nat72 :
    Nat (N Nat72 (IsBoth a To (Nat72Plus a) And b To (Nat72Plus b)))
nat72 =
    nat71 |> add1


{-| The `Nat` 73.


-}
nat73 :
    Nat (N Nat73 (IsBoth a To (Nat73Plus a) And b To (Nat73Plus b)))
nat73 =
    nat72 |> add1


{-| The `Nat` 74.


-}
nat74 :
    Nat (N Nat74 (IsBoth a To (Nat74Plus a) And b To (Nat74Plus b)))
nat74 =
    nat73 |> add1


{-| The `Nat` 75.


-}
nat75 :
    Nat (N Nat75 (IsBoth a To (Nat75Plus a) And b To (Nat75Plus b)))
nat75 =
    nat74 |> add1


{-| The `Nat` 76.


-}
nat76 :
    Nat (N Nat76 (IsBoth a To (Nat76Plus a) And b To (Nat76Plus b)))
nat76 =
    nat75 |> add1


{-| The `Nat` 77.


-}
nat77 :
    Nat (N Nat77 (IsBoth a To (Nat77Plus a) And b To (Nat77Plus b)))
nat77 =
    nat76 |> add1


{-| The `Nat` 78.


-}
nat78 :
    Nat (N Nat78 (IsBoth a To (Nat78Plus a) And b To (Nat78Plus b)))
nat78 =
    nat77 |> add1


{-| The `Nat` 79.


-}
nat79 :
    Nat (N Nat79 (IsBoth a To (Nat79Plus a) And b To (Nat79Plus b)))
nat79 =
    nat78 |> add1


{-| The `Nat` 80.


-}
nat80 :
    Nat (N Nat80 (IsBoth a To (Nat80Plus a) And b To (Nat80Plus b)))
nat80 =
    nat79 |> add1


{-| The `Nat` 81.


-}
nat81 :
    Nat (N Nat81 (IsBoth a To (Nat81Plus a) And b To (Nat81Plus b)))
nat81 =
    nat80 |> add1


{-| The `Nat` 82.


-}
nat82 :
    Nat (N Nat82 (IsBoth a To (Nat82Plus a) And b To (Nat82Plus b)))
nat82 =
    nat81 |> add1


{-| The `Nat` 83.


-}
nat83 :
    Nat (N Nat83 (IsBoth a To (Nat83Plus a) And b To (Nat83Plus b)))
nat83 =
    nat82 |> add1


{-| The `Nat` 84.


-}
nat84 :
    Nat (N Nat84 (IsBoth a To (Nat84Plus a) And b To (Nat84Plus b)))
nat84 =
    nat83 |> add1


{-| The `Nat` 85.


-}
nat85 :
    Nat (N Nat85 (IsBoth a To (Nat85Plus a) And b To (Nat85Plus b)))
nat85 =
    nat84 |> add1


{-| The `Nat` 86.


-}
nat86 :
    Nat (N Nat86 (IsBoth a To (Nat86Plus a) And b To (Nat86Plus b)))
nat86 =
    nat85 |> add1


{-| The `Nat` 87.


-}
nat87 :
    Nat (N Nat87 (IsBoth a To (Nat87Plus a) And b To (Nat87Plus b)))
nat87 =
    nat86 |> add1


{-| The `Nat` 88.


-}
nat88 :
    Nat (N Nat88 (IsBoth a To (Nat88Plus a) And b To (Nat88Plus b)))
nat88 =
    nat87 |> add1


{-| The `Nat` 89.


-}
nat89 :
    Nat (N Nat89 (IsBoth a To (Nat89Plus a) And b To (Nat89Plus b)))
nat89 =
    nat88 |> add1


{-| The `Nat` 90.


-}
nat90 :
    Nat (N Nat90 (IsBoth a To (Nat90Plus a) And b To (Nat90Plus b)))
nat90 =
    nat89 |> add1


{-| The `Nat` 91.


-}
nat91 :
    Nat (N Nat91 (IsBoth a To (Nat91Plus a) And b To (Nat91Plus b)))
nat91 =
    nat90 |> add1


{-| The `Nat` 92.


-}
nat92 :
    Nat (N Nat92 (IsBoth a To (Nat92Plus a) And b To (Nat92Plus b)))
nat92 =
    nat91 |> add1


{-| The `Nat` 93.


-}
nat93 :
    Nat (N Nat93 (IsBoth a To (Nat93Plus a) And b To (Nat93Plus b)))
nat93 =
    nat92 |> add1


{-| The `Nat` 94.


-}
nat94 :
    Nat (N Nat94 (IsBoth a To (Nat94Plus a) And b To (Nat94Plus b)))
nat94 =
    nat93 |> add1


{-| The `Nat` 95.


-}
nat95 :
    Nat (N Nat95 (IsBoth a To (Nat95Plus a) And b To (Nat95Plus b)))
nat95 =
    nat94 |> add1


{-| The `Nat` 96.


-}
nat96 :
    Nat (N Nat96 (IsBoth a To (Nat96Plus a) And b To (Nat96Plus b)))
nat96 =
    nat95 |> add1


{-| The `Nat` 97.


-}
nat97 :
    Nat (N Nat97 (IsBoth a To (Nat97Plus a) And b To (Nat97Plus b)))
nat97 =
    nat96 |> add1


{-| The `Nat` 98.


-}
nat98 :
    Nat (N Nat98 (IsBoth a To (Nat98Plus a) And b To (Nat98Plus b)))
nat98 =
    nat97 |> add1


{-| The `Nat` 99.


-}
nat99 :
    Nat (N Nat99 (IsBoth a To (Nat99Plus a) And b To (Nat99Plus b)))
nat99 =
    nat98 |> add1


{-| The `Nat` 100.


-}
nat100 :
    Nat (N Nat100 (IsBoth a To (Nat100Plus a) And b To (Nat100Plus b)))
nat100 =
    nat99 |> add1


{-| The `Nat` 101.


-}
nat101 :
    Nat (N Nat101 (IsBoth a To (Nat101Plus a) And b To (Nat101Plus b)))
nat101 =
    nat100 |> add1


{-| The `Nat` 102.


-}
nat102 :
    Nat (N Nat102 (IsBoth a To (Nat102Plus a) And b To (Nat102Plus b)))
nat102 =
    nat101 |> add1


{-| The `Nat` 103.


-}
nat103 :
    Nat (N Nat103 (IsBoth a To (Nat103Plus a) And b To (Nat103Plus b)))
nat103 =
    nat102 |> add1


{-| The `Nat` 104.


-}
nat104 :
    Nat (N Nat104 (IsBoth a To (Nat104Plus a) And b To (Nat104Plus b)))
nat104 =
    nat103 |> add1


{-| The `Nat` 105.


-}
nat105 :
    Nat (N Nat105 (IsBoth a To (Nat105Plus a) And b To (Nat105Plus b)))
nat105 =
    nat104 |> add1


{-| The `Nat` 106.


-}
nat106 :
    Nat (N Nat106 (IsBoth a To (Nat106Plus a) And b To (Nat106Plus b)))
nat106 =
    nat105 |> add1


{-| The `Nat` 107.


-}
nat107 :
    Nat (N Nat107 (IsBoth a To (Nat107Plus a) And b To (Nat107Plus b)))
nat107 =
    nat106 |> add1


{-| The `Nat` 108.


-}
nat108 :
    Nat (N Nat108 (IsBoth a To (Nat108Plus a) And b To (Nat108Plus b)))
nat108 =
    nat107 |> add1


{-| The `Nat` 109.


-}
nat109 :
    Nat (N Nat109 (IsBoth a To (Nat109Plus a) And b To (Nat109Plus b)))
nat109 =
    nat108 |> add1


{-| The `Nat` 110.


-}
nat110 :
    Nat (N Nat110 (IsBoth a To (Nat110Plus a) And b To (Nat110Plus b)))
nat110 =
    nat109 |> add1


{-| The `Nat` 111.


-}
nat111 :
    Nat (N Nat111 (IsBoth a To (Nat111Plus a) And b To (Nat111Plus b)))
nat111 =
    nat110 |> add1


{-| The `Nat` 112.


-}
nat112 :
    Nat (N Nat112 (IsBoth a To (Nat112Plus a) And b To (Nat112Plus b)))
nat112 =
    nat111 |> add1


{-| The `Nat` 113.


-}
nat113 :
    Nat (N Nat113 (IsBoth a To (Nat113Plus a) And b To (Nat113Plus b)))
nat113 =
    nat112 |> add1


{-| The `Nat` 114.


-}
nat114 :
    Nat (N Nat114 (IsBoth a To (Nat114Plus a) And b To (Nat114Plus b)))
nat114 =
    nat113 |> add1


{-| The `Nat` 115.


-}
nat115 :
    Nat (N Nat115 (IsBoth a To (Nat115Plus a) And b To (Nat115Plus b)))
nat115 =
    nat114 |> add1


{-| The `Nat` 116.


-}
nat116 :
    Nat (N Nat116 (IsBoth a To (Nat116Plus a) And b To (Nat116Plus b)))
nat116 =
    nat115 |> add1


{-| The `Nat` 117.


-}
nat117 :
    Nat (N Nat117 (IsBoth a To (Nat117Plus a) And b To (Nat117Plus b)))
nat117 =
    nat116 |> add1


{-| The `Nat` 118.


-}
nat118 :
    Nat (N Nat118 (IsBoth a To (Nat118Plus a) And b To (Nat118Plus b)))
nat118 =
    nat117 |> add1


{-| The `Nat` 119.


-}
nat119 :
    Nat (N Nat119 (IsBoth a To (Nat119Plus a) And b To (Nat119Plus b)))
nat119 =
    nat118 |> add1


{-| The `Nat` 120.


-}
nat120 :
    Nat (N Nat120 (IsBoth a To (Nat120Plus a) And b To (Nat120Plus b)))
nat120 =
    nat119 |> add1


{-| The `Nat` 121.


-}
nat121 :
    Nat (N Nat121 (IsBoth a To (Nat121Plus a) And b To (Nat121Plus b)))
nat121 =
    nat120 |> add1


{-| The `Nat` 122.


-}
nat122 :
    Nat (N Nat122 (IsBoth a To (Nat122Plus a) And b To (Nat122Plus b)))
nat122 =
    nat121 |> add1


{-| The `Nat` 123.


-}
nat123 :
    Nat (N Nat123 (IsBoth a To (Nat123Plus a) And b To (Nat123Plus b)))
nat123 =
    nat122 |> add1


{-| The `Nat` 124.


-}
nat124 :
    Nat (N Nat124 (IsBoth a To (Nat124Plus a) And b To (Nat124Plus b)))
nat124 =
    nat123 |> add1


{-| The `Nat` 125.


-}
nat125 :
    Nat (N Nat125 (IsBoth a To (Nat125Plus a) And b To (Nat125Plus b)))
nat125 =
    nat124 |> add1


{-| The `Nat` 126.


-}
nat126 :
    Nat (N Nat126 (IsBoth a To (Nat126Plus a) And b To (Nat126Plus b)))
nat126 =
    nat125 |> add1


{-| The `Nat` 127.


-}
nat127 :
    Nat (N Nat127 (IsBoth a To (Nat127Plus a) And b To (Nat127Plus b)))
nat127 =
    nat126 |> add1


{-| The `Nat` 128.


-}
nat128 :
    Nat (N Nat128 (IsBoth a To (Nat128Plus a) And b To (Nat128Plus b)))
nat128 =
    nat127 |> add1


{-| The `Nat` 129.


-}
nat129 :
    Nat (N Nat129 (IsBoth a To (Nat129Plus a) And b To (Nat129Plus b)))
nat129 =
    nat128 |> add1


{-| The `Nat` 130.


-}
nat130 :
    Nat (N Nat130 (IsBoth a To (Nat130Plus a) And b To (Nat130Plus b)))
nat130 =
    nat129 |> add1


{-| The `Nat` 131.


-}
nat131 :
    Nat (N Nat131 (IsBoth a To (Nat131Plus a) And b To (Nat131Plus b)))
nat131 =
    nat130 |> add1


{-| The `Nat` 132.


-}
nat132 :
    Nat (N Nat132 (IsBoth a To (Nat132Plus a) And b To (Nat132Plus b)))
nat132 =
    nat131 |> add1


{-| The `Nat` 133.


-}
nat133 :
    Nat (N Nat133 (IsBoth a To (Nat133Plus a) And b To (Nat133Plus b)))
nat133 =
    nat132 |> add1


{-| The `Nat` 134.


-}
nat134 :
    Nat (N Nat134 (IsBoth a To (Nat134Plus a) And b To (Nat134Plus b)))
nat134 =
    nat133 |> add1


{-| The `Nat` 135.


-}
nat135 :
    Nat (N Nat135 (IsBoth a To (Nat135Plus a) And b To (Nat135Plus b)))
nat135 =
    nat134 |> add1


{-| The `Nat` 136.


-}
nat136 :
    Nat (N Nat136 (IsBoth a To (Nat136Plus a) And b To (Nat136Plus b)))
nat136 =
    nat135 |> add1


{-| The `Nat` 137.


-}
nat137 :
    Nat (N Nat137 (IsBoth a To (Nat137Plus a) And b To (Nat137Plus b)))
nat137 =
    nat136 |> add1


{-| The `Nat` 138.


-}
nat138 :
    Nat (N Nat138 (IsBoth a To (Nat138Plus a) And b To (Nat138Plus b)))
nat138 =
    nat137 |> add1


{-| The `Nat` 139.


-}
nat139 :
    Nat (N Nat139 (IsBoth a To (Nat139Plus a) And b To (Nat139Plus b)))
nat139 =
    nat138 |> add1


{-| The `Nat` 140.


-}
nat140 :
    Nat (N Nat140 (IsBoth a To (Nat140Plus a) And b To (Nat140Plus b)))
nat140 =
    nat139 |> add1


{-| The `Nat` 141.


-}
nat141 :
    Nat (N Nat141 (IsBoth a To (Nat141Plus a) And b To (Nat141Plus b)))
nat141 =
    nat140 |> add1


{-| The `Nat` 142.


-}
nat142 :
    Nat (N Nat142 (IsBoth a To (Nat142Plus a) And b To (Nat142Plus b)))
nat142 =
    nat141 |> add1


{-| The `Nat` 143.


-}
nat143 :
    Nat (N Nat143 (IsBoth a To (Nat143Plus a) And b To (Nat143Plus b)))
nat143 =
    nat142 |> add1


{-| The `Nat` 144.


-}
nat144 :
    Nat (N Nat144 (IsBoth a To (Nat144Plus a) And b To (Nat144Plus b)))
nat144 =
    nat143 |> add1


{-| The `Nat` 145.


-}
nat145 :
    Nat (N Nat145 (IsBoth a To (Nat145Plus a) And b To (Nat145Plus b)))
nat145 =
    nat144 |> add1


{-| The `Nat` 146.


-}
nat146 :
    Nat (N Nat146 (IsBoth a To (Nat146Plus a) And b To (Nat146Plus b)))
nat146 =
    nat145 |> add1


{-| The `Nat` 147.


-}
nat147 :
    Nat (N Nat147 (IsBoth a To (Nat147Plus a) And b To (Nat147Plus b)))
nat147 =
    nat146 |> add1


{-| The `Nat` 148.


-}
nat148 :
    Nat (N Nat148 (IsBoth a To (Nat148Plus a) And b To (Nat148Plus b)))
nat148 =
    nat147 |> add1


{-| The `Nat` 149.


-}
nat149 :
    Nat (N Nat149 (IsBoth a To (Nat149Plus a) And b To (Nat149Plus b)))
nat149 =
    nat148 |> add1


{-| The `Nat` 150.


-}
nat150 :
    Nat (N Nat150 (IsBoth a To (Nat150Plus a) And b To (Nat150Plus b)))
nat150 =
    nat149 |> add1


{-| The `Nat` 151.


-}
nat151 :
    Nat (N Nat151 (IsBoth a To (Nat151Plus a) And b To (Nat151Plus b)))
nat151 =
    nat150 |> add1


{-| The `Nat` 152.


-}
nat152 :
    Nat (N Nat152 (IsBoth a To (Nat152Plus a) And b To (Nat152Plus b)))
nat152 =
    nat151 |> add1


{-| The `Nat` 153.


-}
nat153 :
    Nat (N Nat153 (IsBoth a To (Nat153Plus a) And b To (Nat153Plus b)))
nat153 =
    nat152 |> add1


{-| The `Nat` 154.


-}
nat154 :
    Nat (N Nat154 (IsBoth a To (Nat154Plus a) And b To (Nat154Plus b)))
nat154 =
    nat153 |> add1


{-| The `Nat` 155.


-}
nat155 :
    Nat (N Nat155 (IsBoth a To (Nat155Plus a) And b To (Nat155Plus b)))
nat155 =
    nat154 |> add1


{-| The `Nat` 156.


-}
nat156 :
    Nat (N Nat156 (IsBoth a To (Nat156Plus a) And b To (Nat156Plus b)))
nat156 =
    nat155 |> add1


{-| The `Nat` 157.


-}
nat157 :
    Nat (N Nat157 (IsBoth a To (Nat157Plus a) And b To (Nat157Plus b)))
nat157 =
    nat156 |> add1


{-| The `Nat` 158.


-}
nat158 :
    Nat (N Nat158 (IsBoth a To (Nat158Plus a) And b To (Nat158Plus b)))
nat158 =
    nat157 |> add1


{-| The `Nat` 159.


-}
nat159 :
    Nat (N Nat159 (IsBoth a To (Nat159Plus a) And b To (Nat159Plus b)))
nat159 =
    nat158 |> add1


{-| The `Nat` 160.


-}
nat160 :
    Nat (N Nat160 (IsBoth a To (Nat160Plus a) And b To (Nat160Plus b)))
nat160 =
    nat159 |> add1


{-| The `Nat` 161.


-}
nat161 :
    Nat (N Nat161 (IsBoth a To (Nat161Plus a) And b To (Nat161Plus b)))
nat161 =
    nat160 |> add1


{-| The `Nat` 162.


-}
nat162 :
    Nat (N Nat162 (IsBoth a To (Nat162Plus a) And b To (Nat162Plus b)))
nat162 =
    nat161 |> add1


{-| The `Nat` 163.


-}
nat163 :
    Nat (N Nat163 (IsBoth a To (Nat163Plus a) And b To (Nat163Plus b)))
nat163 =
    nat162 |> add1


{-| The `Nat` 164.


-}
nat164 :
    Nat (N Nat164 (IsBoth a To (Nat164Plus a) And b To (Nat164Plus b)))
nat164 =
    nat163 |> add1


{-| The `Nat` 165.


-}
nat165 :
    Nat (N Nat165 (IsBoth a To (Nat165Plus a) And b To (Nat165Plus b)))
nat165 =
    nat164 |> add1


{-| The `Nat` 166.


-}
nat166 :
    Nat (N Nat166 (IsBoth a To (Nat166Plus a) And b To (Nat166Plus b)))
nat166 =
    nat165 |> add1


{-| The `Nat` 167.


-}
nat167 :
    Nat (N Nat167 (IsBoth a To (Nat167Plus a) And b To (Nat167Plus b)))
nat167 =
    nat166 |> add1


{-| The `Nat` 168.


-}
nat168 :
    Nat (N Nat168 (IsBoth a To (Nat168Plus a) And b To (Nat168Plus b)))
nat168 =
    nat167 |> add1


{-| The `Nat` 169.


-}
nat169 :
    Nat (N Nat169 (IsBoth a To (Nat169Plus a) And b To (Nat169Plus b)))
nat169 =
    nat168 |> add1


{-| The `Nat` 170.


-}
nat170 :
    Nat (N Nat170 (IsBoth a To (Nat170Plus a) And b To (Nat170Plus b)))
nat170 =
    nat169 |> add1


{-| The `Nat` 171.


-}
nat171 :
    Nat (N Nat171 (IsBoth a To (Nat171Plus a) And b To (Nat171Plus b)))
nat171 =
    nat170 |> add1


{-| The `Nat` 172.


-}
nat172 :
    Nat (N Nat172 (IsBoth a To (Nat172Plus a) And b To (Nat172Plus b)))
nat172 =
    nat171 |> add1


{-| The `Nat` 173.


-}
nat173 :
    Nat (N Nat173 (IsBoth a To (Nat173Plus a) And b To (Nat173Plus b)))
nat173 =
    nat172 |> add1


{-| The `Nat` 174.


-}
nat174 :
    Nat (N Nat174 (IsBoth a To (Nat174Plus a) And b To (Nat174Plus b)))
nat174 =
    nat173 |> add1


{-| The `Nat` 175.


-}
nat175 :
    Nat (N Nat175 (IsBoth a To (Nat175Plus a) And b To (Nat175Plus b)))
nat175 =
    nat174 |> add1


{-| The `Nat` 176.


-}
nat176 :
    Nat (N Nat176 (IsBoth a To (Nat176Plus a) And b To (Nat176Plus b)))
nat176 =
    nat175 |> add1


{-| The `Nat` 177.


-}
nat177 :
    Nat (N Nat177 (IsBoth a To (Nat177Plus a) And b To (Nat177Plus b)))
nat177 =
    nat176 |> add1


{-| The `Nat` 178.


-}
nat178 :
    Nat (N Nat178 (IsBoth a To (Nat178Plus a) And b To (Nat178Plus b)))
nat178 =
    nat177 |> add1


{-| The `Nat` 179.


-}
nat179 :
    Nat (N Nat179 (IsBoth a To (Nat179Plus a) And b To (Nat179Plus b)))
nat179 =
    nat178 |> add1


{-| The `Nat` 180.


-}
nat180 :
    Nat (N Nat180 (IsBoth a To (Nat180Plus a) And b To (Nat180Plus b)))
nat180 =
    nat179 |> add1


{-| The `Nat` 181.


-}
nat181 :
    Nat (N Nat181 (IsBoth a To (Nat181Plus a) And b To (Nat181Plus b)))
nat181 =
    nat180 |> add1


{-| The `Nat` 182.


-}
nat182 :
    Nat (N Nat182 (IsBoth a To (Nat182Plus a) And b To (Nat182Plus b)))
nat182 =
    nat181 |> add1


{-| The `Nat` 183.


-}
nat183 :
    Nat (N Nat183 (IsBoth a To (Nat183Plus a) And b To (Nat183Plus b)))
nat183 =
    nat182 |> add1


{-| The `Nat` 184.


-}
nat184 :
    Nat (N Nat184 (IsBoth a To (Nat184Plus a) And b To (Nat184Plus b)))
nat184 =
    nat183 |> add1


{-| The `Nat` 185.


-}
nat185 :
    Nat (N Nat185 (IsBoth a To (Nat185Plus a) And b To (Nat185Plus b)))
nat185 =
    nat184 |> add1


{-| The `Nat` 186.


-}
nat186 :
    Nat (N Nat186 (IsBoth a To (Nat186Plus a) And b To (Nat186Plus b)))
nat186 =
    nat185 |> add1


{-| The `Nat` 187.


-}
nat187 :
    Nat (N Nat187 (IsBoth a To (Nat187Plus a) And b To (Nat187Plus b)))
nat187 =
    nat186 |> add1


{-| The `Nat` 188.


-}
nat188 :
    Nat (N Nat188 (IsBoth a To (Nat188Plus a) And b To (Nat188Plus b)))
nat188 =
    nat187 |> add1


{-| The `Nat` 189.


-}
nat189 :
    Nat (N Nat189 (IsBoth a To (Nat189Plus a) And b To (Nat189Plus b)))
nat189 =
    nat188 |> add1


{-| The `Nat` 190.


-}
nat190 :
    Nat (N Nat190 (IsBoth a To (Nat190Plus a) And b To (Nat190Plus b)))
nat190 =
    nat189 |> add1


{-| The `Nat` 191.


-}
nat191 :
    Nat (N Nat191 (IsBoth a To (Nat191Plus a) And b To (Nat191Plus b)))
nat191 =
    nat190 |> add1


{-| The `Nat` 192.


-}
nat192 :
    Nat (N Nat192 (IsBoth a To (Nat192Plus a) And b To (Nat192Plus b)))
nat192 =
    nat191 |> add1
