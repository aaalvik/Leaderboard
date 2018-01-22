module Model exposing (..)


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


init : ( Model, Cmd msg )
init =
    ( Model [] "" "", Cmd.none )
