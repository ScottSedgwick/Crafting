module Model.ItemEnchantment exposing (..)

import Model exposing (..)
import Model.WorkingConditions exposing (..)
import Monocle.Lens exposing (..)

baseEnchantmentCost : Model -> Float
baseEnchantmentCost model =
  let
    base = case model.itemEnchantment.itemRarity of 
                    ItemRarityCommon    -> 50
                    ItemRarityUncommon  -> 200
                    ItemRarityRare      -> 2000
                    ItemRarityVeryRare  -> 20000
                    ItemRarityLegendary -> 100000
    mult1 = if applyMagicItemAdept model then 0.5 else 1.0
    mult2 = if model.itemEnchantment.oneUseItem then 0.5 else 1.0
    mult3 = if model.itemEnchantment.accessToIdenticalItem then 0.9 else 1.0
    mult4 = case model.itemEnchantment.replicateMagicItem of
              ReplicateMagicItemNo              -> 1.0
              ReplicateMagicItemYesbutthecrafterhasnoaccess  -> 1.0
              ReplicateMagicItemYesbutitisnotactive -> 0.9
              ReplicateMagicItemYesanditisactive   -> 0.75
  in
    base * mult1 * mult2 * mult3 * mult4

-- This should be the base enchantment cost, divided by the total crafter input
baseEnchantmentTimeWeeks : Model -> Float
baseEnchantmentTimeWeeks model =
  let 
    base = baseEnchantmentCost model / totalCrafterInput model
    mult1 = if applyMagicItemAdept model then 0.25 else 1.0
    mult2 = if model.itemEnchantment.oneUseItem then 0.5 else 1.0
  in
    base * mult1 * mult2 

totalTimeHours : Model -> Float
totalTimeHours model = 
  let
    res = (baseEnchantmentTimeWeeks model * toFloat (workWeekHours model.workingConditions)) - totalComponentTimeReduction model
  in
    if res < 0 then 0 else res

totalTimeDays : Model -> Float
totalTimeDays model = totalTimeHours model / 8

totalTimeWeeks : Model -> Float
totalTimeWeeks model = totalTimeHours model / 56

-- baseWeekMultiplier : ItemEnchantment -> Int
-- baseWeekMultiplier model =
--   let
--     val = case model.mimicASpell of
--             MimicASpellNo                -> 56
--             MimicASpellYesbutcrafterhasnoaccesstoit   -> 56
--             MimicASpellCast1timeaweek -> 56 - model.numberOfDifferentSpells
--             MimicASpellCast2timesaweek -> 56 - (model.numberOfDifferentSpells * 2)
--             MimicASpellCast3timesaweek -> 56 - (model.numberOfDifferentSpells * 3)
--             MimicASpellCast4timesaweek -> 56 - (model.numberOfDifferentSpells * 4)
--             MimicASpellCast5timesaweek -> 56 - (model.numberOfDifferentSpells * 5)
--             MimicASpellCast6timesaweek -> 56 - (model.numberOfDifferentSpells * 6)
--             MimicASpellCast7timesaweek -> 56 - (model.numberOfDifferentSpells * 7)
--   in
--     if (val < 0) then 0 else val

-- baseEnchantmentTimeHours : ItemEnchantment -> Float
-- baseEnchantmentTimeHours model = 
--   let
--     betw = baseEnchantmentTimeWeeks model
--     mult = baseWeekMultiplier model
--   in
--     betw * (toFloat mult)

-- totalCrafterInput : WorkingConditions -> ItemEnchantment -> Int
-- totalCrafterInput wc model = crafterInput model.crafterType + assistanceTotal wc

commonOrUncommon : ItemEnchantment -> Bool
commonOrUncommon model = (model.itemRarity == ItemRarityCommon) || (model.itemRarity == ItemRarityUncommon)

applyMagicItemAdept : Model -> Bool
applyMagicItemAdept model = commonOrUncommon model.itemEnchantment && model.workingConditions.magicItemAdept

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

totalComponentTimeReduction : Model -> Float
totalComponentTimeReduction model =
  List.sum (List.map (\l -> componentHourReduction ((compose itemEnchantmentL l).get model)) [component1L, component2L, component3L, component4L, component5L])

-- magicComponentTotal : ItemEnchantment -> Float
-- magicComponentTotal model =
--   List.sum (List.map (\x -> componentHourReduction (x.get model)) [component1L, component2L, component3L, component4L, component5L])

-- totalEnchantmentTimeWeeks : ItemEnchantment -> Float
-- totalEnchantmentTimeWeeks model =
--   let 
--     betw = baseEnchantmentTimeWeeks model
--     beth = baseEnchantmentTimeHours model
--     mult = beth / (betw * 56)
--     bec = baseEnchantmentCost model
--     tci = toFloat (totalCrafterInput model)
--     totalHours = ((bec / tci) * 56 * mult) - (magicComponentTotal model)
--   in 
--     if (totalHours < 0) then 0 else totalHours / 56

-- totalEnchantmentCost : ItemEnchantment -> Float
-- totalEnchantmentCost model = baseEnchantmentCost model + assistantCostTotal model + toFloat model.additionalCost
