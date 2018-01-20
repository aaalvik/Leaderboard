module Main exposing (..)

-- component import example

import Components.Hello exposing (hello)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Score =
    { name : String
    , val : Float
    }


type alias Model =
    { scores : List Score
    , name : String
    , score : String
    }


model : Model
model =
    { scores = []
    , name = ""
    , score = ""
    }



-- UPDATE


type Msg
    = NoOp
    | KeyDownName Int
    | UpdateNameInput String
    | UpdateScoreInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        KeyDownName key ->
            if key == 13 then
                updateScores model
            else
                model

        UpdateNameInput newName ->
            { model | name = newName }

        UpdateScoreInput newScore ->
            { model | score = newScore }


updateScores : Model -> Model
updateScores model =
    let
        scoreVal =
            Result.withDefault 0 (String.toFloat model.score)

        score =
            { name = model.name, val = scoreVal }

        newScores =
            List.sortBy .val <| score :: model.scores
    in
    { model | scores = newScores }



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Model -> Html Msg
view model =
    div [ class "container", style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ] ]
        [ -- inline CSS (literal)
          div [ class "page" ]
            [ h1 [ class "header" ] [ text "Topp 5 - LM i ølsykkel" ]
            , showScores model
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
        , onKeyDown KeyDownName
        ]
        []


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)


showScores : Model -> Html Msg
showScores model =
    let
        top5 =
            List.take 5 (List.sortBy .val model.scores)

        makeScore name time =
            div [ class "score" ] [ div [ class "score-item" ] [ h1 [] [ text name ] ], div [ class "score-item" ] [ h1 [] [ text <| toString time ] ] ]

        scores =
            List.map (\{ name, val } -> makeScore name val) top5
    in
    div [ class "scores" ] scores



-- CSS STYLES


styles : { img : List ( String, String ) }
styles =
    { img =
        [ ( "width", "33%" )
        , ( "border", "4px solid #337AB7" )
        ]
    }
