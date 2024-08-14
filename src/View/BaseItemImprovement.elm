module View.BaseItemImprovement exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.Shared exposing (..)
import Model.BaseItemImprovement exposing (..)
import Monocle.Lens exposing (..)
import Round
import StrConv exposing (..)
import Utils exposing (..)
import View.Utils exposing (..)

view : Model -> Html Msg
view model = 
  div []
    [ craftingSection model
    , hr [] []
    , div [ class "section-header" ] [ text "Calculating Value" ]
    , valueSection model
    , div [ class "section-header" ] [ text "Calculating Time" ]
    , timeSection model
    ]

infoTable : String -> (ItemStatus -> Int) -> Html Msg
infoTable caption f =
  div []
  [ div [ class "col-header" ] [ text caption ]
  , table []
    ( tr [] [ th [] [ text "Category" ], th [] [text "Crafting Threshold" ] ]
    :: List.map (\x -> row (itemStatus.toStr x) (f x)) itemStatus.all
    )
  ]

row : String -> Int -> Html Msg
row c1 c2 = tr [ class "shaded" ] [ td [] [ text c1 ], td [ style "text-align" "center" ] [ text (String.fromInt c2) ] ]

craftingSection : Model -> Html Msg
craftingSection model =
  let
    lic = compose baseItemImprovementL itemCategoryL
    lcv = compose baseItemImprovementL currentValueL
    scv = toStrLens intStrConv lcv
    lcs = compose baseItemImprovementL currentStatusL
  in 
    table [] 
    [ tr [] 
      [ td [] [ span [ class "label" ] [ text "Base Item Category (choose one):" ] ]
      , td [] [ mkSelect model itemCategory lic ]
      ]
    , tr []
      [ td [] [ span [ class "label" ] [ text "Current Item Value (gp):" ] ]
      , td [] [ input [ type_ "text", placeholder "Current Item Value", value (scv.get model), onInput (UpdateStr scv) ] [] ]
      ]
    , tr [] 
      [ td [] [ span [ class "label" ] [ text "Current Item Status (choose one):" ] ]
      , td [] [ mkSelect model itemStatus lcs ]
      ]
    , tr []
      [ td [] [ span [ class "label" ] [ text "Crafting Threshold:" ] ]
      , td [] [ span [ class "label" ] [ text (String.fromInt (craftingThreshold (lic.get model) (lcs.get model) )) ] ] 
      ]
    ]

valueSection : Model -> Html Msg
valueSection model =
  let
    lcv = compose baseItemImprovementL craftingRollL
    scv = toStrLens intStrConv lcv
  in
    table []
    [ tr []
      [ td [] 
        [ span [ class "label" ] [ text "Crafting Roll"] 
        , br [] []
        , span [ class "info" ] [ text "(Roll a d20, adding all relevant modifiers and bonuses)" ]
        ]
      , td [] [ input [ type_ "text", placeholder "Crafting Roll", value (scv.get model), onInput (UpdateStr scv) ] [] ]
      ]
    , tr []
      [ td [] 
        [ span [ class "label" ] [ text "Crafting Result"] 
        , br [] []
        , span [ class "info" ] [ text "(Divide the Crafting Roll by Crafting Threshold, rounding down. Maximum answer of 5.)" ]
        ]
      , td [] [ span [ class "label" ] [ text (String.fromInt (craftingResult model.baseItemImprovement)) ] ]
      ]
    , tr []
      [ td [] 
        [ span [ class "label" ] [ text "New Item Value (gp)"] 
        , br [] []
        , span [ class "info" ] [ text "(Multiply the Current Item Value by the Crafting Result.)" ]
        ]
      , td [] [ span [ class "label" ] [ text (String.fromInt (newItemValue model.baseItemImprovement)) ] ]
      ]
    ]


timeSection : Model -> Html Msg
timeSection model =
  let
    sct = toStrLens floatStrConv (compose baseItemImprovementL standardCraftingTimeL)
  in
    table [] 
    [ tr []
      [ td [] 
        [ span [ class "label" ] [ text "Standard Crafting Time (hours):"] 
        , br [] []
        , span [ class "info" ] [ text "(This is the minimum time it takes to make a crafting check. Determined by your DM.)" ]
        ]
      , td [] [ input [ type_ "text", placeholder "Standard Crafting Time", value (sct.get model), onInput (UpdateStr sct) ] [] ]
      ]
    , tr []
      [ td [] 
        [ span [ class "label" ] [ text "Time to Completion (hours):"] 
        , br [] []
        , span [ class "info" ] [ text "(Multiply Standard Crafting Time by Crafting Result.)" ]
        ]
      , td [] [ span [ class "label" ] [ text (Round.round 2 (timeToCompletion model.baseItemImprovement)) ] ]
      ]
    ]
