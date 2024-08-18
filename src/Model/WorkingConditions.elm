module Model.WorkingConditions exposing 
  ( assistantInput
  , assistanceInputPerWeekTotal
  , assistantTotalCost
  , allAssistantsCostTotal
  , allToolsMagicBonuses
  , allToolsQualityBonuses
  , crafterInput
  , craftingEnvironmentModifier
  , environmentTotal
  , envAttunementMod
  , envSanctificationMod
  , mCrafterInput
  , toolInput
  , toolTotal
  , totalCrafterInput
  , workWeekHours
  )

import Model exposing (..)
import Monocle.Lens exposing (..)
import Model.Shared exposing (..)

-------------------------------------------------------------------------------
-- Assistant calculations
-------------------------------------------------------------------------------  
assistantInput : AssistantType -> Int
assistantInput a = 
  case a of
    AssistantTypeNone                   -> 0
    AssistantTypeNotProficient          -> 5
    AssistantTypeHalfProficient         -> 7
    AssistantTypeProficient             -> 15
    AssistantTypePlayerCharacter        -> 25
    AssistantTypeExpertise              -> 30
    AssistantTypeArtificerNotSpeciality -> 50
    AssistantTypeArtificerSpeciality    -> 100

assistanceInputPerWeekTotal : WorkingConditions -> Int
assistanceInputPerWeekTotal model = List.sum (List.map (\l -> assistantInput (l.get model)) [assistant1L, assistant2L, assistant3L, assistant4L, assistant5L])

assistantCost : AssistantType -> Float -> Float
assistantCost asstType weeks = (toFloat (assistantInput asstType)) * weeks

allAssistantsCostTotal : Float -> WorkingConditions -> Float
allAssistantsCostTotal weeks model = List.sum (List.map (\x -> assistantCost (x.get model) weeks) [assistant1L, assistant2L, assistant3L, assistant4L, assistant5L])

assistantTotalCost : Float -> AssistantType -> Float
assistantTotalCost timeWeeks t =
  let
    costPerWeek = assistantInput t
  in
    toFloat costPerWeek * timeWeeks

-------------------------------------------------------------------------------
-- Crafting input calculations
-------------------------------------------------------------------------------
crafterInput : CrafterType -> Int
crafterInput c =
  case c of
    CrafterTypePlayerCharacter        -> 25
    CrafterTypeArtificerNotSpeciality -> 50
    CrafterTypeArtificerSpeciality    -> 100

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
mCrafterInput model = crafterInput ((compose workingConditionsL crafterTypeL).get model)

totalCrafterInput : Model -> Float
totalCrafterInput model =
  let
    cin = mCrafterInput model
    cat = assistanceInputPerWeekTotal (workingConditionsL.get model)
    stt = toolTotal (workingConditionsL.get model)
    tci = stt + toFloat cat + toFloat cin
  in
    tci

-------------------------------------------------------------------------------
-- Sanctification bonus calculations
-------------------------------------------------------------------------------
envSanctificationMod : WorkingConditions -> Int
envSanctificationMod model = 
  case (environmentSanctificationL.get model) of
    SanctificationNone    -> 0
    SanctificationBasic   -> -5
    SanctificationThemed  -> -15

-------------------------------------------------------------------------------
-- Environment quality calculations
-------------------------------------------------------------------------------
envAttunementMod : WorkingConditions -> Int
envAttunementMod wc = if (environmentAttunedL.get wc) then -5 else 0

environmentTotal : WorkingConditions -> Int
environmentTotal model = 
  let
    cenv = craftingEnvironmentModifier (craftingEnvironmentL.get model)
    eam = envAttunementMod model
    esm = envSanctificationMod model
  in
    cenv + eam + esm

-------------------------------------------------------------------------------
-- Hours in a work week calculations
-------------------------------------------------------------------------------
workWeekHours : WorkingConditions -> Int
workWeekHours model = environmentTotal model + 56

-------------------------------------------------------------------------------
-- Tool input calculations
-------------------------------------------------------------------------------
toolInput : WorkingConditions -> Lens WorkingConditions Tool -> Float
toolInput model lens =
  let
    inp = crafterInput (crafterTypeL.get model)
    m = (compose lens magicalL).get model
    t = (compose lens toolTypeL).get model
    s = (compose lens sanctificationL).get model
    magBonus = magicInput m * 5
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
    if (sact == 0) then 0 else sact + toFloat magBonus

magicInput : MagicBonus -> Int
magicInput b =
  case b of
    MagicBonusNone -> 0
    MagicBonusPlus1 -> 1
    MagicBonusPlus2 -> 2
    MagicBonusPlus3 -> 3

toolTotal : WorkingConditions -> Float
toolTotal model = List.sum (List.map (toolInput model) [tool1L, tool2L, tool3L, tool4L, tool5L])

allToolsQualityBonuses : WorkingConditions -> Int
allToolsQualityBonuses model = List.sum (List.map (\x -> qualityInput x.toolType) [model.tool1, model.tool2, model.tool3, model.tool4, model.tool5])

qualityInput : ToolType -> Int
qualityInput t =
  case t of
    ToolTypeNone -> 0
    ToolTypeSubstandard -> -1
    ToolTypeStandard -> 0
    ToolTypeAdvanced -> 1
    ToolTypeMasterwork -> 2
    ToolTypeMythic -> 3

allToolsMagicBonuses : WorkingConditions -> Int
allToolsMagicBonuses model = List.sum (List.map (\x -> magicInput x.magical) [model.tool1, model.tool2, model.tool3, model.tool4, model.tool5])
