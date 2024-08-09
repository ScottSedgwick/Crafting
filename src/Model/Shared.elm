module Model.Shared exposing (..)

type TabName = TabNameBaseItemConstruction
             | TabNameBaseItemImprovement
             | TabNameItemEnchantment
             | TabNameItemBonusImprovement
             | TabNameItemAbilityImprovement
             | TabNameNewItemResearch
             | TabNameSentientItems
             | TabNameArtifacts

allTabs : List TabName
allTabs = 
  [ TabNameBaseItemConstruction
  , TabNameBaseItemImprovement
  , TabNameItemEnchantment
  , TabNameItemBonusImprovement
  , TabNameItemAbilityImprovement
  , TabNameNewItemResearch
  , TabNameSentientItems
  , TabNameArtifacts
  ]

tabName : TabName -> String
tabName t = case t of 
                TabNameBaseItemConstruction   -> "Base Item Construction"
                TabNameBaseItemImprovement    -> "Base Item Improvement"
                TabNameItemEnchantment        -> "Item Enchantment"
                TabNameItemBonusImprovement   -> "Item Bonus Improvement"
                TabNameItemAbilityImprovement -> "Item Ability Improvement"
                TabNameNewItemResearch        -> "New Item Research"
                TabNameSentientItems          -> "Sentient Items"
                TabNameArtifacts              -> "Artifacts"

tabId : TabName -> String
tabId t = case t of 
                TabNameBaseItemConstruction   -> "BaseItemConstruction"
                TabNameBaseItemImprovement    -> "BaseItemImprovement"
                TabNameItemEnchantment        -> "ItemEnchantment"
                TabNameItemBonusImprovement   -> "ItemBonusImprovement"
                TabNameItemAbilityImprovement -> "ItemAbilityImprovement"
                TabNameNewItemResearch        -> "NewItemResearch"
                TabNameSentientItems          -> "SentientItems"
                TabNameArtifacts              -> "Artifacts"

tabIndex : TabName -> Int
tabIndex t = case t of 
                TabNameBaseItemConstruction   -> 1
                TabNameBaseItemImprovement    -> 2
                TabNameItemEnchantment        -> 3
                TabNameItemBonusImprovement   -> 4
                TabNameItemAbilityImprovement -> 5
                TabNameNewItemResearch        -> 6
                TabNameSentientItems          -> 7
                TabNameArtifacts              -> 8
