module View.ItemEnchantment exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.ItemEnchantment exposing (..)
import Model.Shared exposing (..)
import Monocle.Lens exposing (..)
import Round
import Utils exposing (..)
import View.Utils exposing (..)

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
    irl = compose itemEnchantmentL itemRarityL
    ct  = compose itemEnchantmentL crafterTypeL
    mas = compose itemEnchantmentL mimicASpellL
    nos = compose itemEnchantmentL numberOfDifferentSpellsL
    rmi = compose itemEnchantmentL replicateMagicItemL
  in
    div []
      [ div [ class "section-header" ] [ text "Item Enchantment" ]
      , table [] 
        [ tr [] 
          [ td [] [ span [ class "label" ] [ text "Item Rarity (choose one):" ] ]
          , td [] [ mkSelect model itemRarity irl ]
          ]
        , tr [] 
          [ td [] [ span [ class "label" ] [ text "Base Enchantment Cost (gp):" ] ]
          , td [] [ span [ class "label" ] [ text (Round.round 2 (baseEnchantmentCost (itemEnchantmentL.get model))) ] ] 
          ]
        , tr [] 
          [ td [] [ span [ class "label" ] [ text "Base Enchantment Time (weeks):" ] ]
          , td [] [ span [ class "label" ] [ text (Round.round 2 (baseEnchantmentTimeWeeks (itemEnchantmentL.get model))) ] ] 
          ]
        , tr [] 
          [ td [] [ span [ class "label" ] [ text "Base Enchantment Time (hours):" ] ]
          , td [] [ span [ class "label" ] [ text (Round.round 2 (baseEnchantmentTimeHours (itemEnchantmentL.get model))) ] ] 
          ]
        , tr [] 
          [ td [] 
            [ span [ class "label" ] [ text "Crafter Type:" ]
            , span [ class "info" ] [ text ("Input: " ++ String.fromInt (crafterInput (ct.get model))) ]
            ]
          , td [] [ mkSelect model crafterType ct ] 
          ]
        , assistant model "1" (compose itemEnchantmentL assistant1L)
        , assistant model "2" (compose itemEnchantmentL assistant2L)
        , assistant model "3" (compose itemEnchantmentL assistant3L)
        , assistant model "4" (compose itemEnchantmentL assistant4L)
        , assistant model "5" (compose itemEnchantmentL assistant5L)
        , tr [] 
          [ td [] [ span [ class "label" ] [ text "Enchanting Assistance Total (gp):" ] ]
          , td [] [ span [ class "label" ] [ text (String.fromInt (assistanceTotal model.itemEnchantment_)) ] ] 
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(Add all Enchanting Assistance Input together)" ] ]

        , tr [] 
          [ td [] [ span [ class "label" ] [ text "Total Crafter Input (gp):" ] ]
          , td [] [ span [ class "label" ] [ text (String.fromInt (totalCrafterInput model.itemEnchantment_)) ] ] 
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(Add Crafter Input to Additional Enchanting Assistance Total)" ] ]
        ]
      
      , hr [] []
      , div [ class "section-header" ] [ text "Questions" ]
      , table [] 
        [ tr [] 
          [ td [ class "label" ] [ text "1. Does the Crafter have the Magic Item Adept ability?" ]
          , td [] [ check model (compose itemEnchantmentL magicItemAdeptL) ]
          ]

        , tr [] 
          [ td [ class "label" ] [ text "2. Does the item being enchanted have a rarity of either Common or Uncommon?" ]
          , td [ class "label" ] [ text (if commonOrUncommon model.itemEnchantment_ then "Yes" else "No") ]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(If the answer is yes to both Questions 1 & 2, divide the Base Enchantment Cost by 2 and the Base Enchantment Time by 4. Use these totals for the rest of the worksheet before applying any other modifiers)" ] ]

        , tr [] 
          [ td [ class "label" ] [ text "3. Is the item being created a scroll, potion or one-use item?" ]
          , td [] [ check model (compose itemEnchantmentL oneUseItemL) ]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(If the answer is yes to both Questions 3, divide the Base Enchantment Cost and Base Enchantment Time by 2)" ] ]

        , tr [] 
          [ td [ class "label" ] [ text "4/5/6. Does the item being enchanted cast or mimic a spell (e.g. magic missile, etc.)? Does the crafter have access to this spell? How many times per workweek is the spell cast?" ]
          , td [] [ mkSelect model mimicASpell mas ]
          ]
        , tr [] 
          [ td [ class "label" ] [ text "7. How many separate spells are being cast in the way described in Question 6?" ]
          , td [] [ mkInput model intStrConv nos ]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "If the answer to either or both Questions 4 and 5 is no, there is no change. If the answer to Questions 4 and 5 are both yes, multiply the answer from Question 6 by the answer to Question 7. Subtract the result from 56. Then, take that number and multiply it by the Base Enchantment Time (§). Use the resulting answer to replace the current Base Enchantment Time (hours) above." ] ]

        , tr [] 
          [ td [ class "label" ] [ text "8. Does the crafter have access to a magic item identical to the item being crafted?" ]
          , td [] [ check model (compose itemEnchantmentL accessToIdenticalItemL) ]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "If the answer is yes to Question 8, reduce the Base Enchantment Cost by 10%." ] ]

        , tr [] 
          [ td [ class "label" ] [ text "9/10. Does the item being created appear on the Replicate Magic Item infusion list?" ]
          , td [] [ mkSelect model replicateMagicItem rmi ]
          ]
        ]
      ]
      

assistant : Model -> String -> Lens Model AssistantType -> Html Msg
assistant model num lens =
  tr [] 
  [ td [] 
    [ span [ class "label" ] [ text ("Assistant " ++ num ++ ": ") ]
    , span [ class "info" ] [ text ("Input (gp): " ++ String.fromInt (assistantInput (lens.get model)) ) ]
    ]
  , td [] [ mkSelect model assistantType lens ] 
  ]

-------------------------------------------------------------------------------
-- rightPane
-------------------------------------------------------------------------------

rightPane : Model -> Html Msg
rightPane model =
  div []
  [ div [ class "section-header" ] [ text "Calculating Time" ]
  , table []
    ( List.concat 
      [ mkComponent model "1" (compose itemEnchantmentL component1L)
      , mkComponent model "2" (compose itemEnchantmentL component2L)
      , mkComponent model "3" (compose itemEnchantmentL component3L)
      , mkComponent model "4" (compose itemEnchantmentL component4L)
      , mkComponent model "5" (compose itemEnchantmentL component5L)
      , [ tr []
          [ td [ class "label" ] [ text ("Magic Component Total (hours):")]
          , td [ class "label" ] [ text (Round.round 2 (magicComponentTotal model.itemEnchantment_))]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(Sum of all Magical Components after multiplying by the component modifier)"]]
        , tr []
          [ td [ class "label" ] [ text ("Total Enchantment Time (weeks):")]
          , td [ class "label" ] [ text (Round.round 2 (totalEnchantmentTimeWeeks model.itemEnchantment_))]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(Divide the Base Enchantment Cost by the Total Crafter Input, and then subtract the Magical Component Total from that result.)"]]
        , tr []
          [ td [ class "label" ] [ text ("Total Enchantment Time (hours):")]
          , td [ class "label" ] [ text (Round.round 2 (totalEnchantmentTimeWeeks model.itemEnchantment_ * 56))]
          ]
        , tr [] [ td [ class "info", colspan 2 ] [ text "(Multiply the Total Enchantment Time (§) by the hours of a standard workweek, which is often 56.)"]]
        ]
      ]
    )
  , hr [] []
  , div [ class "section-header" ] [ text "Calculating Cost" ]
  , div [class "label" ] [ text "Additional Enchanting Assistance:" ] 
  , div [class "info"  ] [ text "(Multiply Weekly Rate by Total Enchantment Time in §.)" ] 
  , table []
    [ tr []
      [ th [] [ text "Assistant" ]
      , th [] [ text "Cost (gp per §)" ]
      , th [] [ text "Total (gp)" ]
      ]
    , mkAssistantCost model "1" (compose itemEnchantmentL assistant1L)
    , mkAssistantCost model "2" (compose itemEnchantmentL assistant2L)
    , mkAssistantCost model "3" (compose itemEnchantmentL assistant3L)
    , mkAssistantCost model "4" (compose itemEnchantmentL assistant4L)
    , mkAssistantCost model "5" (compose itemEnchantmentL assistant5L)
    , tr [] [ td [colspan 2, class "label"] [ text ("Additional Enchanting Assistance Total (gp): " ++ Round.round 2 (assistantCostTotal model.itemEnchantment_)) ]]
    , tr [] 
      [ td [ class "label" ] [ text "Additional Enchantment Cost (gp):"]
      , td [] [ mkInput model intStrConv (compose itemEnchantmentL additionalCostL) ]
      ]
    , tr [] [ td [ colspan 2, class "info" ] [ text "(Determined by the DM.)"]]
    , tr [] 
      [ td [ class "label" ] [ text "Total Enchantment Cost (gp):"]
      , td [ class "label"] [ text (Round.round 2 (totalEnchantmentCost model.itemEnchantment_)) ]
      ]
    , tr [] [ td [ colspan 2, class "info" ] [ text "(Sum of the Base Enchantment Cost, Additional Enchanting Assistance Total, and Additional Enchantment Cost.)"]]
    ]
  ]

-- totalEnchantmentCost
mkComponent : Model -> String -> Lens Model MagicComponent -> List (Html Msg)
mkComponent model num lens = 
  let
    rl = compose lens componentTypeL
    al = compose lens componentAlignmentL
  in
    [ tr []
      [ td [ class "label" ] [ text ("Component " ++ num ++ " rarity:")]
      , td [] [ mkSelect model componentItemRarity rl ]
      ]
    , tr []
      [ td [ class "label" ] [ text ("Component " ++ num ++ " alignment:")]
      , td [] [ mkSelect model componentAlignment al ]
      ]
    , tr [] [ td [ class "info", colspan 2 ] [ text ("Component " ++ num ++ " time reduction: " ++ Round.round 2 (componentHourReduction (lens.get model)) ++ " hours.")] ]
    ]

mkAssistantCost : Model -> String -> Lens Model AssistantType -> Html Msg
mkAssistantCost model num lens =
  let
    cph = assistantInput (lens.get model)
  in
  
  tr [] 
  [ td [ style "width" "33%", align "center" ] [ text num ]
  , td [ style "width" "33%", align "center" ] [ text (String.fromInt cph) ]
  , td [ style "width" "33%", align "center" ] [ text (Round.round 2 (assistantCost (lens.get model) (totalEnchantmentTimeWeeks model.itemEnchantment_))) ]
  ]