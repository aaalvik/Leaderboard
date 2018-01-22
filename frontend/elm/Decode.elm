module Decode exposing (..)

import Json.Decode as JsonDecode exposing (Decoder)
import Model


scores : Decoder Model.Scores
scores =
    JsonDecode.list score


score : Decoder Model.ScoreItem
score =
    JsonDecode.map2 Model.ScoreItem
        (JsonDecode.field "name" JsonDecode.string)
        (JsonDecode.field "score" JsonDecode.float)
