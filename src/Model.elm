module Model exposing (..)

import Monocle.Lens exposing (..)
import StrConv exposing (..)

------------------------------------------------------------------------------------------------------
-- Model
------------------------------------------------------------------------------------------------------
type alias Model =
  { currentTab : TabName
  , baseItemConstruction : BaseItemConstruction
  , baseItemImprovement : BaseItemImprovement
  , itemEnchantment : ItemEnchantment
  , itemBonusImprovement : ItemBonusImprovement
  }

initModel : Model
initModel =
  { currentTab = TabNameBaseItemConstruction
  , baseItemConstruction = initBaseItemConstruction
  , baseItemImprovement = initBaseItemImprovement
  , itemEnchantment = initItemEnchantment
  , itemBonusImprovement = initItemBonusImprovement
  }

modelcurrentTabL : Lens Model TabName
modelcurrentTabL = Lens .currentTab (\x a -> { a | currentTab = x } )

modelcurrentTabStrL : Lens Model String
modelcurrentTabStrL = toStrLens tabName modelcurrentTabL

modelbaseItemConstructionL : Lens Model BaseItemConstruction
modelbaseItemConstructionL = Lens .baseItemConstruction (\x a -> { a | baseItemConstruction = x } )

modelbaseItemImprovementL : Lens Model BaseItemImprovement
modelbaseItemImprovementL = Lens .baseItemImprovement (\x a -> { a | baseItemImprovement = x } )

modelitemEnchantmentL : Lens Model ItemEnchantment
modelitemEnchantmentL = Lens .itemEnchantment (\x a -> { a | itemEnchantment = x } )

modelitemBonusImprovementL : Lens Model ItemBonusImprovement
modelitemBonusImprovementL = Lens .itemBonusImprovement (\x a -> { a | itemBonusImprovement = x } )

------------------------------------------------------------------------------------------------------
-- Msg
------------------------------------------------------------------------------------------------------
type Msg
  = ChangeTab TabName
  | UpdateStr (Lens Model String) String
  | UpdateBool (Lens Model Bool) Bool

------------------------------------------------------------------------------------------------------
-- TabName
------------------------------------------------------------------------------------------------------
type TabName
  = TabNameBaseItemConstruction
  | TabNameBaseItemImprovement
  | TabNameItemEnchantment
  | TabNameItemBonusImprovement
  | TabNameItemAbilityImprovement
  | TabNameNewItemResearch
  | TabNameSentientItems
  | TabNameArtifacts

tabName : StrConv TabName
tabName =
  let
    to x =
      case x of
        TabNameBaseItemConstruction -> "Base Item Construction"
        TabNameBaseItemImprovement -> "Base Item Improvement"
        TabNameItemEnchantment -> "Item Enchantment"
        TabNameItemBonusImprovement -> "Item Bonus Improvement"
        TabNameItemAbilityImprovement -> "Item Ability Improvement"
        TabNameNewItemResearch -> "New Item Research"
        TabNameSentientItems -> "Sentient Items"
        TabNameArtifacts -> "Artifacts"
    all = [TabNameBaseItemConstruction, TabNameBaseItemImprovement, TabNameItemEnchantment, TabNameItemBonusImprovement, TabNameItemAbilityImprovement, TabNameNewItemResearch, TabNameSentientItems, TabNameArtifacts]
    def = TabNameBaseItemConstruction
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- CrafterType
------------------------------------------------------------------------------------------------------
type CrafterType
  = CrafterTypePlayerCharacter
  | CrafterTypeArtificerNotSpeciality
  | CrafterTypeArtificerSpeciality

crafterType : StrConv CrafterType
crafterType =
  let
    to x =
      case x of
        CrafterTypePlayerCharacter -> "Player Character"
        CrafterTypeArtificerNotSpeciality -> "Artificer Not Speciality"
        CrafterTypeArtificerSpeciality -> "Artificer Speciality"
    all = [CrafterTypePlayerCharacter, CrafterTypeArtificerNotSpeciality, CrafterTypeArtificerSpeciality]
    def = CrafterTypePlayerCharacter
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- AssistantType
------------------------------------------------------------------------------------------------------
type AssistantType
  = AssistantTypeNone
  | AssistantTypeNotProficient
  | AssistantTypeHalfProficient
  | AssistantTypeProficient
  | AssistantTypePlayerCharacter
  | AssistantTypeExpertise
  | AssistantTypeArtificerNotSpeciality
  | AssistantTypeArtificerSpeciality

