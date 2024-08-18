module View.Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Monocle.Lens exposing (..)
import Round

import Model exposing (..)
import Model.Shared exposing (..)
import Model.WorkingConditions exposing (..)
import StrConv exposing (..)
import Utils exposing (..)

rowInput : String -> String -> (Lens Model String) -> Model -> Html Msg
rowInput rowId rowLabel lens model =
  div [ class "input-row" ]
  [ label [ for rowId ] [ text rowLabel ]
  , input [ id rowId, type_ "text", placeholder rowLabel, value (lens.get model), onInput (UpdateStr lens) ] []
  ]

rowSelect : Model -> String -> String -> StrConv a -> Lens Model a -> Html Msg
rowSelect model ident caption strConv lens =
  div [ class "input-row borderless" ] 
  [ label [ for ident ] [ text caption ]
  , mkSelect model strConv lens
  ]

mkSelect : Model -> StrConv a -> Lens Model a -> Html Msg
mkSelect model strConv selLens =
  let
    ls = toStrLens strConv selLens
    mkOpt a = option [ value (strConv.toStr a), selected (selLens.get model == a) ] [ text (strConv.toStr a) ]
  in 
    select [ onInput (UpdateStr ls), value (ls.get model) ] (List.map mkOpt strConv.all)

rowCheckSelect : Model -> String -> String -> Lens Model Bool -> StrConv a -> Lens Model a -> Html Msg
rowCheckSelect model ident caption chkLens strConv selLens =
  div [ class "input-row borderless" ] 
  [ div [] [input [ class "checkbox", type_ "checkbox", onCheck (UpdateBool chkLens), checked (chkLens.get model) ] [ text caption ]
  , label [ for ident ] [ text caption ] ]
  , mkSelect model strConv selLens
  ]

checkbox : String -> String -> Model -> Lens Model Bool -> Html Msg
checkbox ident caption model lens =
  div []
  [ label [ for ident, class "checkbox" ] [ text caption ]
  , input [ id ident, class "checkbox", type_ "checkbox", onCheck (UpdateBool lens), checked (lens.get model) ] []
  ]

check : Model -> Lens Model Bool -> Html Msg
check model lens = input [ class "checkbox", type_ "checkbox", onCheck (UpdateBool lens), checked (lens.get model) ] []

mkInput : Model -> StrConv b -> Lens Model b -> Html Msg
mkInput model strConv lens = 
  let
    slens = toStrLens strConv lens
  in
    input [ type_ "text", placeholder "Current Item Value", value (slens.get model), onInput (UpdateStr slens) ] []

sectionHeader : String -> String -> Html Msg
sectionHeader title subscript =
  div [] 
  [ span [ class "section-header" ] [ text (title ++ " ") ]
  , span [ class "section-subscript" ] [ text subscript ]
  ]

assistantCostTable : Float -> Model -> Html Msg
assistantCostTable timeWeeks model =
  table [ class "cost-table" ]
  [ tr [] 
    [ th [ class "cost-table" ] [ text "Assistant #" ]
    , th [ class "cost-table" ] [ text "Cost (gp per week)" ]
    , th [ class "cost-table" ] [ text "Total Cost (gp)" ]
    ]
  , assistantCost timeWeeks model "1" assistant1L
  , assistantCost timeWeeks model "2" assistant2L
  , assistantCost timeWeeks model "3" assistant3L
  , assistantCost timeWeeks model "4" assistant4L
  , assistantCost timeWeeks model "5" assistant5L
  ]

assistantCost : Float -> Model -> String -> Lens WorkingConditions AssistantType -> Html Msg
assistantCost timeWeeks model num lens =
  let
    asstType = (compose workingConditionsL lens).get model
    c = assistantInput asstType
    tc = assistantTotalCost timeWeeks asstType
  in
    tr [] 
    [ td [ class "cost-table" ] [ text num ]
    , td [ class "cost-table" ] [ text (String.fromInt c) ]
    , td [ class "cost-table" ] [ text (Round.round 2 tc) ]
    ]