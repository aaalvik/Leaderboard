module Main exposing (..)

-- component import example

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Result =
    { name : String
    , score : Float
    }


type alias Model =
    { results : List Result
    , name : String
    , score : String
    }


model : Model
model =
    { results = []
    , name = ""
    , score = ""
    }



-- UPDATE


type Msg
    = NoOp Int
    | KeyDownName Int
    | UpdateNameInput String
    | UpdateScoreInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp _ ->
            model

        KeyDownName key ->
            if key == 13 then
                updateResults model
            else
                model

        UpdateNameInput newName ->
            { model | name = newName }

        UpdateScoreInput newScore ->
            { model | score = newScore }


updateResults : Model -> Model
updateResults model =
    let
        score =
            Result.withDefault 0 (String.toFloat model.score)

        result =
            { name = model.name, score = score }

        newResults =
            List.sortBy .score <| result :: model.results
    in
    { model | results = newResults }



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Model -> Html Msg
view model =
    div [ class "container", style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ] ]
        [ -- inline CSS (literal)
          div [ class "page" ]
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



-- CSS STYLES


styles : { img : List ( String, String ) }
styles =
    { img =
        [ ( "width", "33%" )
        , ( "border", "4px solid #337AB7" )
        ]
    }
