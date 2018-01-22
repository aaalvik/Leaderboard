module Update exposing (..)

import Model exposing (Model)


type Msg
    = NoOp Int
    | KeyDownName Int
    | UpdateNameInput String
    | UpdateScoreInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp _ ->
            ( model, Cmd.none )

        KeyDownName key ->
            if key == 13 then
                ( updateResults model, Cmd.none )
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
