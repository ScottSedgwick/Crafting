module Model.Shared exposing 
  ( tabId
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
