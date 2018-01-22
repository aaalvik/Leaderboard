module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model exposing (Model)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ class "container", style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ] ]
        [ div [ class "page" ]
            [ h1 [ class "header" ] [ text "Topp 5 - LM i ølsykkel" ]
            , showResults 5 model
            , inputFieldName
            , inputFieldScore
            ]
        ]


inputFieldName : Html Msg
inputFieldName =
    input
        [ class "input"
        , placeholder "Navn"
        , onInput UpdateNameInput
        , onKeyDown KeyDownName
        ]
        []


inputFieldScore : Html Msg
inputFieldScore =
    input
        [ class "input"
        , placeholder "Tid i sekunder"
        , onInput UpdateScoreInput
        ]
        []


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)


showResults : Int -> Model -> Html Msg
showResults num model =
    let
        top5 =
            List.take num (List.sortBy .score model.results)

        makeScore name time =
            div [ class "result" ] [ div [ class "result-item" ] [ h1 [] [ text name ] ], div [ class "result-item" ] [ h1 [] [ text <| toString time ] ] ]

        scores =
            List.map (\{ name, score } -> makeScore name score) top5
    in
    div [ class "results" ] scores