assistantType : StrConv AssistantType
assistantType =
  let
    to x =
      case x of
        AssistantTypeNone -> "None"
        AssistantTypeNotProficient -> "Not Proficient"
        AssistantTypeHalfProficient -> "Half Proficient"
        AssistantTypeProficient -> "Proficient"
        AssistantTypePlayerCharacter -> "Player Character"
        AssistantTypeExpertise -> "Expertise"
        AssistantTypeArtificerNotSpeciality -> "Artificer Not Speciality"
        AssistantTypeArtificerSpeciality -> "Artificer Speciality"
    all = [AssistantTypeNone, AssistantTypeNotProficient, AssistantTypeHalfProficient, AssistantTypeProficient, AssistantTypePlayerCharacter, AssistantTypeExpertise, AssistantTypeArtificerNotSpeciality, AssistantTypeArtificerSpeciality]
    def = AssistantTypeNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ItemRarity
------------------------------------------------------------------------------------------------------
type ItemRarity
  = ItemRarityCommon
  | ItemRarityUncommon
  | ItemRarityRare
  | ItemRarityVeryRare
  | ItemRarityLegendary

itemRarity : StrConv ItemRarity
itemRarity =
  let
    to x =
      case x of
        ItemRarityCommon -> "Common"
        ItemRarityUncommon -> "Uncommon"
        ItemRarityRare -> "Rare"
        ItemRarityVeryRare -> "Very Rare"
        ItemRarityLegendary -> "Legendary"
    all = [ItemRarityCommon, ItemRarityUncommon, ItemRarityRare, ItemRarityVeryRare, ItemRarityLegendary]
    def = ItemRarityCommon
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- CraftingEnvironment
------------------------------------------------------------------------------------------------------
type CraftingEnvironment
  = CraftingEnvironmentVeryCrude
  | CraftingEnvironmentCrude
  | CraftingEnvironmentBasic
  | CraftingEnvironmentAdvanced
  | CraftingEnvironmentExpert
  | CraftingEnvironmentApex

craftingEnvironment : StrConv CraftingEnvironment
craftingEnvironment =
  let
    to x =
      case x of
        CraftingEnvironmentVeryCrude -> "Very Crude"
        CraftingEnvironmentCrude -> "Crude"
        CraftingEnvironmentBasic -> "Basic"
        CraftingEnvironmentAdvanced -> "Advanced"
        CraftingEnvironmentExpert -> "Expert"
        CraftingEnvironmentApex -> "Apex"
    all = [CraftingEnvironmentVeryCrude, CraftingEnvironmentCrude, CraftingEnvironmentBasic, CraftingEnvironmentAdvanced, CraftingEnvironmentExpert, CraftingEnvironmentApex]
    def = CraftingEnvironmentBasic
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- Sanctification
------------------------------------------------------------------------------------------------------
type Sanctification
  = SanctificationNone
  | SanctificationBasic
  | SanctificationThemed

sanctification : StrConv Sanctification
sanctification =
  let
    to x =
      case x of
        SanctificationNone -> "None"
        SanctificationBasic -> "Basic"
        SanctificationThemed -> "Themed"
    all = [SanctificationNone, SanctificationBasic, SanctificationThemed]
    def = SanctificationNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ToolType
------------------------------------------------------------------------------------------------------
type ToolType
  = ToolTypeNone
  | ToolTypeSubstandard
  | ToolTypeStandard
  | ToolTypeAdvanced
  | ToolTypeMasterwork
  | ToolTypeMythic

toolType : StrConv ToolType
toolType =
  let
    to x =
      case x of
        ToolTypeNone -> "None"
        ToolTypeSubstandard -> "Substandard"
        ToolTypeStandard -> "Standard"
        ToolTypeAdvanced -> "Advanced"
        ToolTypeMasterwork -> "Masterwork"
        ToolTypeMythic -> "Mythic"
    all = [ToolTypeNone, ToolTypeSubstandard, ToolTypeStandard, ToolTypeAdvanced, ToolTypeMasterwork, ToolTypeMythic]
    def = ToolTypeNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- Tool
------------------------------------------------------------------------------------------------------
type alias Tool =
  { toolType : ToolType
  , magical : Bool
  , sanctification : Sanctification
  }

initTool : Tool
initTool =
  { toolType = toolType.def
  , magical = False
  , sanctification = sanctification.def
  }

tooltoolTypeL : Lens Tool ToolType
tooltoolTypeL = Lens .toolType (\x a -> { a | toolType = x } )

tooltoolTypeStrL : Lens Tool String
tooltoolTypeStrL = toStrLens toolType tooltoolTypeL

toolmagicalL : Lens Tool Bool
toolmagicalL = Lens .magical (\x a -> { a | magical = x } )

toolmagicalStrL : Lens Tool String
toolmagicalStrL = toStrLens boolStrConv toolmagicalL

toolsanctificationL : Lens Tool Sanctification
toolsanctificationL = Lens .sanctification (\x a -> { a | sanctification = x } )

