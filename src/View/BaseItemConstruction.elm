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
  -- , sectionCrafterType model
  -- , sectionCraftingAssistance model
  -- , sectionTools model
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
    [ header
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

-- -------------------------------------------------------------------------------
-- -- sectionCrafterType
-- -------------------------------------------------------------------------------
-- sectionCrafterType : Model -> Html Msg
-- sectionCrafterType model =
--   let
--     l = compose modelbaseItemConstructionL baseItemConstructioncrafterTypeL
--     ls = toStrLens crafterType l
--     mkOpt a = option [ value (crafterType.toStr a), selected (l.get model == a) ] [ text (crafterType.toStr a) ]
--   in
--     div []
--     [ hr [] []
--     , table []
--       [ tr [] 
--         [ td [] 
--           [ span [ class "label" ] [ text "Crafter Type:" ]
--           , br [] []
--           , span [ class "info" ] [ text ("Crafter Input: " ++ (String.fromInt (mCrafterInput model)) ++ " gp")  ]
--           ]
--         , td [] [ select [ onInput (UpdateStr ls), value (ls.get model) ] (List.map mkOpt crafterType.all) ]
--         ]
--       , tr [] [ td [ colspan 2 ] [ span [ class "info" ] [ text "(The amount that your character adds to the total)" ] ] ]
--       ]
--     ]

-- -------------------------------------------------------------------------------
-- -- sectionCraftingAssistance
-- -------------------------------------------------------------------------------
-- sectionCraftingAssistance : Model -> Html Msg
-- sectionCraftingAssistance model =
--   div [ class "borderless"]
--   [ hr [] [] 
--   , sectionHeader "Crafting Assistance:" "(Fill in the Crafting Input for each Assistant)"
--   , table [ style "width" "100%" ]
--     [ sectionAssistant model "1" baseItemConstructionassistant1L
--     , sectionAssistant model "2" baseItemConstructionassistant2L
--     , sectionAssistant model "3" baseItemConstructionassistant3L
--     , sectionAssistant model "4" baseItemConstructionassistant4L
--     , sectionAssistant model "5" baseItemConstructionassistant5L
--     ]
--   , div [ class "label-total" ] [ text ("Crafting Assistance Total: " ++ String.fromInt (assistanceTotal (modelbaseItemConstructionL.get model)) ++ " gp") ]
--   ]

-- sectionAssistant : Model -> String -> Lens BaseItemConstruction AssistantType -> Html Msg
-- sectionAssistant model num lens =
--   let
--     l = compose modelbaseItemConstructionL lens
--     val = assistantInput (l.get model)
--   in
--     tr []
--     [ td [] [ div [] [ span [ class "label" ] [ text ("Assistant " ++ num)]
--                      , br [] []
--                      , span [ class "info" ] [ text ("Assistant " ++ num ++ " Input: " ++ (String.fromInt val) ++ " gp per week") ] 
--                      ] 
--             ]
--     , td [] [ mkSelect model assistantType l ]
--     ]

-- -------------------------------------------------------------------------------
-- -- sectionTools
-- -------------------------------------------------------------------------------

-- sectionTools : Model -> Html Msg
-- sectionTools model =
--   let
--     cin = mCrafterInput model
--     cat = assistanceTotal (modelbaseItemConstructionL.get model)
--     stt = toolTotal (modelbaseItemConstructionL.get model)
--     tci = stt + toFloat cat + toFloat cin
--   in
--     div [ class "borderless" ]
--     [ hr [] []
--     , sectionHeader "Special Tools:" "(Fill in the additional crafting input for each tool)"
--     , table []
--       [ rowToolInput model "1" baseItemConstructiontool1L
--       , rowToolSantification model "1" baseItemConstructiontool1L
--       , rowToolInput model "2" baseItemConstructiontool2L
--       , rowToolSantification model "2" baseItemConstructiontool2L
--       , rowToolInput model "3" baseItemConstructiontool3L
--       , rowToolSantification model "3" baseItemConstructiontool3L
--       , rowToolInput model "4" baseItemConstructiontool4L
--       , rowToolSantification model "4" baseItemConstructiontool4L
--       , rowToolInput model "5" baseItemConstructiontool5L
--       , rowToolSantification model "5" baseItemConstructiontool5L
--       , tr []
--         [ td [ class "label-total" ] [ text ("Special Tools Total: " ++ String.fromFloat stt ++ " gp") ] 
--         , td [ class "label-total" ] [ text ("Total Crafter Input: " ++ String.fromFloat tci ++ " gp") ]
--         ]
--       ]
--     ]

-- rowToolInput : Model -> String -> Lens BaseItemConstruction Tool -> Html Msg
-- rowToolInput model num lens = 
--   let
--     l = compose modelbaseItemConstructionL lens
--     lt = compose l tooltoolTypeL
--     lm = compose l toolmagicalL
--   in
--     tr []
--     [ td [] 
--       [ span [ class "label", style "float" "left" ] [ text ("Tool " ++ num ++ " Quality:") ]
--       , input [ class "checkbox", type_ "checkbox", onCheck (UpdateBool lm), checked (lm.get model) ] []
--       , span [ class "info" ] [ text "Magical" ]
--       ]
--     , td [] [ mkSelect model toolType lt ]
--     ]

-- rowToolSantification : Model -> String -> Lens BaseItemConstruction Tool -> Html Msg
-- rowToolSantification model num lens = 
--   let
--     l = compose (compose modelbaseItemConstructionL lens) toolsanctificationL
--     val = toolInput (modelbaseItemConstructionL.get model) lens
--   in
--     tr []
--     [ td []
--       [ span [ class "label" ] [ text ("Tool " ++ num ++ " Sanctification:") ]
--       , br [] []
--       , span [ class "info" ] [ text ("Tool " ++ num ++ " Input: " ++ (String.fromFloat val) ++ " gp per week") ]
--       ]
--     , td [] [ mkSelect model sanctification l ]
--     ]

-- -------------------------------------------------------------------------------
-- -- sectionEnvironment
-- -------------------------------------------------------------------------------

-- sectionEnvironment : Model -> Html Msg
-- sectionEnvironment model =
--   let
--     lens = compose modelbaseItemConstructionL baseItemConstructioncraftingEnvironmentL
--     val = craftingEnvironmentModifier (lens.get model)
--   in
--     div [] 
--     [ sectionHeader "Calculating Time:" "(A standard workweek, noted as §, is 8 hours per day for 7 days, equaling 56 hours)"
--     , table []
--       [ tr []
--         [ td [] 
--           [ span [ class "label" ] [text "Crafting Setup (choose one):" ]
--           , br [] []
--           , span [ class "info" ] [ text ("Environment: " ++ (String.fromInt val) ++ " to base § hours") ]
--           ]
--         , td [] [ mkSelect model craftingEnvironment lens ]
--         ]
--       ]
--     ]

-- -------------------------------------------------------------------------------
-- -- sectionTime
-- -------------------------------------------------------------------------------

-- sectionTime : Model -> Html Msg
-- sectionTime model =
--   let
--     leat = compose modelbaseItemConstructionL baseItemConstructionenvironmentAttunedL
--     lesc = compose modelbaseItemConstructionL baseItemConstructionenvironmentSanctificationL
--     lacr = toStrLens intStrConv (compose modelbaseItemConstructionL baseItemConstructionadditionalCostReductionL)
--     cet = environmentTotal (modelbaseItemConstructionL.get model)
--     wwh = cet + 56
--     cin = mCrafterInput model
--     cat = assistanceTotal (modelbaseItemConstructionL.get model)
--     stt = toolTotal (modelbaseItemConstructionL.get model)
--     tci = stt + toFloat cat + toFloat cin
--     bip = (compose modelbaseItemConstructionL baseItemConstructionbaseItemPriceL).get model
--     tww = toFloat bip / tci
--     th = totalHours (modelbaseItemConstructionL.get model)
--   in
--     table []
--       [ tr []
--         [ td [] 
--           [ span [ class "label" ] [ text "Specially Attuned (yes/no)" ]
--           , br [] []
--           , span [ class "info" ] [ text ("Attunement: " ++ String.fromInt (envAttunementMod (modelbaseItemConstructionL.get model)) ++ " to base § hours") ]
--           ]
--         , td [] [ input [ type_ "checkbox", onCheck (UpdateBool leat), checked (leat.get model) ] [] ]
--         ]

--       , tr []
--         [ td []
--           [ span [ class "label" ] [ text "Sanctified (choose one):" ]
--           , br [] []
--           , span [ class "info" ] [ text ("Sanctification: " ++ String.fromInt (envSanctificationMod (modelbaseItemConstructionL.get model)) ++ " to base § hours") ]
--           ]
--         , td [] [ mkSelect model sanctification lesc ]
--         ]

--       , tr []
--         [ td [] 
--           [ span [ class "label" ] [ text "Additional Modifiers (if any):" ]
--           , br [] []
--           , span [ class "info" ] [ text ("Determined by DM")]
--           ]
--         , td [] [ input [ type_ "text", placeholder "Additional Modifiers", value (lacr.get model), onInput (UpdateStr lacr) ] [] ]
--         ]

--       , tr []
--         [ td [] [ span [ class "label" ] [ text ("Crafting Environment Total: " ++ String.fromInt cet) ] ]
--         , td [] [ span [ class "info" ] [ text "(Add Crafting Setup, Specialy Attuned, Sactified Modifiers, and Additional Modifiers)" ] ]
--         ]

--       , tr []
--         [ td [] [ span [ class "label" ] [ text ("Workweek (§) Hours: " ++ String.fromInt wwh) ] ]
--         , td [] [ span [ class "info" ] [ text "(Add Crafting Environment Total to 56)" ] ]
--         ]

--       , tr []
--         [ td [] [ span [ class "label" ] [ text ("Total Workweeks (§): " ++ Round.round 2 tww) ] ]
--         , td [] [ span [ class "info" ] [ text "(Divide the Base Item Price by the Total Crafter Input)" ] ]
--         ]

--       , tr []
--         [ td [] [ span [ class "label" ] [ text ("Total Hours: " ++ Round.round 2 th) ] ]
--         , td [] [ span [ class "info" ] [ text "(Multiply the Total Workweeks (§) by Workweek (§) Hours)" ] ]
--         ]
--       ]

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
    , table [ class "cost-table" ]
      [ tr [] 
        [ th [ class "cost-table" ] [ text "Assistant #" ]
        , th [ class "cost-table" ] [ text "Cost (gp per §)" ]
        , th [ class "cost-table" ] [ text "Total Cost (gp)" ]
        ]
      , assistantCost model "1" assistant1L
      , assistantCost model "2" assistant2L
      , assistantCost model "3" assistant3L
      , assistantCost model "4" assistant4L
      , assistantCost model "5" assistant5L
      ]
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

assistantCost : Model -> String -> Lens WorkingConditions AssistantType -> Html Msg
assistantCost model num lens =
  let
    t = (compose workingConditionsL lens).get model
    c = assistantInput t
    tc = assistantTotalCost model.workingConditions t
  in
    tr [] 
    [ td [ class "cost-table" ] [ text num ]
    , td [ class "cost-table" ] [ text (String.fromInt c) ]
    , td [ class "cost-table" ] [ text (Round.round 2 tc) ]
    ]