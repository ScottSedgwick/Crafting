module Model.Shared exposing 
  ( baseEnchantmentCostByRarity
  , baseImprovementCostByRarity
  , baseEnchantmentTimeWeeksByRarity
  , mimicMult
  , tabId
  , tabIndex
  )

import Utils exposing (..)
import Model exposing (..)

tabId : TabName -> String
tabId t = 
  case t of 
    TabNameBaseItemConstruction   -> "BaseItemConstruction"
    TabNameBaseItemImprovement    -> "BaseItemImprovement"
    TabNameItemEnchantment        -> "ItemEnchantment"
    TabNameItemBonusImprovement   -> "ItemBonusImprovement"
    TabNameItemAbilityImprovement -> "ItemAbilityImprovement"
    TabNameNewItemResearch        -> "NewItemResearch"
    TabNameSentientItems          -> "SentientItems"
    TabNameArtifacts              -> "Artifacts"

tabIndex : TabName -> Int
tabIndex t = 
  case t of 
    TabNameBaseItemConstruction   -> 1
    TabNameBaseItemImprovement    -> 2
    TabNameItemEnchantment        -> 3
    TabNameItemBonusImprovement   -> 4
    TabNameItemAbilityImprovement -> 5
    TabNameNewItemResearch        -> 6
    TabNameSentientItems          -> 7
    TabNameArtifacts              -> 8

baseEnchantmentCostByRarity : ItemRarity -> Int
baseEnchantmentCostByRarity r =
  case r of 
    ItemRarityCommon    -> 50
    ItemRarityUncommon  -> 200
    ItemRarityRare      -> 2000
    ItemRarityVeryRare  -> 20000
    ItemRarityLegendary -> 100000

baseImprovementCostByRarity : ItemRarity -> Int
baseImprovementCostByRarity r =
  case r of 
    ItemRarityCommon    -> 100
    ItemRarityUncommon  -> 200
    ItemRarityRare      -> 1000
    ItemRarityVeryRare  -> 2500
    ItemRarityLegendary -> 5000

baseEnchantmentTimeWeeksByRarity : ItemRarity -> Int
baseEnchantmentTimeWeeksByRarity r =
  case r of 
    ItemRarityCommon    -> 1
    ItemRarityUncommon  -> 2
    ItemRarityRare      -> 10
    ItemRarityVeryRare  -> 25
    ItemRarityLegendary -> 50

mimicMult : MimicASpell -> Int
mimicMult m =
  case m of
    MimicASpellNo -> 0
    MimicASpellYesbutcrafterhasnoaccesstoit -> 0
    MimicASpellCast1timeaweek -> 1
    MimicASpellCast2timesaweek -> 2
    MimicASpellCast3timesaweek -> 3
    MimicASpellCast4timesaweek -> 4
    MimicASpellCast5timesaweek -> 5
    MimicASpellCast6timesaweek -> 6
    MimicASpellCast7timesaweek -> 7