toolsanctificationStrL : Lens Tool String
toolsanctificationStrL = toStrLens sanctification toolsanctificationL

------------------------------------------------------------------------------------------------------
-- BaseItemConstruction
------------------------------------------------------------------------------------------------------
type alias BaseItemConstruction =
  { baseItemPrice : Int
  , crafterType : CrafterType
  , craftingEnvironment : CraftingEnvironment
  , environmentAttuned : Bool
  , environmentSanctification : Sanctification
  , additionalCostReduction : Int
  , assistant1 : AssistantType
  , assistant2 : AssistantType
  , assistant3 : AssistantType
  , assistant4 : AssistantType
  , assistant5 : AssistantType
  , tool1 : Tool
  , tool2 : Tool
  , tool3 : Tool
  , tool4 : Tool
  , tool5 : Tool
  , additionalCraftingAssistanceCost : Int
  , miscAdditionalCost : Int
  }

initBaseItemConstruction : BaseItemConstruction
initBaseItemConstruction =
  { baseItemPrice = intStrConv.def
  , crafterType = crafterType.def
  , craftingEnvironment = craftingEnvironment.def
  , environmentAttuned = boolStrConv.def
  , environmentSanctification = sanctification.def
  , additionalCostReduction = intStrConv.def
  , assistant1 = assistantType.def
  , assistant2 = assistantType.def
  , assistant3 = assistantType.def
  , assistant4 = assistantType.def
  , assistant5 = assistantType.def
  , tool1 = initTool
  , tool2 = initTool
  , tool3 = initTool
  , tool4 = initTool
  , tool5 = initTool
  , additionalCraftingAssistanceCost = intStrConv.def
  , miscAdditionalCost = intStrConv.def
  }

baseItemConstructionbaseItemPriceL : Lens BaseItemConstruction Int
baseItemConstructionbaseItemPriceL = Lens .baseItemPrice (\x a -> { a | baseItemPrice = x } )

baseItemConstructionbaseItemPriceStrL : Lens BaseItemConstruction String
baseItemConstructionbaseItemPriceStrL = toStrLens intStrConv baseItemConstructionbaseItemPriceL

baseItemConstructioncrafterTypeL : Lens BaseItemConstruction CrafterType
baseItemConstructioncrafterTypeL = Lens .crafterType (\x a -> { a | crafterType = x } )

baseItemConstructioncrafterTypeStrL : Lens BaseItemConstruction String
baseItemConstructioncrafterTypeStrL = toStrLens crafterType baseItemConstructioncrafterTypeL

baseItemConstructioncraftingEnvironmentL : Lens BaseItemConstruction CraftingEnvironment
baseItemConstructioncraftingEnvironmentL = Lens .craftingEnvironment (\x a -> { a | craftingEnvironment = x } )

baseItemConstructioncraftingEnvironmentStrL : Lens BaseItemConstruction String
baseItemConstructioncraftingEnvironmentStrL = toStrLens craftingEnvironment baseItemConstructioncraftingEnvironmentL

baseItemConstructionenvironmentAttunedL : Lens BaseItemConstruction Bool
baseItemConstructionenvironmentAttunedL = Lens .environmentAttuned (\x a -> { a | environmentAttuned = x } )

baseItemConstructionenvironmentAttunedStrL : Lens BaseItemConstruction String
baseItemConstructionenvironmentAttunedStrL = toStrLens boolStrConv baseItemConstructionenvironmentAttunedL

baseItemConstructionenvironmentSanctificationL : Lens BaseItemConstruction Sanctification
baseItemConstructionenvironmentSanctificationL = Lens .environmentSanctification (\x a -> { a | environmentSanctification = x } )

baseItemConstructionenvironmentSanctificationStrL : Lens BaseItemConstruction String
baseItemConstructionenvironmentSanctificationStrL = toStrLens sanctification baseItemConstructionenvironmentSanctificationL

baseItemConstructionadditionalCostReductionL : Lens BaseItemConstruction Int
baseItemConstructionadditionalCostReductionL = Lens .additionalCostReduction (\x a -> { a | additionalCostReduction = x } )

baseItemConstructionadditionalCostReductionStrL : Lens BaseItemConstruction String
baseItemConstructionadditionalCostReductionStrL = toStrLens intStrConv baseItemConstructionadditionalCostReductionL

baseItemConstructionassistant1L : Lens BaseItemConstruction AssistantType
baseItemConstructionassistant1L = Lens .assistant1 (\x a -> { a | assistant1 = x } )

baseItemConstructionassistant1StrL : Lens BaseItemConstruction String
baseItemConstructionassistant1StrL = toStrLens assistantType baseItemConstructionassistant1L

