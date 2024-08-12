module Model.Shared exposing (..)

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

crafterInput : CrafterType -> Int
crafterInput c =
  case c of
    CrafterTypePlayerCharacter        -> 25
    CrafterTypeArtificerNotSpeciality -> 50
    CrafterTypeArtificerSpeciality    -> 100
      
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
