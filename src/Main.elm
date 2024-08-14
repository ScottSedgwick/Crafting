module Main exposing (..)

import Browser
import Html exposing (..)
import Model exposing (..)
import Model.BaseItemConstruction exposing (..)
import Model.Shared exposing (..)
import View exposing (..)
import Monocle.Lens exposing (..)
import Utils exposing (..)

init : flags -> (Model, Cmd Msg)
init _ = ( initModel, Cmd.none )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeTab t         -> ( currentTabL.set t model, Cmd.none )
    UpdateStr lens v    -> ( lens.set v model      , Cmd.none )
    UpdateBool lens v   -> ( lens.set v model      , Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

main : Program () Model Msg
main = Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }