module Model.BaseItemConstruction exposing (..)

import Model exposing (..)
import Monocle.Lens exposing (..)
import Model.Shared exposing (..)

craftingEnvironmentModifier : CraftingEnvironment -> Int
craftingEnvironmentModifier e =
  case e of 
    CraftingEnvironmentVeryCrude  -> 15
    CraftingEnvironmentCrude      -> 10
    CraftingEnvironmentBasic      -> 0
    CraftingEnvironmentAdvanced   -> -10
    CraftingEnvironmentExpert     -> -15
    CraftingEnvironmentApex       -> -20


mCrafterInput : Model -> Int
mCrafterInput model = crafterInput ((compose modelbaseItemConstructionL baseItemConstructioncrafterTypeL).get model)

baseMaterialCost : BaseItemConstruction -> Float
baseMaterialCost model = toFloat (baseItemConstructionbaseItemPriceL.get model) * 0.15

envAttunementMod : BaseItemConstruction -> Int
envAttunementMod model = if (baseItemConstructionenvironmentAttunedL.get model) then -5 else 0

envSanctificationMod : BaseItemConstruction -> Int
envSanctificationMod model = 
  case (baseItemConstructionenvironmentSanctificationL.get model) of
    SanctificationNone    -> 0
    SanctificationBasic   -> -5
    SanctificationThemed  -> -15

environmentTotal : BaseItemConstruction -> Int
environmentTotal model = 
  let
    cenv = craftingEnvironmentModifier (baseItemConstructioncraftingEnvironmentL.get model)
    eam = envAttunementMod model
    esm = envSanctificationMod model
    adm = baseItemConstructionadditionalCostReductionL.get model
  in
    cenv + eam + esm + adm

assistanceTotal : BaseItemConstruction -> Int
assistanceTotal model = List.sum (List.map (\l -> assistantInput (l.get model)) [baseItemConstructionassistant1L, baseItemConstructionassistant2L, baseItemConstructionassistant3L, baseItemConstructionassistant4L, baseItemConstructionassistant5L])

assistantTotalCost : BaseItemConstruction -> AssistantType -> Float
assistantTotalCost model t =
  let
    c = assistantInput t
    cet = environmentTotal model
    wwh = cet + 56
    cin = crafterInput (baseItemConstructioncrafterTypeL.get model)
    cat = assistanceTotal model
    stt = toolTotal model
    tci = stt + toFloat cat + toFloat cin
    tww = toFloat wwh / tci
    tc = toFloat c / tww
  in 
    tc

craftingAssistantCostTotal : BaseItemConstruction -> Float
craftingAssistantCostTotal model = 
  List.sum (List.map (\l -> assistantTotalCost model (l.get model)) [ baseItemConstructionassistant1L, baseItemConstructionassistant2L, baseItemConstructionassistant3L, baseItemConstructionassistant4L, baseItemConstructionassistant5L ] )

-- Divide Total Hours by 56
totalWorkWeeks : BaseItemConstruction -> Float
totalWorkWeeks model = totalHours model / 56

totalHours : BaseItemConstruction -> Float
totalHours model =
  let
    cet = environmentTotal model
    wwh = cet + 56
    cin = crafterInput (baseItemConstructioncrafterTypeL.get model)
    cat = assistanceTotal model
    stt = toolTotal model
    tci = stt + toFloat cat + toFloat cin
    bip = baseItemConstructionbaseItemPriceL.get model
    tww = toFloat bip / tci
  in
    tww * toFloat wwh

-- Add Base Materials Costs, Crafting Assistance Cost Total, Additional Crafting Assistance Cost, and Miscellaneous Additional Cost.
totalCosts : BaseItemConstruction -> Float
totalCosts model =
  let
    bmc = baseMaterialCost model
    cact = craftingAssistantCostTotal model
    acac = baseItemConstructionadditionalCraftingAssistanceCostL.get model
    mac = baseItemConstructionmiscAdditionalCostL.get model
  in
    bmc + cact + toFloat acac + toFloat mac
    

toolInput : BaseItemConstruction -> Lens BaseItemConstruction Tool -> Float
toolInput model lens =
  let
    inp = crafterInput (baseItemConstructioncrafterTypeL.get model)
    m = (compose lens toolmagicalL).get model
    t = (compose lens tooltoolTypeL).get model
    s = (compose lens toolsanctificationL).get model
    magBonus = if m then 5 else 0
    base = case t of
            ToolTypeNone -> 0
            ToolTypeSubstandard -> inp - 10
            ToolTypeStandard -> inp + 0
            ToolTypeAdvanced -> inp + 10
            ToolTypeMasterwork -> inp + 15
            ToolTypeMythic -> inp * 3
    sact = case s of
            SanctificationNone -> toFloat base + 0
            SanctificationBasic -> toFloat base + 10
            SanctificationThemed -> toFloat base * 1.5
  in
    if (sact == 0) then 0 else sact + magBonus

toolTotal : BaseItemConstruction -> Float
toolTotal model = List.sum (List.map (toolInput model) [baseItemConstructiontool1L, baseItemConstructiontool2L, baseItemConstructiontool3L, baseItemConstructiontool4L, baseItemConstructiontool5L])
