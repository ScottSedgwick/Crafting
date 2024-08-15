module View.BaseItemConstruction exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.BaseItemConstruction exposing (..)
import Model.Shared exposing (..)
import Model.WorkingConditions exposing (..)
import Monocle.Lens exposing (..)
import Round
import StrConv exposing (..)
import Utils exposing (..)
import View.Utils exposing (..)

view : Model -> Html Msg
view model =
  div [] 
  [ sectionBaseItemPrice model
  , sectionCost model
  ]

-------------------------------------------------------------------------------
-- sectionBaseItemPrice
-------------------------------------------------------------------------------
sectionBaseItemPrice : Model -> Html Msg
sectionBaseItemPrice model =
  let
    itemPrice = compose baseItemConstructionL baseItemPriceStrL
    header = sectionHeader "Base Item Construction" ""
  in
    div []
    [ hr [] []
    , header
    , table []
      [ tr [] 
        [ td [] [ span [ class "label" ] [ text "Base Item Price (gp):" ]
                , br [] []
                , span [ class "info" ] [ text "(Found in the Player's Handbook or determined by the DM)" ]
                ]
        , td [] [ input [ style "width" "100%", type_ "text", placeholder "Base Item Price", value (itemPrice.get model), onInput (UpdateStr itemPrice) ] [] ]
        ]
      , tr [] 
        [ td [ colspan 2 ] [ span [ class "info" ] [ text ("Base Materials Cost (Base Item Price * 0.15): " ++ String.fromFloat (baseMaterialCost (baseItemConstructionL.get model)) ++ " gp") ] ]
        ]
      ]
    ]

-------------------------------------------------------------------------------
-- sectionCost
-------------------------------------------------------------------------------

sectionCost : Model -> Html Msg
sectionCost model =
  let
    cact = assistanceTotal model.workingConditions
    lacac = compose baseItemConstructionL additionalCraftingAssistanceCostL
    slacac = toStrLens intStrConv lacac
    lmac = compose baseItemConstructionL miscAdditionalCostL
    slmac = toStrLens intStrConv lmac
    totalWW = totalWorkWeeks model
    totalCs = totalCosts model
  in
    div [] 
    [ hr [] []
    , sectionHeader "Calculating Cost:" ""
    , table []
      [ tr []
        [ td [] [ span [ class "label" ] [ text "Crafting Assistance Costs" ]]
        , td [] [ span [ class "info" ] [ text "(Multiply Weekly Rate by total Workweeks):" ] ]
        ]
      ]
    , assistantCostTable (baseMaterialCost (baseItemConstructionL.get model)) model
    , table []
      [ tr []
        [ td [] [ span [ class "label" ] [ text ("Crafting Assistance Cost Total: " ++ String.fromInt cact ++ " gp") ]]
        , td [] [ span [ class "info" ] [ text "(Sum of all Crafting Assistant Costs Totals)" ] ]
        ]
      , tr []
        [ td [] 
          [ span [ class "label" ] [ text "Additional Assistance Cost:" ]
          , br [] []
          , span [ class "info" ] [ text "(Determined by the DM)" ]
          ]
        , td [] [ input [ type_ "text", placeholder "Additional Assistance Cost", value (slacac.get model), onInput (UpdateStr slacac) ] [] ]
        ]
      , tr []
        [ td [] 
          [ span [ class "label" ] [ text "Miscellaneous Additional Cost:" ]
          , br [] []
          , span [ class "info" ] [ text "(Determined by the DM)" ]
          ]
        , td [] [ input [ type_ "text", placeholder "Miscellaneous Additional Cost", value (slmac.get model), onInput (UpdateStr slmac) ] [] ]
        ]
      ]
    , hr [] []
    , table []
      [ tr [] [ td [ colspan 2] [ span [ class "section-header" ] [ text "Totals" ]] ]
      , tr []
          [ td [] [ span [ class "label" ] [ text ("Total Work Time: " ++ Round.round 2 totalWW ++ " weeks") ]]
          , td [] [ span [ class "info" ] [ text "(Divide Total Hours by 56)" ] ]
          ]
      , tr []
          [ td [] [ span [ class "label" ] [ text ("Total Costs: " ++ Round.round 2 totalCs ++ " gp") ]]
          , td [] [ span [ class "info" ] [ text "(Add Base Materials Costs, Crafting Assistance Cost Total, Additional Crafting Assistance Cost, and Miscellaneous Additional Cost.)" ] ]
          ]
      ]
    ]