baseItemConstructionassistant2L : Lens BaseItemConstruction AssistantType
baseItemConstructionassistant2L = Lens .assistant2 (\x a -> { a | assistant2 = x } )

baseItemConstructionassistant2StrL : Lens BaseItemConstruction String
baseItemConstructionassistant2StrL = toStrLens assistantType baseItemConstructionassistant2L

baseItemConstructionassistant3L : Lens BaseItemConstruction AssistantType
baseItemConstructionassistant3L = Lens .assistant3 (\x a -> { a | assistant3 = x } )

baseItemConstructionassistant3StrL : Lens BaseItemConstruction String
baseItemConstructionassistant3StrL = toStrLens assistantType baseItemConstructionassistant3L

baseItemConstructionassistant4L : Lens BaseItemConstruction AssistantType
baseItemConstructionassistant4L = Lens .assistant4 (\x a -> { a | assistant4 = x } )

baseItemConstructionassistant4StrL : Lens BaseItemConstruction String
baseItemConstructionassistant4StrL = toStrLens assistantType baseItemConstructionassistant4L

baseItemConstructionassistant5L : Lens BaseItemConstruction AssistantType
baseItemConstructionassistant5L = Lens .assistant5 (\x a -> { a | assistant5 = x } )

baseItemConstructionassistant5StrL : Lens BaseItemConstruction String
baseItemConstructionassistant5StrL = toStrLens assistantType baseItemConstructionassistant5L

baseItemConstructiontool1L : Lens BaseItemConstruction Tool
baseItemConstructiontool1L = Lens .tool1 (\x a -> { a | tool1 = x } )

baseItemConstructiontool2L : Lens BaseItemConstruction Tool
baseItemConstructiontool2L = Lens .tool2 (\x a -> { a | tool2 = x } )

baseItemConstructiontool3L : Lens BaseItemConstruction Tool
baseItemConstructiontool3L = Lens .tool3 (\x a -> { a | tool3 = x } )

baseItemConstructiontool4L : Lens BaseItemConstruction Tool
baseItemConstructiontool4L = Lens .tool4 (\x a -> { a | tool4 = x } )

baseItemConstructiontool5L : Lens BaseItemConstruction Tool
baseItemConstructiontool5L = Lens .tool5 (\x a -> { a | tool5 = x } )

baseItemConstructionadditionalCraftingAssistanceCostL : Lens BaseItemConstruction Int
baseItemConstructionadditionalCraftingAssistanceCostL = Lens .additionalCraftingAssistanceCost (\x a -> { a | additionalCraftingAssistanceCost = x } )

baseItemConstructionadditionalCraftingAssistanceCostStrL : Lens BaseItemConstruction String
baseItemConstructionadditionalCraftingAssistanceCostStrL = toStrLens intStrConv baseItemConstructionadditionalCraftingAssistanceCostL

baseItemConstructionmiscAdditionalCostL : Lens BaseItemConstruction Int
baseItemConstructionmiscAdditionalCostL = Lens .miscAdditionalCost (\x a -> { a | miscAdditionalCost = x } )

baseItemConstructionmiscAdditionalCostStrL : Lens BaseItemConstruction String
baseItemConstructionmiscAdditionalCostStrL = toStrLens intStrConv baseItemConstructionmiscAdditionalCostL

------------------------------------------------------------------------------------------------------
-- BaseItemImprovement
------------------------------------------------------------------------------------------------------
type alias BaseItemImprovement =
  { itemCategory : ItemCategory
  , currentValue : Int
  , currentStatus : ItemStatus
  , craftingRoll : Int
  , standardCraftingTime : Float
  }

initBaseItemImprovement : BaseItemImprovement
initBaseItemImprovement =
  { itemCategory = itemCategory.def
  , currentValue = intStrConv.def
  , currentStatus = itemStatus.def
  , craftingRoll = intStrConv.def
  , standardCraftingTime = floatStrConv.def
  }

baseItemImprovementitemCategoryL : Lens BaseItemImprovement ItemCategory
baseItemImprovementitemCategoryL = Lens .itemCategory (\x a -> { a | itemCategory = x } )

baseItemImprovementitemCategoryStrL : Lens BaseItemImprovement String
baseItemImprovementitemCategoryStrL = toStrLens itemCategory baseItemImprovementitemCategoryL

baseItemImprovementcurrentValueL : Lens BaseItemImprovement Int
baseItemImprovementcurrentValueL = Lens .currentValue (\x a -> { a | currentValue = x } )

baseItemImprovementcurrentValueStrL : Lens BaseItemImprovement String
baseItemImprovementcurrentValueStrL = toStrLens intStrConv baseItemImprovementcurrentValueL

