module View.WorkingEnvironment exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.WorkingConditions exposing (..)
import Model.Shared exposing (..)
import Monocle.Lens exposing (..)
import Round 
import StrConv exposing (..)
import Utils exposing (..)
import View.Utils exposing (..)

view : Model -> Html Msg
view model =
  div [] 
    [ sectionCrafterType model
    , sectionCraftingAssistance model
    , sectionTools model
    , sectionEnvironment model
    , sectionTime model
    , sectionTotalCrafterInput model
    ]

-------------------------------------------------------------------------------
-- sectionCrafterType
-------------------------------------------------------------------------------
sectionCrafterType : Model -> Html Msg
sectionCrafterType model =
  let
    l = compose workingConditionsL crafterTypeL
    ls = toStrLens crafterType l
    mkOpt a = option [ value (crafterType.toStr a), selected (l.get model == a) ] [ text (crafterType.toStr a) ]
  in
    div []
    [ hr [] []
    , table []
      [ tr [] 
        [ td [] 
          [ span [ class "section-header" ] [ text "Crafter Type: " ]
          , span [ class "info" ] [ text ("Input: " ++ (String.fromInt (mCrafterInput model)) ++ " gp")  ]
          ]
        , td [] [ select [ onInput (UpdateStr ls), value (ls.get model) ] (List.map mkOpt crafterType.all) ]
        ]
      , tr [] [ td [ colspan 2 ] [ span [ class "info" ] [ text "(The amount that your character adds to the total)" ] ] ]
      , tr [] 
        [ td [ class "label" ] [ text "Does the Crafter have the Magic Item Adept ability?" ]
        , td [] [ check model (compose workingConditionsL magicItemAdeptL) ]
        ]
      ]
    ]

-------------------------------------------------------------------------------
-- sectionCraftingAssistance
-------------------------------------------------------------------------------
sectionCraftingAssistance : Model -> Html Msg
sectionCraftingAssistance model =
  div [ class "borderless"]
  [ hr [] [] 
  , div [] 
    [ span [ class "section-header" ] [ text ("Crafting Assistance: ") ]
    , span [ class "section-subscript" ] [ text "(Fill in the Crafting Input for each Assistant)" ]
    , span [ class "section-total" ] [ text ("Crafting Assistance Total: " ++ String.fromInt (assistanceInputPerWeekTotal model.workingConditions) ++ " gp") ]
    ]
  , table [ style "width" "100%" ]
    [ sectionAssistant model "1" assistant1L
    , sectionAssistant model "2" assistant2L
    , sectionAssistant model "3" assistant3L
    , sectionAssistant model "4" assistant4L
    , sectionAssistant model "5" assistant5L
    ]
  ]

sectionAssistant : Model -> String -> Lens WorkingConditions AssistantType -> Html Msg
sectionAssistant model num lens =
  let
    l = compose workingConditionsL lens
    val = assistantInput (l.get model)
  in
    tr []
    [ td [] [ div [] [ span [ class "label" ] [ text ("Assistant " ++ num ++ ": ")]
                     , span [ class "info" ] [ text ("Input: " ++ (String.fromInt val) ++ " gp per week") ] 
                     ] 
            ]
    , td [] [ mkSelect model assistantType l ]
    ]

-------------------------------------------------------------------------------
-- sectionTools
-------------------------------------------------------------------------------

sectionTools : Model -> Html Msg
sectionTools model =
    div [ class "borderless" ]
    [ hr [] []
    , div [] 
      [ span [ class "section-header" ] [ text ("Special Tools: ") ]
      , span [ class "section-subscript" ] [ text "(Fill in the additional crafting input for each tool)" ]
      , span [ class "section-total" ] [ text ("Special Tools Total: " ++ Round.round 2 (toolTotal (workingConditionsL.get model)) ++ " gp") ]
      ]
    , table [] (allTools model [ ("1", tool1L), ("2", tool2L), ("3", tool3L), ("4", tool4L), ("5", tool5L) ] )
    ]

allTools : Model -> List (String , Lens WorkingConditions Tool) -> List (Html Msg)
allTools model xs = 
  let
    divider = [ hr [ class "dotted" ] [] ]
    tools = List.map (toolSet model) xs
  in 
    List.concat (List.intersperse divider tools)

toolSet : Model -> (String, Lens WorkingConditions Tool) -> List (Html Msg)
toolSet model (num, lens) =
  [ rowToolInput model num lens
  , rowToolMagic model num lens
  , rowToolSantification model num lens
  ]

