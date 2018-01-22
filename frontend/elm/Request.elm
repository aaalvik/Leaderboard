module Request exposing (..)

import Decode
import Http
import Update exposing (Msg(..))


getResults : Cmd Msg
getResults =
    let
        url =
            "localhost:8000/scores"

        request =
            Http.get url Decode.scores

        send =
            Http.send ReceivedScores request
    in
    send



--Http.get