baseItemImprovementcurrentStatusL : Lens BaseItemImprovement ItemStatus
baseItemImprovementcurrentStatusL = Lens .currentStatus (\x a -> { a | currentStatus = x } )

baseItemImprovementcurrentStatusStrL : Lens BaseItemImprovement String
baseItemImprovementcurrentStatusStrL = toStrLens itemStatus baseItemImprovementcurrentStatusL

baseItemImprovementcraftingRollL : Lens BaseItemImprovement Int
baseItemImprovementcraftingRollL = Lens .craftingRoll (\x a -> { a | craftingRoll = x } )

baseItemImprovementcraftingRollStrL : Lens BaseItemImprovement String
baseItemImprovementcraftingRollStrL = toStrLens intStrConv baseItemImprovementcraftingRollL

baseItemImprovementstandardCraftingTimeL : Lens BaseItemImprovement Float
baseItemImprovementstandardCraftingTimeL = Lens .standardCraftingTime (\x a -> { a | standardCraftingTime = x } )

baseItemImprovementstandardCraftingTimeStrL : Lens BaseItemImprovement String
baseItemImprovementstandardCraftingTimeStrL = toStrLens floatStrConv baseItemImprovementstandardCraftingTimeL

------------------------------------------------------------------------------------------------------
-- ItemCategory
------------------------------------------------------------------------------------------------------
type ItemCategory
  = ItemCategoryWeaponsAndArmor
  | ItemCategoryArtObjects
  | ItemCategoryJeweleryAndGems
  | ItemCategoryClothing
  | ItemCategoryMiscellaneous

itemCategory : StrConv ItemCategory
itemCategory =
  let
    to x =
      case x of
        ItemCategoryWeaponsAndArmor -> "Weapons And Armor"
        ItemCategoryArtObjects -> "Art Objects"
        ItemCategoryJeweleryAndGems -> "Jewelery And Gems"
        ItemCategoryClothing -> "Clothing"
        ItemCategoryMiscellaneous -> "Miscellaneous"
    all = [ItemCategoryWeaponsAndArmor, ItemCategoryArtObjects, ItemCategoryJeweleryAndGems, ItemCategoryClothing, ItemCategoryMiscellaneous]
    def = ItemCategoryWeaponsAndArmor
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ItemStatus
------------------------------------------------------------------------------------------------------
type ItemStatus
  = ItemStatusCrudeOrRaw
  | ItemStatusStandardOrUnworked
  | ItemStatusWorked
  | ItemStatusMasterworked

itemStatus : StrConv ItemStatus
itemStatus =
  let
    to x =
      case x of
        ItemStatusCrudeOrRaw -> "Crude Or Raw"
        ItemStatusStandardOrUnworked -> "Standard Or Unworked"
        ItemStatusWorked -> "Worked"
        ItemStatusMasterworked -> "Masterworked"
    all = [ItemStatusCrudeOrRaw, ItemStatusStandardOrUnworked, ItemStatusWorked, ItemStatusMasterworked]
    def = ItemStatusStandardOrUnworked
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ItemBonusImprovement
------------------------------------------------------------------------------------------------------
type alias ItemBonusImprovement =
  { currentRarity : StartingItemRarity
  , crafterType : CrafterType
  }

initItemBonusImprovement : ItemBonusImprovement
initItemBonusImprovement =
  { currentRarity = startingItemRarity.def
  , crafterType = crafterType.def
  }

itemBonusImprovementcurrentRarityL : Lens ItemBonusImprovement StartingItemRarity
itemBonusImprovementcurrentRarityL = Lens .currentRarity (\x a -> { a | currentRarity = x } )

itemBonusImprovementcurrentRarityStrL : Lens ItemBonusImprovement String
itemBonusImprovementcurrentRarityStrL = toStrLens startingItemRarity itemBonusImprovementcurrentRarityL

itemBonusImprovementcrafterTypeL : Lens ItemBonusImprovement CrafterType
itemBonusImprovementcrafterTypeL = Lens .crafterType (\x a -> { a | crafterType = x } )

itemBonusImprovementcrafterTypeStrL : Lens ItemBonusImprovement String
itemBonusImprovementcrafterTypeStrL = toStrLens crafterType itemBonusImprovementcrafterTypeL

------------------------------------------------------------------------------------------------------
-- StartingItemRarity
------------------------------------------------------------------------------------------------------
type StartingItemRarity
  = StartingItemRarityUncommon
  | StartingItemRarityRare
  | StartingItemRarityVeryRare

