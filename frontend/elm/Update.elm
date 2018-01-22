module Update exposing (..)

import Http
import Model exposing (Model, Scores)


type Msg
    = NoOp Int
    | KeyDownName Int
    | UpdateNameInput String
    | UpdateScoreInput String
    | ReceivedScores (Result Http.Error Scores)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp _ ->
            ( model, Cmd.none )

        KeyDownName key ->
            if key == 13 then
                ( updateScores model, Cmd.none )
            else
                ( model, Cmd.none )

        UpdateNameInput newName ->
            let
                newModel =
                    { model | name = newName }
            in
            ( newModel, Cmd.none )

        UpdateScoreInput newScore ->
            let
                newModel =
                    { model | score = newScore }
            in
            ( newModel, Cmd.none )

        ReceivedScores scores ->
            ( model, Cmd.none )


updateScores : Model -> Model
updateScores model =
    let
        score =
            Result.withDefault 0 (String.toFloat model.score)

        scoreItem =
            { name = model.name, score = score }

        newScores =
            List.sortBy .score <| scoreItem :: model.scores
    in
    { model | scores = newScores }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
