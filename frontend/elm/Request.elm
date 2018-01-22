module Request exposing (..)

import Http
import Update exposing (Msg(..))


getResults : Cmd Msg
getResults =
    let
        url =
            "localhost:8000/results"
    in
    Cmd.none



--Http.get
