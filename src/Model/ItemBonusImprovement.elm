module Model.ItemBonusImprovement exposing (..)

import Model exposing (..)
import Model.WorkingConditions exposing(..)
import Model.Shared exposing(..)

upgradedRarity : StartingItemRarity -> ItemRarity
upgradedRarity r =
  case r of
    StartingItemRarityUncommon  -> ItemRarityRare
    StartingItemRarityRare      -> ItemRarityVeryRare
    StartingItemRarityVeryRare  -> ItemRarityLegendary

crafterImprovementPercentage : CrafterType -> Float
crafterImprovementPercentage t =
  case t of
    CrafterTypePlayerCharacter          -> 0.15
    CrafterTypeArtificerNotSpeciality   -> 0.25
    CrafterTypeArtificerSpeciality      -> 0.35

totalImprovementCost : Model -> Float
totalImprovementCost m =
  let
    newRarity = upgradedRarity m.itemBonusImprovement.currentRarity
    improvement = crafterImprovementPercentage m.workingConditions.crafterType
    baseCost = baseImprovementCostByRarity newRarity
  in
    toFloat baseCost * (1 - improvement)

totalImprovementTimeWeeks : Model -> Float
totalImprovementTimeWeeks m =
  let
    newRarity = upgradedRarity m.itemBonusImprovement.currentRarity
    improvement = crafterImprovementPercentage m.workingConditions.crafterType
    baseTime = baseEnchantmentTimeWeeksByRarity newRarity
  in
    toFloat baseTime * (1 - improvement)

totalImprovementTimeHours : Model -> Float
totalImprovementTimeHours m =
  let
    weeks = baseImprovementTime m
    hoursPerWeek = toFloat (workWeekHours m.workingConditions)
  in
    weeks * hoursPerWeek
    
baseImprovementTime : Model -> Float
baseImprovementTime model = totalImprovementCost model / totalCrafterInput model