module GenerateForElmBoundedNat exposing (main)

{-| Helps you generate the source code of the modules
- [`Nat.N`](Nat-N)
- [`Nat.N.Type`](Nat-N-Type)

Thanks to [`the-sett/elm-syntax-dsl`](https://package.elm-lang.org/packages/the-sett/elm-syntax-dsl/latest/)!
-}

import Browser
import Bytes.Encode
import Element as Ui
import Element.Background as UiBg
import Element.Border as UiBorder
import Element.Font as UiFont
import Element.Input as UiInput
import Elm.CodeGen
    exposing
        ( access
        , and
        , append
        , applyBinOp
        , binOp
        , binOpChain
        , caseExpr
        , char
        , code
        , composel
        , composer
        , cons
        , construct
        , customTypeDecl
        , equals
        , extRecordAnn
        , fqConstruct
        , fqFun
        , fqNamedPattern
        , fqTyped
        , fun
        , funExpose
        , importStmt
        , int
        , intAnn
        , lambda
        , letDestructuring
        , letExpr
        , letFunction
        , letVal
        , list
        , listAnn
        , listPattern
        , markdown
        , maybeAnn
        , minus
        , namedPattern
        , normalModule
        , openTypeExpose
        , parens
        , pipel
        , piper
        , plus
        , record
        , recordAnn
        , recordPattern
        , tuple
        , tupleAnn
        , tuplePattern
        , typeOrAliasExpose
        , typeVar
        , typed
        , unConsPattern
        , unit
        , unitAnn
        , val
        , valDecl
        , varPattern
        )
import Elm.Pretty
import Extra.GenerateElm exposing (..)
import Extra.Ui as Ui
import File.Download
import Html exposing (Html)
import Html.Attributes
import SyntaxHighlight
import Task
import Time
import Zip
import Zip.Entry


main : Program () Model Msg
main =
    Browser.element
        { init = \() -> init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { natNsModuleShownOrFolded :
        ShownOrFolded (Ui.Element Msg)
    , natNTypeModuleShownOrFolded :
        ShownOrFolded (Ui.Element Msg)
    }


type ShownOrFolded content
    = Shown content
    | Folded



--tags

type NatNsTag =
    NatNsValue

type NatNTypeTag
    = NatNTypeExact
    | NatNTypeAtLeast

--


init : ( Model, Cmd Msg )
init =
    ( { natNsModuleShownOrFolded = Folded
      , natNTypeModuleShownOrFolded = Folded
      }
    , Cmd.none
    )


type Msg
    = DownloadModules
    | DownloadModulesAtTime ( Time.Zone, Time.Posix )
    | SwitchVisibleModule ModulesInElmNArrays


type ModulesInElmNArrays
    = NatNs
    | NatNType


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DownloadModules ->
            ( model
            , Task.perform
                (\time -> DownloadModulesAtTime time)
                (Time.here
                    |> Task.andThen
                        (\here ->
                            Time.now
                                |> Task.map (\now -> ( here, now ))
                        )
                )
            )

        DownloadModulesAtTime time ->
            ( model
            , File.Download.bytes
                "elm-nArrays-modules.zip"
                "application/zip"
                (let
                    toZipEntry moduleFile =
                        zipEntryFromModule time moduleFile
                 in
                 Zip.fromEntries
                    [ toZipEntry natNsModule
                    , toZipEntry natNTypeModule
                    ]
                    |> Zip.toBytes
                )
            )

        SwitchVisibleModule moduleKind ->
            ( case moduleKind of
                NatNs ->
                    { model
                        | natNsModuleShownOrFolded =
                            switchShownOrFolded
                                (.natNsModuleShownOrFolded model)
                                viewNatNsModule
                    }
                NatNType ->
                    { model
                        | natNTypeModuleShownOrFolded =
                            switchShownOrFolded
                                (.natNTypeModuleShownOrFolded model)
                                viewNatNTypeModule
                    }
            , Cmd.none
            )


switchShownOrFolded :
    ShownOrFolded content
    -> content
    -> ShownOrFolded content
switchShownOrFolded visibility content =
    case visibility of
        Shown _ ->
            Folded

        Folded ->
            Shown content



--


natNAnn : Elm.CodeGen.TypeAnnotation -> Elm.CodeGen.TypeAnnotation
natNAnn n =
    typed "Nat" [ n ]


nAnn :
    Elm.CodeGen.TypeAnnotation
    -> Elm.CodeGen.TypeAnnotation
    -> Elm.CodeGen.TypeAnnotation
nAnn a difference =
    typed "N"
        [ a
        , typed "Is" []
        , difference
        ]


differenceAnn :
    Elm.CodeGen.TypeAnnotation
    -> Elm.CodeGen.TypeAnnotation
    -> Elm.CodeGen.TypeAnnotation
differenceAnn a nPlusA =
    typed "Difference"
        [ a, typed "To" [], nPlusA ]


natXPlusAnn : Int -> Elm.CodeGen.TypeAnnotation -> Elm.CodeGen.TypeAnnotation
natXPlusAnn x more =
    typed ("Nat" ++ String.fromInt x ++ "Plus") [ more ]


toIntAnn : Elm.CodeGen.TypeAnnotation
toIntAnn =
    funAnn [ natNAnn (typeVar "n") ] intAnn


zeroAnn : Elm.CodeGen.TypeAnnotation
zeroAnn =
    natNAnn
        (nAnn
            (typed "Nat0" [])
            (differenceAnn (typeVar "a") (typeVar "a"))
        )



--


lastN : Int
lastN =
    192

viewNatNsModule : Ui.Element msg
viewNatNsModule =
    Ui.module_ natNsModule


natNsModule : Module NatNsTag
natNsModule =
    { name = [ "Nat", "Ns" ]
    , roleInPackage =
        PackageExposedModule
            { moduleComment =
                \declarations->
                    [ markdown "`Nat (N Nat0 ...)` to `Nat (N Nat192 ...)`."
                    , markdown "See [`Nat.Bound.N`](Nat-Bound#N) & [`Nat.N`](Nat#N) for a detailed explanation."
                    , docTagsFrom NatNsValue declarations
                    ]
            }
    , imports =
        [ importStmt [ "Nat" ] noAlias
            (exposingExplicit [ typeOrAliasExpose "Nat" ])
        , importStmt [ "Nat", "Bound" ] noAlias
            (exposingExplicit
                ([ "Difference", "Is", "N", "To" ]
                    |> List.map typeOrAliasExpose
                )
            )
        , importStmt [ "Nat", "N", "Type" ] noAlias exposingAll
        , importStmt [ "Internal" ] noAlias
            (exposingExplicit [ funExpose "add1", funExpose "sub1" ])
        ]
    , declarations =
        let
            natComment x =
                [ markdown ("The `Nat` " ++ String.fromInt x ++ ".") ]
        in
        [ [ packageExposedFunDecl NatNsValue
                (natComment 0)
                zeroAnn
                "nat0"
                []
                (fqConstruct [ "Internal" ] "Nat" [ int 0 ])
          ]
        , List.range 1 lastN
            |> List.map
                (\x ->
                    packageExposedFunDecl NatNsValue
                        (natComment x)
                        (natNAnn
                            (nAnn
                                (typed ("Nat" ++ String.fromInt x) [])
                                (differenceAnn (typeVar "a")
                                    (natXPlusAnn x (typeVar "a"))
                                )
                            )
                        )
                        ("nat" ++ String.fromInt x)
                        []
                        (applyBinOp
                            (val ("nat" ++ String.fromInt (x - 1)))
                            piper
                            (fun "add1")
                        )
                )
        ]
        |>List.concat
    }


viewNatNTypeModule : Ui.Element msg
viewNatNTypeModule =
    Ui.module_ natNTypeModule


natNTypeModule : Module NatNTypeTag
natNTypeModule =
    { name = [ "N", "Nat", "Type" ]
    , roleInPackage =
        PackageExposedModule
            { moduleComment =
                \declarations ->
                    [ markdown "Express exact numbers in the type."
                    , markdown "- Describe an exact value"
                    , code "    onlyExact1 : Nat (Only Nat1) -> Cake"
                    , markdown "    - `takesOnlyExact1 (nat10 |> Nat.N.toIn)` is a compile-time error"
                    , markdown "- Add a fixed value"
                    , code "    add2 : Nat (Only n) -> Nat (Only (Nat2Plus n))"
                    , markdown "    - `add2 (nat2 |> Nat.In)` is of type `Nat (Only Nat4)`"
                    , markdown "### about a big limitation"
                    , markdown "Sadly, while experimenting with type aliases, I discovered that type aliases can only expand so much."
                    , code "compilingGetsKilled : Nat (N (Nat100Plus Nat93) Is difference)"
                    , markdown "If a type alias is not fully expanded after _192_ tries, there seems to be a hard limit"
                    , markdown "- the compilation stops"
                    , markdown "- the elm-stuff can corrupt"
                    , markdown "This is really a factor holding this package down."
                    , markdown "## at least"
                    , docTagsFrom NatNTypeAtLeast declarations
                    , markdown "## exact"
                    , docTagsFrom NatNTypeExact declarations
                    ]
            }
    , imports =
        [ importStmt [ "N" ]
            noAlias
            (exposingExplicit
                [ typeOrAliasExpose "S"
                , typeOrAliasExpose "Z"
                ]
            )
        ]
    , declarations =
        [ [ packageExposedAliasDecl NatNTypeAtLeast
                [ markdown "1 + some n, which is at least 1."
                ]
                "Nat1Plus"
                [ "more" ]
                (typed "S" [ typeVar "more" ])
          ]
        , List.range 2 192
            |> List.map
                (\n ->
                    packageExposedAliasDecl NatNTypeAtLeast
                        [ markdown (String.fromInt n ++ " + some n, which is at least " ++ String.fromInt n ++ ".")
                        ]
                        ("Nat" ++ String.fromInt n ++ "Plus")
                        [ "more" ]
                        (typed ("Nat" ++ String.fromInt (n - 1) ++ "Plus")
                            [ typed "S" [ typeVar "more" ] ]
                        )
                )
        , [ packageExposedAliasDecl NatNTypeExact
                [ markdown "Exact the natural number 0."
                ]
                "Nat0"
                []
                (typed "Z" [])
          ]
        , List.range 1 192
            |> List.map
                (\n ->
                    packageExposedAliasDecl NatNTypeExact
                        [ markdown ("Exact the natural number " ++ String.fromInt n ++ ".")
                        ]
                        ("Nat" ++ String.fromInt n)
                        []
                        (typed ("Nat" ++ String.fromInt n ++ "Plus")
                            [ typed "Z" [] ]
                        )
                )
        ]
            |> List.concat
    }


--


args : (arg -> String) -> List arg -> String
args argToString =
    List.map argToString >> String.join " "


indexed : ((String -> String) -> a) -> Int -> Int -> List a
indexed use first last =
    List.range first last
        |> List.map
            (\i ->
                use (\base -> base ++ String.fromInt i)
            )


charIndex : Int -> Char
charIndex i =
    i + Char.toCode 'a' |> Char.fromCode


charPrefixed : ((String -> String) -> a) -> Int -> List a
charPrefixed use last =
    List.range 0 last
        |> List.map
            (charIndex >> (\i -> use (String.cons i)))


view : Model -> Html Msg
view { natNsModuleShownOrFolded, natNTypeModuleShownOrFolded } =
    Ui.layoutWith
        { options =
            [ Ui.focusStyle
                { borderColor = Just (Ui.rgba 0 1 1 0.38)
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        []
        (Ui.column
            [ Ui.paddingXY 40 60
            , Ui.spacing 32
            , Ui.width Ui.fill
            , Ui.height Ui.fill
            , UiBg.color (Ui.rgb255 35 36 31)
            , UiFont.color (Ui.rgb 1 1 1)
            ]
            [ Ui.el
                [ UiFont.size 40
                , UiFont.family [ UiFont.typeface "Fira Code" ]
                ]
                (Ui.text "elm-bounded-nat modules")
            , UiInput.button
                [ Ui.padding 16
                , UiBg.color (Ui.rgba 1 0.4 0 0.6)
                ]
                { onPress = Just DownloadModules
                , label = Ui.text "⬇ download elm modules"
                }
            , Ui.column
                [ Ui.width Ui.fill
                ]
                (Ui.el [ Ui.paddingXY 0 6 ]
                    (Ui.text "📂 preview modules")
                    :: (let
                            switchButton text switch =
                                Ui.el
                                    [ Ui.width Ui.fill
                                    , Ui.paddingXY 0 6
                                    , Ui.moveUp 6
                                    ]
                                    (UiInput.button
                                        [ UiBg.color (Ui.rgba 1 0.4 0 0.6)
                                        , Ui.padding 12
                                        , Ui.width Ui.fill
                                        ]
                                        { onPress = Just switch
                                        , label =
                                            Ui.el
                                                [ UiFont.family [ UiFont.typeface "Fira Code" ] ]
                                                (Ui.text text)
                                        }
                                    )

                            viewAccordingToShownOrFolded visibility name switch =
                                case visibility of
                                    Shown ui ->
                                        Ui.row
                                            [ Ui.height Ui.fill, Ui.width Ui.fill ]
                                            [ Ui.el
                                                [ Ui.width (Ui.px 1)
                                                , UiBg.color (Ui.rgba 1 0.4 0 0.6)
                                                , Ui.height Ui.fill
                                                ]
                                                Ui.none
                                            , Ui.column [ Ui.width Ui.fill ]
                                                [ switchButton ("⌃ " ++ name) switch
                                                , Ui.el [ Ui.moveRight 5 ] ui
                                                ]
                                            ]

                                    Folded ->
                                        switchButton ("⌄ " ++ name) switch
                        in
                        [ ( natNsModuleShownOrFolded
                          , ( "Nat.Ns", NatNs )
                          )
                        , ( natNTypeModuleShownOrFolded
                          , ( "Nat.N.Type", NatNType )
                          )
                        ]
                            |> List.map
                                (\( visibility, ( name, moduleKind ) ) ->
                                    viewAccordingToShownOrFolded visibility
                                        name
                                        (SwitchVisibleModule moduleKind)
                                )
                       )
                )
            ]
        )