rowToolInput : Model -> String -> Lens WorkingConditions Tool -> Html Msg
rowToolInput model num lens = 
  let
    l = compose workingConditionsL lens
    lt = compose l toolTypeL
  in
    tr []
    [ td [ class "label" ] [ text ("Tool " ++ num ++ " Quality:") ] 
    , td [] [ mkSelect model toolType lt ]
    ]

rowToolMagic : Model -> String -> Lens WorkingConditions Tool -> Html Msg
rowToolMagic model num lens = 
  let
    l = compose workingConditionsL lens
    lm = compose l magicalL
  in
    tr [] 
      [ td [ class "label" ] [ text ("Tool " ++ num ++ " Magical Bonus:") ] 
      , mkSelect model magicBonus lm 
      ]

rowToolSantification : Model -> String -> Lens WorkingConditions Tool -> Html Msg
rowToolSantification model num lens = 
  let
    l = compose (compose workingConditionsL lens) sanctificationL
    val = toolInput (workingConditionsL.get model) lens
  in
    tr []
    [ td []
      [ span [ class "label" ] [ text ("Tool " ++ num ++ " Sanctification: ") ]
      , span [ class "info" ] [ text ("Input: " ++ (String.fromFloat val) ++ " gp per week") ]
      ]
    , td [] [ mkSelect model sanctification l ]
    ]

-------------------------------------------------------------------------------
-- sectionTotalCrafterInput
-------------------------------------------------------------------------------

sectionTotalCrafterInput : Model -> Html Msg
sectionTotalCrafterInput model =
    div [ class "borderless" ]
    [ hr [] []
    , span [ class "section-header" ] [ text "Total Crafter Input (gp): " ]
    , span [ class "label" ] [ text (Round.round 2 (totalCrafterInput model)) ]
    ]

-------------------------------------------------------------------------------
-- sectionEnvironment
-------------------------------------------------------------------------------

sectionEnvironment : Model -> Html Msg
sectionEnvironment model =
  let
    lens = compose workingConditionsL craftingEnvironmentL
    val = craftingEnvironmentModifier (lens.get model)
    leat = compose workingConditionsL environmentAttunedL
    lesc = compose workingConditionsL environmentSanctificationL
    lacr = toStrLens intStrConv (compose workingConditionsL additionalCostReductionL)
  in
    div [] 
    [ hr [] []
    , sectionHeader "Workplace:" "(A standard workweek, noted as §, is 8 hours per day for 7 days, equaling 56 hours)"
    , table []
      [ tr []
        [ td [] 
          [ span [ class "label" ] [text "Crafting Setup (choose one): " ]
          , span [ class "info" ] [ text ((String.fromInt val) ++ " to base § hours") ]
          ]
        , td [] [ mkSelect model craftingEnvironment lens ]
        ]
      , tr []
        [ td [] 
          [ span [ class "label" ] [ text "Specially Attuned (yes/no): " ]
          , span [ class "info" ] [ text (String.fromInt (envAttunementMod (workingConditionsL.get model)) ++ " to base § hours") ]
          ]
        , td [] [ input [ type_ "checkbox", onCheck (UpdateBool leat), checked (leat.get model) ] [] ]
        ]

      , tr []
        [ td []
          [ span [ class "label" ] [ text "Sanctified (choose one): " ]
          , span [ class "info" ] [ text (String.fromInt (envSanctificationMod (workingConditionsL.get model)) ++ " to base § hours") ]
          ]
        , td [] [ mkSelect model sanctification lesc ]
        ]

      , tr []
        [ td [] 
          [ span [ class "label" ] [ text "Additional Modifiers (if any): " ]
          , span [ class "info" ] [ text ("Determined by DM")]
          ]
        , td [] [ input [ type_ "text", placeholder "Additional Modifiers", value (lacr.get model), onInput (UpdateStr lacr) ] [] ]
        ]
      ]
    ]

-------------------------------------------------------------------------------
-- sectionTime
-------------------------------------------------------------------------------

sectionTime : Model -> Html Msg
sectionTime model =
  let
    cet = environmentTotal model.workingConditions
    wwh = workWeekHours model.workingConditions
  in
    div []
    [ hr [] []
    , sectionHeader "Workweek Modifiers:" ""
    , table []
      [ tr []
        [ td [] [ span [ class "label" ] [ text ("Crafting Environment Total: " ++ String.fromInt cet) ] ]
        , td [] [ span [ class "info" ] [ text "(Add Crafting Setup, Specialy Attuned, Sactified Modifiers, and Additional Modifiers)" ] ]
        ]

      , tr []
        [ td [] [ span [ class "label" ] [ text ("Workweek (§) Hours: " ++ String.fromInt wwh) ] ]
        , td [] [ span [ class "info" ] [ text "(Add Crafting Environment Total to 56)" ] ]
        ]
      ]
    ]
