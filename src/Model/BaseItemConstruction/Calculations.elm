module Model.BaseItemConstruction.Calculations exposing (..)

import Model.BaseItemConstruction exposing (..)
import Model.BaseItemConstruction.Lenses exposing (..)
import Monocle.Lens exposing (..)

baseMaterialCost : BaseItemConstruction -> Float
baseMaterialCost model = toFloat ((baseItemPrice).get model) * 0.15

envAttunementMod : BaseItemConstruction -> Int
envAttunementMod model = if (environmentAttuned.get model) then -5 else 0

envSanctificationMod : BaseItemConstruction -> Int
envSanctificationMod model = 
  case (environmentSanctification.get model) of
    SanctificationNone    -> 0
    SanctificationBasic   -> -5
    SanctificationThemed  -> -15

environmentTotal : BaseItemConstruction -> Int
environmentTotal model = 
  let
    cenv = craftingEnvironmentModifier (craftingEnvironmentL.get model)
    eam = envAttunementMod model
    esm = envSanctificationMod model
    adm = additionalCostReduction.get model
  in
    cenv + eam + esm + adm

assistanceTotal : BaseItemConstruction -> Int
assistanceTotal model = List.sum (List.map (\l -> assistantInput (l.get model)) [assistant1, assistant2, assistant3, assistant4, assistant5])

assistantTotalCost : BaseItemConstruction -> AssistantType -> Float
assistantTotalCost model t =
  let
    c = assistantInput t
    cet = environmentTotal model
    wwh = cet + 56
    cin = crafterInput (crafterTypeL.get model)
    cat = assistanceTotal model
    stt = toolTotal model
    tci = stt + toFloat cat + toFloat cin
    tww = toFloat wwh / tci
    tc = toFloat c / tww
  in 
    tc

toolInput : BaseItemConstruction -> Lens BaseItemConstruction Tool -> Float
toolInput model lens =
  let
    inp = crafterInput (crafterTypeL.get model)
    m = (compose lens magicalL).get model
    t = (compose lens toolTypeL).get model
    s = (compose lens sanctificationL).get model
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
toolTotal model = List.sum (List.map (toolInput model) [tool1, tool2, tool3, tool4, tool5])

crafterInput : CrafterType -> Int
crafterInput c =
  if c == CrafterTypePlayerCharacter then 25
  else if c == CrafterTypeArtificer  then 50
  else if c == CrafterTypeArtificerSpecialist then 100
  else 0