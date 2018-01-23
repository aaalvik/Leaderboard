module Model exposing (..)


type alias ScoreId =
    String


type alias ScoreItem =
    { name : String
    , score : Float
    }


type alias Scores =
    List ScoreItem


type alias Model =
    { scores : Scores
    , name : String
    , score : String
    }
