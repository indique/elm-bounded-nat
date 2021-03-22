module Nat.Ns exposing
    ( nat0, nat1, nat10, nat100, nat101, nat102, nat103, nat104, nat105, nat106, nat107
    , nat108, nat109, nat11, nat110, nat111, nat112, nat113, nat114, nat115, nat116
    , nat117, nat118, nat119, nat12, nat120, nat121, nat122, nat123, nat124, nat125
    , nat126, nat127, nat128, nat129, nat13, nat130, nat131, nat132, nat133, nat134
    , nat135, nat136, nat137, nat138, nat139, nat14, nat140, nat141, nat142, nat143
    , nat144, nat145, nat146, nat147, nat148, nat149, nat15, nat150, nat151, nat152
    , nat153, nat154, nat155, nat156, nat157, nat158, nat159, nat16, nat160, nat161
    , nat162, nat163, nat164, nat165, nat166, nat167, nat168, nat169, nat17, nat170
    , nat171, nat172, nat173, nat174, nat175, nat176, nat177, nat178, nat179, nat18
    , nat180, nat181, nat182, nat183, nat184, nat185, nat186, nat187, nat188, nat189
    , nat19, nat190, nat191, nat192, nat2, nat20, nat21, nat22, nat23, nat24, nat25, nat26
    , nat27, nat28, nat29, nat3, nat30, nat31, nat32, nat33, nat34, nat35, nat36, nat37, nat38
    , nat39, nat4, nat40, nat41, nat42, nat43, nat44, nat45, nat46, nat47, nat48, nat49, nat5
    , nat50, nat51, nat52, nat53, nat54, nat55, nat56, nat57, nat58, nat59, nat6, nat60, nat61
    , nat62, nat63, nat64, nat65, nat66, nat67, nat68, nat69, nat7, nat70, nat71, nat72, nat73
    , nat74, nat75, nat76, nat77, nat78, nat79, nat8, nat80, nat81, nat82, nat83, nat84, nat85
    , nat86, nat87, nat88, nat89, nat9, nat90, nat91, nat92, nat93, nat94, nat95, nat96, nat97
    , nat98, nat99
    )

