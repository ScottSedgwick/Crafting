module Model.Shared exposing (..)

import Utils exposing (..)

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

type CrafterType = CrafterTypePlayerCharacter
                 | CrafterTypeArtificer
                 | CrafterTypeArtificerSpecialist

crafterType : StrConv CrafterType
crafterType =
  let
    to c =
      case c of
        CrafterTypePlayerCharacter     -> "Player Character/Non-Artificer"
        CrafterTypeArtificer           -> "Artificer (non-speciality)"
        CrafterTypeArtificerSpecialist -> "Artificer (speciality)"
    all = [ CrafterTypePlayerCharacter, CrafterTypeArtificer, CrafterTypeArtificerSpecialist ]
    def = CrafterTypePlayerCharacter
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

crafterInput : CrafterType -> Int
crafterInput c =
  if c == CrafterTypePlayerCharacter then 25
  else if c == CrafterTypeArtificer  then 50
  else if c == CrafterTypeArtificerSpecialist then 100
  else 0

type AssistantType = AssistantTypeNone
                   | AssistantTypeNotProficient
                   | AssistantTypeHalfProficient
                   | AssistantTypeProficient
                   | AssistantTypePlayerCharacter
                   | AssistantTypeExpertise
                   | AssistantTypeArtificer
                   | AssistantTypeArtificerSpecialist

assistantType : StrConv AssistantType
assistantType =
  let
    to t =
      case t of
        AssistantTypeNone                 -> "None"
        AssistantTypeNotProficient        -> "Not Proficient"
        AssistantTypeHalfProficient       -> "Half Proficient"
        AssistantTypeProficient           -> "Proficient"
        AssistantTypePlayerCharacter      -> "Player Character"
        AssistantTypeExpertise            -> "Expertise"
        AssistantTypeArtificer            -> "Artificer (non-specialist)"
        AssistantTypeArtificerSpecialist  -> "Artificer (specialist)"
    all = [ AssistantTypeNone
          , AssistantTypeNotProficient
          , AssistantTypeHalfProficient
          , AssistantTypeProficient
          , AssistantTypePlayerCharacter
          , AssistantTypeExpertise
          , AssistantTypeArtificer
          , AssistantTypeArtificerSpecialist
          ]
    def = AssistantTypeNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

assistantInput : AssistantType -> Int
assistantInput a = 
  case a of
    AssistantTypeNone                 -> 0
    AssistantTypeNotProficient        -> 5
    AssistantTypeHalfProficient       -> 7
    AssistantTypeProficient           -> 15
    AssistantTypePlayerCharacter      -> 25
    AssistantTypeExpertise            -> 30
    AssistantTypeArtificer            -> 50
    AssistantTypeArtificerSpecialist  -> 100

type ItemRarity 
  = ItemRarityCommon
  | ItemRarityUncommon
  | ItemRarityRare
  | ItemRarityVeryRare
  | ItemRarityLegendary

itemRarity : StrConv ItemRarity
itemRarity =
  let
    to e =
      case e of
        ItemRarityCommon    -> "Common"
        ItemRarityUncommon  -> "Uncommon"
        ItemRarityRare      -> "Rare"
        ItemRarityVeryRare  -> "Very Rare"
        ItemRarityLegendary -> "Legendary"
    all = [ ItemRarityCommon, ItemRarityUncommon, ItemRarityRare, ItemRarityVeryRare, ItemRarityLegendary ]
    def = ItemRarityCommon
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }