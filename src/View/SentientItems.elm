module View.SentientItems exposing (..)

import Html exposing (..)
import Model exposing (..)
import Model.Shared exposing (..)

view : Model -> Html Msg
view model = div [] [ text "Sentient Items" ]