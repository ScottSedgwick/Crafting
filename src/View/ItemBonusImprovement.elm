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
  div [ class "flex-container" ]
  [ leftPane model
  , rightPane model
  ]

-------------------------------------------------------------------------------
-- leftPane
-------------------------------------------------------------------------------
leftPane : Model -> Html Msg
leftPane model =
  let
    sirL = compose modelitemBonusImprovementL itemBonusImprovementcurrentRarityL
    crfL = compose modelitemBonusImprovementL itemBonusImprovementcrafterTypeL
    finalR = finalRarity (sirL.get model)
    baseEC = baseEnchantmentCost finalR
    baseET = baseEnchantmentTimeWeeks finalR
    cip = crafterImprovementPercentage (crfL.get model)
    tic = totalImprovementCost (modelitemBonusImprovementL.get model)
    titw = totalImprovementTimeWeeks (modelitemBonusImprovementL.get model)
    tith = totalImprovementTimeHours (modelitemBonusImprovementL.get model)
  in
    div []
      [ div [ class "section-header" ] [ text "Item Bonus Improvement" ] 
      , table []
        [ tr []
          [ td [ class "label" ] [ text "Current Item Rarity (choose one):" ]
          , td [] [ mkSelect model startingItemRarity sirL ]
          ]
        , tr []
          [ td [ class "label" ] [ text "Completed Item Rarity:" ]
          , td [ class "label" ] [ text (itemRarity.toStr finalR)]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text "(This is the rarity of the item once it is improved)"]]

        , tr []
          [ td [ class "label" ] [ text "Base Enchantment Cost (gp):" ] 
          , td [ class "label" ] [ text (String.fromInt baseEC) ]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text "(For the completed item rarity)"]]

        , tr []
          [ td [ class "label" ] [ text "Base Enchantment Time (weeks):" ] 
          , td [ class "label" ] [ text (String.fromInt baseET) ]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text "(For the completed item rarity)"]]

        , tr []
          [ td [ class "label" ] [ text "Crafter Type (choose one):" ]
          , td [] [ mkSelect model crafterType crfL ]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text ("Crafter Improvement Percentage: " ++ Round.round 2 cip)]]

        , tr []
          [ td [ class "label" ] [ text "Total Improvement Cost (gp):" ] 
          , td [ class "label" ] [ text (Round.round 2 tic) ]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text "(Reduce the Base Enchantment Cost by the Crafter Improvement Percentage.)"]]

        , tr []
          [ td [ class "label" ] [ text "Total Improvement Time (weeks):" ] 
          , td [ class "label" ] [ text (Round.round 2 titw) ]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text "(Reduce the Base Enchantment Cost by the Crafter Improvement Percentage.)"]]

        , tr []
          [ td [ class "label" ] [ text "Total Improvement Time (hours):" ] 
          , td [ class "label" ] [ text (Round.round 2 tith) ]
          ]
        , tr [] [ td [colspan 2, class "info"] [ text "(Multiply Total Improvement Time (§) by the hours of a standard workweek, which is often 56.)"]]
        ]
      ]

-------------------------------------------------------------------------------
-- rightPane
-------------------------------------------------------------------------------

rightPane : Model -> Html Msg
rightPane model =
  div []
  [ div [ class "section-header" ] [ text "Calculating Time" ] ]