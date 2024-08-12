module Model.ItemEnchantment exposing (..)

import Model exposing (..)
import Model.Shared exposing (..)
import Monocle.Lens exposing (..)
import StrConv exposing (..)
import Utils exposing (..)

baseEnchantmentCost : ItemEnchantment -> Float
baseEnchantmentCost model =
  let
    base = case model.itemRarity of 
                    ItemRarityCommon    -> 50
                    ItemRarityUncommon  -> 200
                    ItemRarityRare      -> 2000
                    ItemRarityVeryRare  -> 20000
                    ItemRarityLegendary -> 100000
    mult1 = if applyMagicItemAdept model then 0.5 else 1.0
    mult2 = if model.oneUseItem then 0.5 else 1.0
    mult3 = if model.accessToIdenticalItem then 0.9 else 1.0
    mult4 = case model.replicateMagicItem of
              ReplicateMagicItemNo              -> 1.0
              ReplicateMagicItemYesbutthecrafterhasnoaccess  -> 1.0
              ReplicateMagicItemYesbutitisnotactive -> 0.9
              ReplicateMagicItemYesanditisactive   -> 0.75
  in
    base * mult1 * mult2 * mult3 * mult4

baseEnchantmentTimeWeeks : ItemEnchantment -> Float
baseEnchantmentTimeWeeks model =
  let 
    base = case model.itemRarity of 
            ItemRarityCommon    -> 1
            ItemRarityUncommon  -> 2
            ItemRarityRare      -> 10
            ItemRarityVeryRare  -> 25
            ItemRarityLegendary -> 50
    mult1 = if applyMagicItemAdept model then 0.25 else 1.0
    mult2 = if model.oneUseItem then 0.5 else 1.0
  in
    base * mult1 * mult2 

baseWeekMultiplier : ItemEnchantment -> Int
baseWeekMultiplier model =
  let
    val = case model.mimicASpell of
            MimicASpellNo                -> 56
            MimicASpellYesbutcrafterhasnoaccesstoit   -> 56
            MimicASpellCast1timeaweek -> 56 - model.numberOfDifferentSpells
            MimicASpellCast2timesaweek -> 56 - (model.numberOfDifferentSpells * 2)
            MimicASpellCast3timesaweek -> 56 - (model.numberOfDifferentSpells * 3)
            MimicASpellCast4timesaweek -> 56 - (model.numberOfDifferentSpells * 4)
            MimicASpellCast5timesaweek -> 56 - (model.numberOfDifferentSpells * 5)
            MimicASpellCast6timesaweek -> 56 - (model.numberOfDifferentSpells * 6)
            MimicASpellCast7timesaweek -> 56 - (model.numberOfDifferentSpells * 7)
  in
    if (val < 0) then 0 else val

baseEnchantmentTimeHours : ItemEnchantment -> Float
baseEnchantmentTimeHours model = 
  let
    betw = baseEnchantmentTimeWeeks model
    mult = baseWeekMultiplier model
  in
    betw * (toFloat mult)

assistanceTotal : ItemEnchantment -> Int
assistanceTotal model = List.sum (List.map (\l -> assistantInput (l.get model)) [itemEnchantmentassistant1L, itemEnchantmentassistant2L, itemEnchantmentassistant3L, itemEnchantmentassistant4L, itemEnchantmentassistant5L])

totalCrafterInput : ItemEnchantment -> Int
totalCrafterInput model = crafterInput model.crafterType + assistanceTotal model

commonOrUncommon : ItemEnchantment -> Bool
commonOrUncommon model = (model.itemRarity == ItemRarityCommon) || (model.itemRarity == ItemRarityUncommon)

applyMagicItemAdept : ItemEnchantment -> Bool
applyMagicItemAdept model = commonOrUncommon model && model.magicItemAdept

componentTimeReductionHours : MagicComponent -> Float
componentTimeReductionHours mc =
  case mc.componentType of
    ComponentItemRarityNone       -> 0
    ComponentItemRarityCommon     -> 9
    ComponentItemRarityUncommon   -> 18
    ComponentItemRarityRare       -> 3 * 56
    ComponentItemRarityVeryRare   -> 8 * 56
    ComponentItemRarityLegendary  -> 10 * 56
      
alignmentMultiplier : MagicComponent -> Float
alignmentMultiplier mc =
  case mc.alignment of
    ComponentAlignmentNone      -> 1.0
    ComponentAlignmentThematic  -> 1.3
    ComponentAlignmentMagical   -> 1.4
    ComponentAlignmentElemental -> 1.5
    ComponentAlignmentDraconic  -> 1.7
    ComponentAlignmentDivine    -> 1.9
    ComponentAlignmentUnique    -> 4.0

componentHourReduction : MagicComponent -> Float
componentHourReduction mc = componentTimeReductionHours mc * alignmentMultiplier mc

magicComponentTotal : ItemEnchantment -> Float
magicComponentTotal model =
  List.sum (List.map (\x -> componentHourReduction (x.get model)) [itemEnchantmentcomponent1L, itemEnchantmentcomponent2L, itemEnchantmentcomponent3L, itemEnchantmentcomponent4L, itemEnchantmentcomponent5L])

totalEnchantmentTimeWeeks : ItemEnchantment -> Float
totalEnchantmentTimeWeeks model =
  let 
    betw = baseEnchantmentTimeWeeks model
    beth = baseEnchantmentTimeHours model
    mult = beth / (betw * 56)
    bec = baseEnchantmentCost model
    tci = toFloat (totalCrafterInput model)
    totalHours = ((bec / tci) * 56 * mult) - (magicComponentTotal model)
  in 
    if (totalHours < 0) then 0 else totalHours / 56

assistantCost : AssistantType -> Float -> Float
assistantCost asstType weeks = (toFloat (assistantInput asstType)) * weeks

assistantCostTotal : ItemEnchantment -> Float
assistantCostTotal model = List.sum (List.map (\x -> assistantCost (x.get model) (totalEnchantmentTimeWeeks model)) [itemEnchantmentassistant1L, itemEnchantmentassistant2L, itemEnchantmentassistant3L, itemEnchantmentassistant4L, itemEnchantmentassistant5L])

totalEnchantmentCost : ItemEnchantment -> Float
totalEnchantmentCost model = baseEnchantmentCost model + assistantCostTotal model + toFloat model.additionalCost