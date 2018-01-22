module Main exposing (..)

import Html
import Model
import Update
import View


main =
    Html.program { init = Model.init, view = View.view, update = Update.update, subscriptions = Update.subscriptions }