startingItemRarity : StrConv StartingItemRarity
startingItemRarity =
  let
    to x =
      case x of
        StartingItemRarityUncommon -> "Uncommon"
        StartingItemRarityRare -> "Rare"
        StartingItemRarityVeryRare -> "Very Rare"
    all = [StartingItemRarityUncommon, StartingItemRarityRare, StartingItemRarityVeryRare]
    def = StartingItemRarityUncommon
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ItemEnchantment
------------------------------------------------------------------------------------------------------
type alias ItemEnchantment =
  { itemRarity : ItemRarity
  , crafterType : CrafterType
  , assistant1 : AssistantType
  , assistant2 : AssistantType
  , assistant3 : AssistantType
  , assistant4 : AssistantType
  , assistant5 : AssistantType
  , magicItemAdept : Bool
  , oneUseItem : Bool
  , mimicASpell : MimicASpell
  , numberOfDifferentSpells : Int
  , accessToIdenticalItem : Bool
  , replicateMagicItem : ReplicateMagicItem
  , component1 : MagicComponent
  , component2 : MagicComponent
  , component3 : MagicComponent
  , component4 : MagicComponent
  , component5 : MagicComponent
  , additionalCost : Int
  }

initItemEnchantment : ItemEnchantment
initItemEnchantment =
  { itemRarity = itemRarity.def
  , crafterType = crafterType.def
  , assistant1 = assistantType.def
  , assistant2 = assistantType.def
  , assistant3 = assistantType.def
  , assistant4 = assistantType.def
  , assistant5 = assistantType.def
  , magicItemAdept = boolStrConv.def
  , oneUseItem = boolStrConv.def
  , mimicASpell = mimicASpell.def
  , numberOfDifferentSpells = intStrConv.def
  , accessToIdenticalItem = boolStrConv.def
  , replicateMagicItem = replicateMagicItem.def
  , component1 = initMagicComponent
  , component2 = initMagicComponent
  , component3 = initMagicComponent
  , component4 = initMagicComponent
  , component5 = initMagicComponent
  , additionalCost = intStrConv.def
  }

itemEnchantmentitemRarityL : Lens ItemEnchantment ItemRarity
itemEnchantmentitemRarityL = Lens .itemRarity (\x a -> { a | itemRarity = x } )

itemEnchantmentitemRarityStrL : Lens ItemEnchantment String
itemEnchantmentitemRarityStrL = toStrLens itemRarity itemEnchantmentitemRarityL

itemEnchantmentcrafterTypeL : Lens ItemEnchantment CrafterType
itemEnchantmentcrafterTypeL = Lens .crafterType (\x a -> { a | crafterType = x } )

itemEnchantmentcrafterTypeStrL : Lens ItemEnchantment String
itemEnchantmentcrafterTypeStrL = toStrLens crafterType itemEnchantmentcrafterTypeL

itemEnchantmentassistant1L : Lens ItemEnchantment AssistantType
itemEnchantmentassistant1L = Lens .assistant1 (\x a -> { a | assistant1 = x } )

itemEnchantmentassistant1StrL : Lens ItemEnchantment String
itemEnchantmentassistant1StrL = toStrLens assistantType itemEnchantmentassistant1L

itemEnchantmentassistant2L : Lens ItemEnchantment AssistantType
itemEnchantmentassistant2L = Lens .assistant2 (\x a -> { a | assistant2 = x } )

itemEnchantmentassistant2StrL : Lens ItemEnchantment String
itemEnchantmentassistant2StrL = toStrLens assistantType itemEnchantmentassistant2L

itemEnchantmentassistant3L : Lens ItemEnchantment AssistantType
itemEnchantmentassistant3L = Lens .assistant3 (\x a -> { a | assistant3 = x } )

itemEnchantmentassistant3StrL : Lens ItemEnchantment String
itemEnchantmentassistant3StrL = toStrLens assistantType itemEnchantmentassistant3L

itemEnchantmentassistant4L : Lens ItemEnchantment AssistantType
itemEnchantmentassistant4L = Lens .assistant4 (\x a -> { a | assistant4 = x } )

itemEnchantmentassistant4StrL : Lens ItemEnchantment String
itemEnchantmentassistant4StrL = toStrLens assistantType itemEnchantmentassistant4L

itemEnchantmentassistant5L : Lens ItemEnchantment AssistantType
itemEnchantmentassistant5L = Lens .assistant5 (\x a -> { a | assistant5 = x } )

itemEnchantmentassistant5StrL : Lens ItemEnchantment String
itemEnchantmentassistant5StrL = toStrLens assistantType itemEnchantmentassistant5L

itemEnchantmentmagicItemAdeptL : Lens ItemEnchantment Bool
itemEnchantmentmagicItemAdeptL = Lens .magicItemAdept (\x a -> { a | magicItemAdept = x } )

itemEnchantmentmagicItemAdeptStrL : Lens ItemEnchantment String
itemEnchantmentmagicItemAdeptStrL = toStrLens boolStrConv itemEnchantmentmagicItemAdeptL

