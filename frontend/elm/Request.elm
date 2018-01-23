module Request exposing (..)

import Decode
import Http
import Model exposing (ScoreId, ScoreItem)
import Update exposing (Msg(..))


globalUrl =
    "localhost:8000"


getScores : Cmd Msg
getScores =
    let
        url =
            globalUrl ++ "/scores"

        request =
            Http.get url Decode.scores
    in
    Http.send ReceivedScores request


insertScore : ScoreItem -> Cmd Msg
insertScore scoreItem =
    let
        url =
            globalUrl ++ "/scores"

        {- TODO fix body -}
        body =
            Http.emptyBody

        request =
            Http.post url body Decode.scores
    in
    Http.send ReceivedScores request



-- updateScore : ScoreId  -> ScoreItem -> Cmd Msg
-- updateScore id body =
--     let
--         url =
--             globalUrl ++ "/scores/" ++ id
--         request = Http.put url
--     in
--     Http.send ReceivedScores request
-- put : String -> Body