{-| `Nat (N Nat0 ...)` to `Nat (N Nat192 ...)`.

See [Nat.Bound.N](Nat-Bound#N) for a detailed explanation.

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
import Nat.Bound exposing (Difference, Is, N, To)
import Nat.N.Type exposing (..)


{-| The `Nat` 0.
-}
nat0 : Nat (N Nat0 Is (Difference a To a))
nat0 =
    Internal.Nat 0


{-| The `Nat` 1.
-}
nat1 : Nat (N Nat1 Is (Difference a To (Nat1Plus a)))
nat1 =
    nat0 |> add1


{-| The `Nat` 2.
-}
nat2 : Nat (N Nat2 Is (Difference a To (Nat2Plus a)))
nat2 =
    nat1 |> add1


{-| The `Nat` 3.
-}
nat3 : Nat (N Nat3 Is (Difference a To (Nat3Plus a)))
nat3 =
    nat2 |> add1


{-| The `Nat` 4.
-}
nat4 : Nat (N Nat4 Is (Difference a To (Nat4Plus a)))
nat4 =
    nat3 |> add1


{-| The `Nat` 5.
-}
nat5 : Nat (N Nat5 Is (Difference a To (Nat5Plus a)))
nat5 =
    nat4 |> add1


{-| The `Nat` 6.
-}
nat6 : Nat (N Nat6 Is (Difference a To (Nat6Plus a)))
nat6 =
    nat5 |> add1


{-| The `Nat` 7.
-}
nat7 : Nat (N Nat7 Is (Difference a To (Nat7Plus a)))
nat7 =
    nat6 |> add1


{-| The `Nat` 8.
-}
nat8 : Nat (N Nat8 Is (Difference a To (Nat8Plus a)))
nat8 =
    nat7 |> add1


{-| The `Nat` 9.
-}
nat9 : Nat (N Nat9 Is (Difference a To (Nat9Plus a)))
nat9 =
    nat8 |> add1


{-| The `Nat` 10.
-}
nat10 : Nat (N Nat10 Is (Difference a To (Nat10Plus a)))
nat10 =
    nat9 |> add1


{-| The `Nat` 11.
-}
nat11 : Nat (N Nat11 Is (Difference a To (Nat11Plus a)))
nat11 =
    nat10 |> add1


{-| The `Nat` 12.
-}
nat12 : Nat (N Nat12 Is (Difference a To (Nat12Plus a)))
nat12 =
    nat11 |> add1


{-| The `Nat` 13.
-}
nat13 : Nat (N Nat13 Is (Difference a To (Nat13Plus a)))
nat13 =
    nat12 |> add1


{-| The `Nat` 14.
-}
nat14 : Nat (N Nat14 Is (Difference a To (Nat14Plus a)))
nat14 =
    nat13 |> add1


{-| The `Nat` 15.
-}
nat15 : Nat (N Nat15 Is (Difference a To (Nat15Plus a)))
nat15 =
    nat14 |> add1


{-| The `Nat` 16.
-}
nat16 : Nat (N Nat16 Is (Difference a To (Nat16Plus a)))
nat16 =
    nat15 |> add1


{-| The `Nat` 17.
-}
nat17 : Nat (N Nat17 Is (Difference a To (Nat17Plus a)))
nat17 =
    nat16 |> add1


{-| The `Nat` 18.
-}
nat18 : Nat (N Nat18 Is (Difference a To (Nat18Plus a)))
nat18 =
    nat17 |> add1


{-| The `Nat` 19.
-}
nat19 : Nat (N Nat19 Is (Difference a To (Nat19Plus a)))
nat19 =
    nat18 |> add1


{-| The `Nat` 20.
-}
nat20 : Nat (N Nat20 Is (Difference a To (Nat20Plus a)))
nat20 =
    nat19 |> add1


{-| The `Nat` 21.
-}
nat21 : Nat (N Nat21 Is (Difference a To (Nat21Plus a)))
nat21 =
    nat20 |> add1


{-| The `Nat` 22.
-}
nat22 : Nat (N Nat22 Is (Difference a To (Nat22Plus a)))
nat22 =
    nat21 |> add1


{-| The `Nat` 23.
-}
nat23 : Nat (N Nat23 Is (Difference a To (Nat23Plus a)))
nat23 =
    nat22 |> add1


{-| The `Nat` 24.
-}
nat24 : Nat (N Nat24 Is (Difference a To (Nat24Plus a)))
nat24 =
    nat23 |> add1


{-| The `Nat` 25.
-}
nat25 : Nat (N Nat25 Is (Difference a To (Nat25Plus a)))
nat25 =
    nat24 |> add1


{-| The `Nat` 26.
-}
nat26 : Nat (N Nat26 Is (Difference a To (Nat26Plus a)))
nat26 =
    nat25 |> add1


{-| The `Nat` 27.
-}
nat27 : Nat (N Nat27 Is (Difference a To (Nat27Plus a)))
nat27 =
    nat26 |> add1


{-| The `Nat` 28.
-}
nat28 : Nat (N Nat28 Is (Difference a To (Nat28Plus a)))
nat28 =
    nat27 |> add1


{-| The `Nat` 29.
-}
nat29 : Nat (N Nat29 Is (Difference a To (Nat29Plus a)))
nat29 =
    nat28 |> add1


{-| The `Nat` 30.
-}
nat30 : Nat (N Nat30 Is (Difference a To (Nat30Plus a)))
nat30 =
    nat29 |> add1


{-| The `Nat` 31.
-}
nat31 : Nat (N Nat31 Is (Difference a To (Nat31Plus a)))
nat31 =
    nat30 |> add1


{-| The `Nat` 32.
-}
nat32 : Nat (N Nat32 Is (Difference a To (Nat32Plus a)))
nat32 =
    nat31 |> add1


{-| The `Nat` 33.
-}
nat33 : Nat (N Nat33 Is (Difference a To (Nat33Plus a)))
nat33 =
    nat32 |> add1


{-| The `Nat` 34.
-}
nat34 : Nat (N Nat34 Is (Difference a To (Nat34Plus a)))
nat34 =
    nat33 |> add1


{-| The `Nat` 35.
-}
nat35 : Nat (N Nat35 Is (Difference a To (Nat35Plus a)))
nat35 =
    nat34 |> add1


{-| The `Nat` 36.
-}
nat36 : Nat (N Nat36 Is (Difference a To (Nat36Plus a)))
nat36 =
    nat35 |> add1


{-| The `Nat` 37.
-}
nat37 : Nat (N Nat37 Is (Difference a To (Nat37Plus a)))
nat37 =
    nat36 |> add1


{-| The `Nat` 38.
-}
nat38 : Nat (N Nat38 Is (Difference a To (Nat38Plus a)))
nat38 =
    nat37 |> add1


{-| The `Nat` 39.
-}
nat39 : Nat (N Nat39 Is (Difference a To (Nat39Plus a)))
nat39 =
    nat38 |> add1


{-| The `Nat` 40.
-}
nat40 : Nat (N Nat40 Is (Difference a To (Nat40Plus a)))
nat40 =
    nat39 |> add1


{-| The `Nat` 41.
-}
nat41 : Nat (N Nat41 Is (Difference a To (Nat41Plus a)))
nat41 =
    nat40 |> add1


{-| The `Nat` 42.
-}
nat42 : Nat (N Nat42 Is (Difference a To (Nat42Plus a)))
nat42 =
    nat41 |> add1


{-| The `Nat` 43.
-}
nat43 : Nat (N Nat43 Is (Difference a To (Nat43Plus a)))
nat43 =
    nat42 |> add1


{-| The `Nat` 44.
-}
nat44 : Nat (N Nat44 Is (Difference a To (Nat44Plus a)))
nat44 =
    nat43 |> add1


{-| The `Nat` 45.
-}
nat45 : Nat (N Nat45 Is (Difference a To (Nat45Plus a)))
nat45 =
    nat44 |> add1


{-| The `Nat` 46.
-}
nat46 : Nat (N Nat46 Is (Difference a To (Nat46Plus a)))
nat46 =
    nat45 |> add1


{-| The `Nat` 47.
-}
nat47 : Nat (N Nat47 Is (Difference a To (Nat47Plus a)))
nat47 =
    nat46 |> add1


{-| The `Nat` 48.
-}
nat48 : Nat (N Nat48 Is (Difference a To (Nat48Plus a)))
nat48 =
    nat47 |> add1


{-| The `Nat` 49.
-}
nat49 : Nat (N Nat49 Is (Difference a To (Nat49Plus a)))
nat49 =
    nat48 |> add1


{-| The `Nat` 50.
-}
nat50 : Nat (N Nat50 Is (Difference a To (Nat50Plus a)))
nat50 =
    nat49 |> add1


{-| The `Nat` 51.
-}
nat51 : Nat (N Nat51 Is (Difference a To (Nat51Plus a)))
nat51 =
    nat50 |> add1


{-| The `Nat` 52.
-}
nat52 : Nat (N Nat52 Is (Difference a To (Nat52Plus a)))
nat52 =
    nat51 |> add1


{-| The `Nat` 53.
-}
nat53 : Nat (N Nat53 Is (Difference a To (Nat53Plus a)))
nat53 =
    nat52 |> add1


{-| The `Nat` 54.
-}
nat54 : Nat (N Nat54 Is (Difference a To (Nat54Plus a)))
nat54 =
    nat53 |> add1


{-| The `Nat` 55.
-}
nat55 : Nat (N Nat55 Is (Difference a To (Nat55Plus a)))
nat55 =
    nat54 |> add1


{-| The `Nat` 56.
-}
nat56 : Nat (N Nat56 Is (Difference a To (Nat56Plus a)))
nat56 =
    nat55 |> add1


{-| The `Nat` 57.
-}
nat57 : Nat (N Nat57 Is (Difference a To (Nat57Plus a)))
nat57 =
    nat56 |> add1


{-| The `Nat` 58.
-}
nat58 : Nat (N Nat58 Is (Difference a To (Nat58Plus a)))
nat58 =
    nat57 |> add1


{-| The `Nat` 59.
-}
nat59 : Nat (N Nat59 Is (Difference a To (Nat59Plus a)))
nat59 =
    nat58 |> add1


{-| The `Nat` 60.
-}
nat60 : Nat (N Nat60 Is (Difference a To (Nat60Plus a)))
nat60 =
    nat59 |> add1


{-| The `Nat` 61.
-}
nat61 : Nat (N Nat61 Is (Difference a To (Nat61Plus a)))
nat61 =
    nat60 |> add1


{-| The `Nat` 62.
-}
nat62 : Nat (N Nat62 Is (Difference a To (Nat62Plus a)))
nat62 =
    nat61 |> add1


{-| The `Nat` 63.
-}
nat63 : Nat (N Nat63 Is (Difference a To (Nat63Plus a)))
nat63 =
    nat62 |> add1


{-| The `Nat` 64.
-}
nat64 : Nat (N Nat64 Is (Difference a To (Nat64Plus a)))
nat64 =
    nat63 |> add1


{-| The `Nat` 65.
-}
nat65 : Nat (N Nat65 Is (Difference a To (Nat65Plus a)))
nat65 =
    nat64 |> add1


{-| The `Nat` 66.
-}
nat66 : Nat (N Nat66 Is (Difference a To (Nat66Plus a)))
nat66 =
    nat65 |> add1


{-| The `Nat` 67.
-}
nat67 : Nat (N Nat67 Is (Difference a To (Nat67Plus a)))
nat67 =
    nat66 |> add1


{-| The `Nat` 68.
-}
nat68 : Nat (N Nat68 Is (Difference a To (Nat68Plus a)))
nat68 =
    nat67 |> add1


{-| The `Nat` 69.
-}
nat69 : Nat (N Nat69 Is (Difference a To (Nat69Plus a)))
nat69 =
    nat68 |> add1


{-| The `Nat` 70.
-}
nat70 : Nat (N Nat70 Is (Difference a To (Nat70Plus a)))
nat70 =
    nat69 |> add1


{-| The `Nat` 71.
-}
nat71 : Nat (N Nat71 Is (Difference a To (Nat71Plus a)))
nat71 =
    nat70 |> add1


{-| The `Nat` 72.
-}
nat72 : Nat (N Nat72 Is (Difference a To (Nat72Plus a)))
nat72 =
    nat71 |> add1


{-| The `Nat` 73.
-}
nat73 : Nat (N Nat73 Is (Difference a To (Nat73Plus a)))
nat73 =
    nat72 |> add1


{-| The `Nat` 74.
-}
nat74 : Nat (N Nat74 Is (Difference a To (Nat74Plus a)))
nat74 =
    nat73 |> add1


{-| The `Nat` 75.
-}
nat75 : Nat (N Nat75 Is (Difference a To (Nat75Plus a)))
nat75 =
    nat74 |> add1


{-| The `Nat` 76.
-}
nat76 : Nat (N Nat76 Is (Difference a To (Nat76Plus a)))
nat76 =
    nat75 |> add1


{-| The `Nat` 77.
-}
nat77 : Nat (N Nat77 Is (Difference a To (Nat77Plus a)))
nat77 =
    nat76 |> add1


{-| The `Nat` 78.
-}
nat78 : Nat (N Nat78 Is (Difference a To (Nat78Plus a)))
nat78 =
    nat77 |> add1


{-| The `Nat` 79.
-}
nat79 : Nat (N Nat79 Is (Difference a To (Nat79Plus a)))
nat79 =
    nat78 |> add1


{-| The `Nat` 80.
-}
nat80 : Nat (N Nat80 Is (Difference a To (Nat80Plus a)))
nat80 =
    nat79 |> add1


{-| The `Nat` 81.
-}
nat81 : Nat (N Nat81 Is (Difference a To (Nat81Plus a)))
nat81 =
    nat80 |> add1


{-| The `Nat` 82.
-}
nat82 : Nat (N Nat82 Is (Difference a To (Nat82Plus a)))
nat82 =
    nat81 |> add1


{-| The `Nat` 83.
-}
nat83 : Nat (N Nat83 Is (Difference a To (Nat83Plus a)))
nat83 =
    nat82 |> add1


{-| The `Nat` 84.
-}
nat84 : Nat (N Nat84 Is (Difference a To (Nat84Plus a)))
nat84 =
    nat83 |> add1


{-| The `Nat` 85.
-}
nat85 : Nat (N Nat85 Is (Difference a To (Nat85Plus a)))
nat85 =
    nat84 |> add1


{-| The `Nat` 86.
-}
nat86 : Nat (N Nat86 Is (Difference a To (Nat86Plus a)))
nat86 =
    nat85 |> add1


{-| The `Nat` 87.
-}
nat87 : Nat (N Nat87 Is (Difference a To (Nat87Plus a)))
nat87 =
    nat86 |> add1


{-| The `Nat` 88.
-}
nat88 : Nat (N Nat88 Is (Difference a To (Nat88Plus a)))
nat88 =
    nat87 |> add1


{-| The `Nat` 89.
-}
nat89 : Nat (N Nat89 Is (Difference a To (Nat89Plus a)))
nat89 =
    nat88 |> add1


{-| The `Nat` 90.
-}
nat90 : Nat (N Nat90 Is (Difference a To (Nat90Plus a)))
nat90 =
    nat89 |> add1


{-| The `Nat` 91.
-}
nat91 : Nat (N Nat91 Is (Difference a To (Nat91Plus a)))
nat91 =
    nat90 |> add1


{-| The `Nat` 92.
-}
nat92 : Nat (N Nat92 Is (Difference a To (Nat92Plus a)))
nat92 =
    nat91 |> add1


{-| The `Nat` 93.
-}
nat93 : Nat (N Nat93 Is (Difference a To (Nat93Plus a)))
nat93 =
    nat92 |> add1


{-| The `Nat` 94.
-}
nat94 : Nat (N Nat94 Is (Difference a To (Nat94Plus a)))
nat94 =
    nat93 |> add1


{-| The `Nat` 95.
-}
nat95 : Nat (N Nat95 Is (Difference a To (Nat95Plus a)))
nat95 =
    nat94 |> add1


{-| The `Nat` 96.
-}
nat96 : Nat (N Nat96 Is (Difference a To (Nat96Plus a)))
nat96 =
    nat95 |> add1


{-| The `Nat` 97.
-}
nat97 : Nat (N Nat97 Is (Difference a To (Nat97Plus a)))
nat97 =
    nat96 |> add1


{-| The `Nat` 98.
-}
nat98 : Nat (N Nat98 Is (Difference a To (Nat98Plus a)))
nat98 =
    nat97 |> add1


{-| The `Nat` 99.
-}
nat99 : Nat (N Nat99 Is (Difference a To (Nat99Plus a)))
nat99 =
    nat98 |> add1


{-| The `Nat` 100.
-}
nat100 : Nat (N Nat100 Is (Difference a To (Nat100Plus a)))
nat100 =
    nat99 |> add1


{-| The `Nat` 101.
-}
nat101 : Nat (N Nat101 Is (Difference a To (Nat101Plus a)))
nat101 =
    nat100 |> add1


{-| The `Nat` 102.
-}
nat102 : Nat (N Nat102 Is (Difference a To (Nat102Plus a)))
nat102 =
    nat101 |> add1


{-| The `Nat` 103.
-}
nat103 : Nat (N Nat103 Is (Difference a To (Nat103Plus a)))
nat103 =
    nat102 |> add1


{-| The `Nat` 104.
-}
nat104 : Nat (N Nat104 Is (Difference a To (Nat104Plus a)))
nat104 =
    nat103 |> add1


{-| The `Nat` 105.
-}
nat105 : Nat (N Nat105 Is (Difference a To (Nat105Plus a)))
nat105 =
    nat104 |> add1


{-| The `Nat` 106.
-}
nat106 : Nat (N Nat106 Is (Difference a To (Nat106Plus a)))
nat106 =
    nat105 |> add1


{-| The `Nat` 107.
-}
nat107 : Nat (N Nat107 Is (Difference a To (Nat107Plus a)))
nat107 =
    nat106 |> add1


{-| The `Nat` 108.
-}
nat108 : Nat (N Nat108 Is (Difference a To (Nat108Plus a)))
nat108 =
    nat107 |> add1


{-| The `Nat` 109.
-}
nat109 : Nat (N Nat109 Is (Difference a To (Nat109Plus a)))
nat109 =
    nat108 |> add1


{-| The `Nat` 110.
-}
nat110 : Nat (N Nat110 Is (Difference a To (Nat110Plus a)))
nat110 =
    nat109 |> add1


{-| The `Nat` 111.
-}
nat111 : Nat (N Nat111 Is (Difference a To (Nat111Plus a)))
nat111 =
    nat110 |> add1


{-| The `Nat` 112.
-}
nat112 : Nat (N Nat112 Is (Difference a To (Nat112Plus a)))
nat112 =
    nat111 |> add1


{-| The `Nat` 113.
-}
nat113 : Nat (N Nat113 Is (Difference a To (Nat113Plus a)))
nat113 =
    nat112 |> add1


{-| The `Nat` 114.
-}
nat114 : Nat (N Nat114 Is (Difference a To (Nat114Plus a)))
nat114 =
    nat113 |> add1


{-| The `Nat` 115.
-}
nat115 : Nat (N Nat115 Is (Difference a To (Nat115Plus a)))
nat115 =
    nat114 |> add1


{-| The `Nat` 116.
-}
nat116 : Nat (N Nat116 Is (Difference a To (Nat116Plus a)))
nat116 =
    nat115 |> add1


{-| The `Nat` 117.
-}
nat117 : Nat (N Nat117 Is (Difference a To (Nat117Plus a)))
nat117 =
    nat116 |> add1


{-| The `Nat` 118.
-}
nat118 : Nat (N Nat118 Is (Difference a To (Nat118Plus a)))
nat118 =
    nat117 |> add1


{-| The `Nat` 119.
-}
nat119 : Nat (N Nat119 Is (Difference a To (Nat119Plus a)))
nat119 =
    nat118 |> add1


{-| The `Nat` 120.
-}
nat120 : Nat (N Nat120 Is (Difference a To (Nat120Plus a)))
nat120 =
    nat119 |> add1


{-| The `Nat` 121.
-}
nat121 : Nat (N Nat121 Is (Difference a To (Nat121Plus a)))
nat121 =
    nat120 |> add1


{-| The `Nat` 122.
-}
nat122 : Nat (N Nat122 Is (Difference a To (Nat122Plus a)))
nat122 =
    nat121 |> add1


{-| The `Nat` 123.
-}
nat123 : Nat (N Nat123 Is (Difference a To (Nat123Plus a)))
nat123 =
    nat122 |> add1


{-| The `Nat` 124.
-}
nat124 : Nat (N Nat124 Is (Difference a To (Nat124Plus a)))
nat124 =
    nat123 |> add1


{-| The `Nat` 125.
-}
nat125 : Nat (N Nat125 Is (Difference a To (Nat125Plus a)))
nat125 =
    nat124 |> add1


{-| The `Nat` 126.
-}
nat126 : Nat (N Nat126 Is (Difference a To (Nat126Plus a)))
nat126 =
    nat125 |> add1


{-| The `Nat` 127.
-}
nat127 : Nat (N Nat127 Is (Difference a To (Nat127Plus a)))
nat127 =
    nat126 |> add1


{-| The `Nat` 128.
-}
nat128 : Nat (N Nat128 Is (Difference a To (Nat128Plus a)))
nat128 =
    nat127 |> add1


{-| The `Nat` 129.
-}
nat129 : Nat (N Nat129 Is (Difference a To (Nat129Plus a)))
nat129 =
    nat128 |> add1


{-| The `Nat` 130.
-}
nat130 : Nat (N Nat130 Is (Difference a To (Nat130Plus a)))
nat130 =
    nat129 |> add1


{-| The `Nat` 131.
-}
nat131 : Nat (N Nat131 Is (Difference a To (Nat131Plus a)))
nat131 =
    nat130 |> add1


{-| The `Nat` 132.
-}
nat132 : Nat (N Nat132 Is (Difference a To (Nat132Plus a)))
nat132 =
    nat131 |> add1


{-| The `Nat` 133.
-}
nat133 : Nat (N Nat133 Is (Difference a To (Nat133Plus a)))
nat133 =
    nat132 |> add1


{-| The `Nat` 134.
-}
nat134 : Nat (N Nat134 Is (Difference a To (Nat134Plus a)))
nat134 =
    nat133 |> add1


{-| The `Nat` 135.
-}
nat135 : Nat (N Nat135 Is (Difference a To (Nat135Plus a)))
nat135 =
    nat134 |> add1


{-| The `Nat` 136.
-}
nat136 : Nat (N Nat136 Is (Difference a To (Nat136Plus a)))
nat136 =
    nat135 |> add1


{-| The `Nat` 137.
-}
nat137 : Nat (N Nat137 Is (Difference a To (Nat137Plus a)))
nat137 =
    nat136 |> add1


{-| The `Nat` 138.
-}
nat138 : Nat (N Nat138 Is (Difference a To (Nat138Plus a)))
nat138 =
    nat137 |> add1


{-| The `Nat` 139.
-}
nat139 : Nat (N Nat139 Is (Difference a To (Nat139Plus a)))
nat139 =
    nat138 |> add1


{-| The `Nat` 140.
-}
nat140 : Nat (N Nat140 Is (Difference a To (Nat140Plus a)))
nat140 =
    nat139 |> add1


{-| The `Nat` 141.
-}
nat141 : Nat (N Nat141 Is (Difference a To (Nat141Plus a)))
nat141 =
    nat140 |> add1


{-| The `Nat` 142.
-}
nat142 : Nat (N Nat142 Is (Difference a To (Nat142Plus a)))
nat142 =
    nat141 |> add1


{-| The `Nat` 143.
-}
nat143 : Nat (N Nat143 Is (Difference a To (Nat143Plus a)))
nat143 =
    nat142 |> add1


{-| The `Nat` 144.
-}
nat144 : Nat (N Nat144 Is (Difference a To (Nat144Plus a)))
nat144 =
    nat143 |> add1


{-| The `Nat` 145.
-}
nat145 : Nat (N Nat145 Is (Difference a To (Nat145Plus a)))
nat145 =
    nat144 |> add1


{-| The `Nat` 146.
-}
nat146 : Nat (N Nat146 Is (Difference a To (Nat146Plus a)))
nat146 =
    nat145 |> add1


{-| The `Nat` 147.
-}
nat147 : Nat (N Nat147 Is (Difference a To (Nat147Plus a)))
nat147 =
    nat146 |> add1


{-| The `Nat` 148.
-}
nat148 : Nat (N Nat148 Is (Difference a To (Nat148Plus a)))
nat148 =
    nat147 |> add1


{-| The `Nat` 149.
-}
nat149 : Nat (N Nat149 Is (Difference a To (Nat149Plus a)))
nat149 =
    nat148 |> add1


{-| The `Nat` 150.
-}
nat150 : Nat (N Nat150 Is (Difference a To (Nat150Plus a)))
nat150 =
    nat149 |> add1


{-| The `Nat` 151.
-}
nat151 : Nat (N Nat151 Is (Difference a To (Nat151Plus a)))
nat151 =
    nat150 |> add1


{-| The `Nat` 152.
-}
nat152 : Nat (N Nat152 Is (Difference a To (Nat152Plus a)))
nat152 =
    nat151 |> add1


{-| The `Nat` 153.
-}
nat153 : Nat (N Nat153 Is (Difference a To (Nat153Plus a)))
nat153 =
    nat152 |> add1


{-| The `Nat` 154.
-}
nat154 : Nat (N Nat154 Is (Difference a To (Nat154Plus a)))
nat154 =
    nat153 |> add1


{-| The `Nat` 155.
-}
nat155 : Nat (N Nat155 Is (Difference a To (Nat155Plus a)))
nat155 =
    nat154 |> add1


{-| The `Nat` 156.
-}
nat156 : Nat (N Nat156 Is (Difference a To (Nat156Plus a)))
nat156 =
    nat155 |> add1


{-| The `Nat` 157.
-}
nat157 : Nat (N Nat157 Is (Difference a To (Nat157Plus a)))
nat157 =
    nat156 |> add1


{-| The `Nat` 158.
-}
nat158 : Nat (N Nat158 Is (Difference a To (Nat158Plus a)))
nat158 =
    nat157 |> add1


{-| The `Nat` 159.
-}
nat159 : Nat (N Nat159 Is (Difference a To (Nat159Plus a)))
nat159 =
    nat158 |> add1


{-| The `Nat` 160.
-}
nat160 : Nat (N Nat160 Is (Difference a To (Nat160Plus a)))
nat160 =
    nat159 |> add1


{-| The `Nat` 161.
-}
nat161 : Nat (N Nat161 Is (Difference a To (Nat161Plus a)))
nat161 =
    nat160 |> add1


{-| The `Nat` 162.
-}
nat162 : Nat (N Nat162 Is (Difference a To (Nat162Plus a)))
nat162 =
    nat161 |> add1


{-| The `Nat` 163.
-}
nat163 : Nat (N Nat163 Is (Difference a To (Nat163Plus a)))
nat163 =
    nat162 |> add1


{-| The `Nat` 164.
-}
nat164 : Nat (N Nat164 Is (Difference a To (Nat164Plus a)))
nat164 =
    nat163 |> add1


{-| The `Nat` 165.
-}
nat165 : Nat (N Nat165 Is (Difference a To (Nat165Plus a)))
nat165 =
    nat164 |> add1


{-| The `Nat` 166.
-}
nat166 : Nat (N Nat166 Is (Difference a To (Nat166Plus a)))
nat166 =
    nat165 |> add1


{-| The `Nat` 167.
-}
nat167 : Nat (N Nat167 Is (Difference a To (Nat167Plus a)))
nat167 =
    nat166 |> add1


{-| The `Nat` 168.
-}
nat168 : Nat (N Nat168 Is (Difference a To (Nat168Plus a)))
nat168 =
    nat167 |> add1


{-| The `Nat` 169.
-}
nat169 : Nat (N Nat169 Is (Difference a To (Nat169Plus a)))
nat169 =
    nat168 |> add1


{-| The `Nat` 170.
-}
nat170 : Nat (N Nat170 Is (Difference a To (Nat170Plus a)))
nat170 =
    nat169 |> add1


{-| The `Nat` 171.
-}
nat171 : Nat (N Nat171 Is (Difference a To (Nat171Plus a)))
nat171 =
    nat170 |> add1


{-| The `Nat` 172.
-}
nat172 : Nat (N Nat172 Is (Difference a To (Nat172Plus a)))
nat172 =
    nat171 |> add1


{-| The `Nat` 173.
-}
nat173 : Nat (N Nat173 Is (Difference a To (Nat173Plus a)))
nat173 =
    nat172 |> add1


{-| The `Nat` 174.
-}
nat174 : Nat (N Nat174 Is (Difference a To (Nat174Plus a)))
nat174 =
    nat173 |> add1


{-| The `Nat` 175.
-}
nat175 : Nat (N Nat175 Is (Difference a To (Nat175Plus a)))
nat175 =
    nat174 |> add1


{-| The `Nat` 176.
-}
nat176 : Nat (N Nat176 Is (Difference a To (Nat176Plus a)))
nat176 =
    nat175 |> add1


{-| The `Nat` 177.
-}
nat177 : Nat (N Nat177 Is (Difference a To (Nat177Plus a)))
nat177 =
    nat176 |> add1


{-| The `Nat` 178.
-}
nat178 : Nat (N Nat178 Is (Difference a To (Nat178Plus a)))
nat178 =
    nat177 |> add1


{-| The `Nat` 179.
-}
nat179 : Nat (N Nat179 Is (Difference a To (Nat179Plus a)))
nat179 =
    nat178 |> add1


{-| The `Nat` 180.
-}
nat180 : Nat (N Nat180 Is (Difference a To (Nat180Plus a)))
nat180 =
    nat179 |> add1


{-| The `Nat` 181.
-}
nat181 : Nat (N Nat181 Is (Difference a To (Nat181Plus a)))
nat181 =
    nat180 |> add1


{-| The `Nat` 182.
-}
nat182 : Nat (N Nat182 Is (Difference a To (Nat182Plus a)))
nat182 =
    nat181 |> add1


{-| The `Nat` 183.
-}
nat183 : Nat (N Nat183 Is (Difference a To (Nat183Plus a)))
nat183 =
    nat182 |> add1


{-| The `Nat` 184.
-}
nat184 : Nat (N Nat184 Is (Difference a To (Nat184Plus a)))
nat184 =
    nat183 |> add1


{-| The `Nat` 185.
-}
nat185 : Nat (N Nat185 Is (Difference a To (Nat185Plus a)))
nat185 =
    nat184 |> add1


{-| The `Nat` 186.
-}
nat186 : Nat (N Nat186 Is (Difference a To (Nat186Plus a)))
nat186 =
    nat185 |> add1


{-| The `Nat` 187.
-}
nat187 : Nat (N Nat187 Is (Difference a To (Nat187Plus a)))
nat187 =
    nat186 |> add1


{-| The `Nat` 188.
-}
nat188 : Nat (N Nat188 Is (Difference a To (Nat188Plus a)))
nat188 =
    nat187 |> add1


{-| The `Nat` 189.
-}
nat189 : Nat (N Nat189 Is (Difference a To (Nat189Plus a)))
nat189 =
    nat188 |> add1


{-| The `Nat` 190.
-}
nat190 : Nat (N Nat190 Is (Difference a To (Nat190Plus a)))
nat190 =
    nat189 |> add1


{-| The `Nat` 191.
-}
nat191 : Nat (N Nat191 Is (Difference a To (Nat191Plus a)))
nat191 =
    nat190 |> add1


{-| The `Nat` 192.
-}
nat192 : Nat (N Nat192 Is (Difference a To (Nat192Plus a)))
nat192 =
    nat191 |> add1
