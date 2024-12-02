module View.ItemBonusImprovement exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.Shared exposing (..)
import Monocle.Lens exposing (..)
import Round
import Utils exposing (..)
import View.Utils exposing (..)
import Model.ItemBonusImprovement exposing (..)

view : Model -> Html Msg
view model = 
    div []
      [ hr [] []
      , div [ class "section-header" ] [ text "Item Bonus Improvement" ]
      , itemRaritySection model
      
      , hr [] []
      , div [ class "section-header" ] [ text "Calculating Cost:" ]
      , costSection model

      , hr [] []
      , div [ class "section-header" ] [ text "Calculating Time:" ]
      , timeSection model
      ]

itemRaritySection : Model -> Html Msg
itemRaritySection model = 
  let
    crl = compose itemBonusImprovementL currentRarityL
    ur = upgradedRarity (crl.get model)
    crafterPercentage = crafterImprovementPercentage model.workingConditions.crafterType
  in
    table []
    [ tr []
      [ td [ class "label" ] [ text "Current Item Rarity (choose one):" ] 
      , td [] [ mkSelect model startingItemRarity crl ]
      ]
    , tr []
      [ td [ class "label" ] [ text "Completed Item Rarity:" ]
      , td [ class "label" ] [ text (itemRarity.toStr ur)]
      ]
    , tr [] [ td [ colspan 2, class "info"] [ text "(This is the rarity of the item once it is improved)" ] ]
    , tr []
      [ td [ class "label" ] [ text "Crafter Improvement Percentage:"] 
      , td [ class "label" ] [ text (Round.round 2 crafterPercentage)]
      ]
    ]

costSection : Model -> Html Msg
costSection model = 
  let
    ur = upgradedRarity ((compose itemBonusImprovementL currentRarityL).get model)
    baseCost = baseImprovementCostByRarity ur
    totalCost = totalImprovementCost model
  in
    table []
    [ tr []
      [ td [class "label"] [ text "Base Enchantment Cost (gp):" ] 
      , td [class "label"] [ text (String.fromInt baseCost)]
      ]
    , tr [] [ td [ colspan 2, class "info"] [ text "(For the completed item rarity)" ] ]
    , tr []
      [ td [class "label"] [ text "Total Enchantment Cost (gp):" ] 
      , td [class "label"] [ text (Round.round 2 totalCost)]
      ]
    , tr [] [ td [ colspan 2, class "info"] [ text "(Reduce the Base Enchantment Cost by the Crafter Improvement Percentage)" ] ]
    ]

timeSection : Model -> Html Msg
timeSection model = 
  let
    baseTime = baseImprovementTime model
    totalTimeHours = totalImprovementTimeHours model 
    actualWeeks = totalTimeHours / 56
  in
    table []
    [ tr []
      [ td [class "label"] [ text "Base Enchantment Time (§):" ] 
      , td [class "label"] [ text (Round.round 2 baseTime)]
      ]
    , tr [] [ td [ colspan 2, class "info"] [ text "(Total Enchantment Cost / Total Crafter Input)" ] ]
    , tr []
      [ td [class "label"] [ text "Total Improvement Time (hours):" ] 
      , td [class "label"] [ text (Round.round 2 totalTimeHours)]
      ]
    , tr [] [ td [ colspan 2, class "info"] [ text "(Multiply Base Enchantment Time (§) by the hours of a standard workweek)" ] ]
    , tr []
      [ td [class "label"] [ text "Actual Improvement Time (weeks):" ] 
      , td [class "label"] [ text (Round.round 2 actualWeeks)]
      ]
    ]

