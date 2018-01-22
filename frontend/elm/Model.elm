module Model exposing (..)


type alias Result =
    { name : String
    , score : Float
    }


type alias Model =
    { results : List Result
    , name : String
    , score : String
    }


init : ( Model, Cmd msg )
init =
    ( Model [] "" "", Cmd.none )