itemEnchantmentoneUseItemL : Lens ItemEnchantment Bool
itemEnchantmentoneUseItemL = Lens .oneUseItem (\x a -> { a | oneUseItem = x } )

itemEnchantmentoneUseItemStrL : Lens ItemEnchantment String
itemEnchantmentoneUseItemStrL = toStrLens boolStrConv itemEnchantmentoneUseItemL

itemEnchantmentmimicASpellL : Lens ItemEnchantment MimicASpell
itemEnchantmentmimicASpellL = Lens .mimicASpell (\x a -> { a | mimicASpell = x } )

itemEnchantmentmimicASpellStrL : Lens ItemEnchantment String
itemEnchantmentmimicASpellStrL = toStrLens mimicASpell itemEnchantmentmimicASpellL

itemEnchantmentnumberOfDifferentSpellsL : Lens ItemEnchantment Int
itemEnchantmentnumberOfDifferentSpellsL = Lens .numberOfDifferentSpells (\x a -> { a | numberOfDifferentSpells = x } )

itemEnchantmentnumberOfDifferentSpellsStrL : Lens ItemEnchantment String
itemEnchantmentnumberOfDifferentSpellsStrL = toStrLens intStrConv itemEnchantmentnumberOfDifferentSpellsL

itemEnchantmentaccessToIdenticalItemL : Lens ItemEnchantment Bool
itemEnchantmentaccessToIdenticalItemL = Lens .accessToIdenticalItem (\x a -> { a | accessToIdenticalItem = x } )

itemEnchantmentaccessToIdenticalItemStrL : Lens ItemEnchantment String
itemEnchantmentaccessToIdenticalItemStrL = toStrLens boolStrConv itemEnchantmentaccessToIdenticalItemL

itemEnchantmentreplicateMagicItemL : Lens ItemEnchantment ReplicateMagicItem
itemEnchantmentreplicateMagicItemL = Lens .replicateMagicItem (\x a -> { a | replicateMagicItem = x } )

itemEnchantmentreplicateMagicItemStrL : Lens ItemEnchantment String
itemEnchantmentreplicateMagicItemStrL = toStrLens replicateMagicItem itemEnchantmentreplicateMagicItemL

itemEnchantmentcomponent1L : Lens ItemEnchantment MagicComponent
itemEnchantmentcomponent1L = Lens .component1 (\x a -> { a | component1 = x } )

itemEnchantmentcomponent2L : Lens ItemEnchantment MagicComponent
itemEnchantmentcomponent2L = Lens .component2 (\x a -> { a | component2 = x } )

itemEnchantmentcomponent3L : Lens ItemEnchantment MagicComponent
itemEnchantmentcomponent3L = Lens .component3 (\x a -> { a | component3 = x } )

itemEnchantmentcomponent4L : Lens ItemEnchantment MagicComponent
itemEnchantmentcomponent4L = Lens .component4 (\x a -> { a | component4 = x } )

itemEnchantmentcomponent5L : Lens ItemEnchantment MagicComponent
itemEnchantmentcomponent5L = Lens .component5 (\x a -> { a | component5 = x } )

itemEnchantmentadditionalCostL : Lens ItemEnchantment Int
itemEnchantmentadditionalCostL = Lens .additionalCost (\x a -> { a | additionalCost = x } )

itemEnchantmentadditionalCostStrL : Lens ItemEnchantment String
itemEnchantmentadditionalCostStrL = toStrLens intStrConv itemEnchantmentadditionalCostL

------------------------------------------------------------------------------------------------------
-- MimicASpell
------------------------------------------------------------------------------------------------------
type MimicASpell
  = MimicASpellNo
  | MimicASpellYesbutcrafterhasnoaccesstoit
  | MimicASpellCast1timeaweek
  | MimicASpellCast2timesaweek
  | MimicASpellCast3timesaweek
  | MimicASpellCast4timesaweek
  | MimicASpellCast5timesaweek
  | MimicASpellCast6timesaweek
  | MimicASpellCast7timesaweek

mimicASpell : StrConv MimicASpell
mimicASpell =
  let
    to x =
      case x of
        MimicASpellNo -> "No"
        MimicASpellYesbutcrafterhasnoaccesstoit -> "Yes but crafter has no access to it"
        MimicASpellCast1timeaweek -> "Cast 1 time a week"
        MimicASpellCast2timesaweek -> "Cast 2 times a week"
        MimicASpellCast3timesaweek -> "Cast 3 times a week"
        MimicASpellCast4timesaweek -> "Cast 4 times a week"
        MimicASpellCast5timesaweek -> "Cast 5 times a week"
        MimicASpellCast6timesaweek -> "Cast 6 times a week"
        MimicASpellCast7timesaweek -> "Cast 7 times a week"
    all = [MimicASpellNo, MimicASpellYesbutcrafterhasnoaccesstoit, MimicASpellCast1timeaweek, MimicASpellCast2timesaweek, MimicASpellCast3timesaweek, MimicASpellCast4timesaweek, MimicASpellCast5timesaweek, MimicASpellCast6timesaweek, MimicASpellCast7timesaweek]
    def = MimicASpellNo
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ReplicateMagicItem
------------------------------------------------------------------------------------------------------
type ReplicateMagicItem
  = ReplicateMagicItemNo
  | ReplicateMagicItemYesbutthecrafterhasnoaccess
  | ReplicateMagicItemYesbutitisnotactive
  | ReplicateMagicItemYesanditisactive

replicateMagicItem : StrConv ReplicateMagicItem
replicateMagicItem =
  let
    to x =
      case x of
        ReplicateMagicItemNo -> "No"
        ReplicateMagicItemYesbutthecrafterhasnoaccess -> "Yes but the crafter has no access"
        ReplicateMagicItemYesbutitisnotactive -> "Yes but it is not active"
        ReplicateMagicItemYesanditisactive -> "Yes and it is active"
    all = [ReplicateMagicItemNo, ReplicateMagicItemYesbutthecrafterhasnoaccess, ReplicateMagicItemYesbutitisnotactive, ReplicateMagicItemYesanditisactive]
    def = ReplicateMagicItemNo
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- MagicComponent
------------------------------------------------------------------------------------------------------
type alias MagicComponent =
  { componentType : ComponentItemRarity
  , alignment : ComponentAlignment
  }

initMagicComponent : MagicComponent
initMagicComponent =
  { componentType = componentItemRarity.def
  , alignment = componentAlignment.def
  }

magicComponentcomponentTypeL : Lens MagicComponent ComponentItemRarity
magicComponentcomponentTypeL = Lens .componentType (\x a -> { a | componentType = x } )

magicComponentcomponentTypeStrL : Lens MagicComponent String
magicComponentcomponentTypeStrL = toStrLens componentItemRarity magicComponentcomponentTypeL

magicComponentalignmentL : Lens MagicComponent ComponentAlignment
magicComponentalignmentL = Lens .alignment (\x a -> { a | alignment = x } )

magicComponentalignmentStrL : Lens MagicComponent String
magicComponentalignmentStrL = toStrLens componentAlignment magicComponentalignmentL

------------------------------------------------------------------------------------------------------
-- ComponentAlignment
------------------------------------------------------------------------------------------------------
type ComponentAlignment
  = ComponentAlignmentNone
  | ComponentAlignmentThematic
  | ComponentAlignmentMagical
  | ComponentAlignmentElemental
  | ComponentAlignmentDraconic
  | ComponentAlignmentDivine
  | ComponentAlignmentUnique

componentAlignment : StrConv ComponentAlignment
componentAlignment =
  let
    to x =
      case x of
        ComponentAlignmentNone -> "None"
        ComponentAlignmentThematic -> "Thematic"
        ComponentAlignmentMagical -> "Magical"
        ComponentAlignmentElemental -> "Elemental"
        ComponentAlignmentDraconic -> "Draconic"
        ComponentAlignmentDivine -> "Divine"
        ComponentAlignmentUnique -> "Unique"
    all = [ComponentAlignmentNone, ComponentAlignmentThematic, ComponentAlignmentMagical, ComponentAlignmentElemental, ComponentAlignmentDraconic, ComponentAlignmentDivine, ComponentAlignmentUnique]
    def = ComponentAlignmentNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

------------------------------------------------------------------------------------------------------
-- ComponentItemRarity
------------------------------------------------------------------------------------------------------
type ComponentItemRarity
  = ComponentItemRarityNone
  | ComponentItemRarityCommon
  | ComponentItemRarityUncommon
  | ComponentItemRarityRare
  | ComponentItemRarityVeryRare
  | ComponentItemRarityLegendary

componentItemRarity : StrConv ComponentItemRarity
componentItemRarity =
  let
    to x =
      case x of
        ComponentItemRarityNone -> "None"
        ComponentItemRarityCommon -> "Common"
        ComponentItemRarityUncommon -> "Uncommon"
        ComponentItemRarityRare -> "Rare"
        ComponentItemRarityVeryRare -> "Very Rare"
        ComponentItemRarityLegendary -> "Legendary"
    all = [ComponentItemRarityNone, ComponentItemRarityCommon, ComponentItemRarityUncommon, ComponentItemRarityRare, ComponentItemRarityVeryRare, ComponentItemRarityLegendary]
    def = ComponentItemRarityNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

