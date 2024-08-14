module Model exposing (..)

import Monocle.Lens exposing (..)
import StrConv exposing (..)

------------------------------------------------------------------------------------------------------
-- Model
------------------------------------------------------------------------------------------------------
type alias Model =
  { currentTab : TabName
  , workingConditions : WorkingConditions
  , baseItemConstruction : BaseItemConstruction
  , baseItemImprovement : BaseItemImprovement
  , itemEnchantment : ItemEnchantment
  , itemBonusImprovement : ItemBonusImprovement
  }

initModel : Model
initModel =
  { currentTab = TabNameBaseItemConstruction
  , workingConditions = initWorkingConditions
  , baseItemConstruction = initBaseItemConstruction
  , baseItemImprovement = initBaseItemImprovement
  , itemEnchantment = initItemEnchantment
  , itemBonusImprovement = initItemBonusImprovement
  }

currentTabL : Lens Model TabName
currentTabL = Lens .currentTab (\x a -> { a | currentTab = x } )

currentTabStrL : Lens Model String
currentTabStrL = toStrLens tabName currentTabL

workingConditionsL : Lens Model WorkingConditions
workingConditionsL = Lens .workingConditions (\x a -> { a | workingConditions = x } )

baseItemConstructionL : Lens Model BaseItemConstruction
baseItemConstructionL = Lens .baseItemConstruction (\x a -> { a | baseItemConstruction = x } )

baseItemImprovementL : Lens Model BaseItemImprovement
baseItemImprovementL = Lens .baseItemImprovement (\x a -> { a | baseItemImprovement = x } )

itemEnchantmentL : Lens Model ItemEnchantment
itemEnchantmentL = Lens .itemEnchantment (\x a -> { a | itemEnchantment = x } )

itemBonusImprovementL : Lens Model ItemBonusImprovement
itemBonusImprovementL = Lens .itemBonusImprovement (\x a -> { a | itemBonusImprovement = x } )

------------------------------------------------------------------------------------------------------
-- Tool
------------------------------------------------------------------------------------------------------
type alias Tool =
  { toolType : ToolType
  , magical : MagicBonus
  , sanctification : Sanctification
  }

initTool : Tool
initTool =
  { toolType = toolType.def
  , magical = magicBonus.def
  , sanctification = sanctification.def
  }

toolTypeL : Lens Tool ToolType
toolTypeL = Lens .toolType (\x a -> { a | toolType = x } )

toolTypeStrL : Lens Tool String
toolTypeStrL = toStrLens toolType toolTypeL

magicalL : Lens Tool MagicBonus
magicalL = Lens .magical (\x a -> { a | magical = x } )

magicalStrL : Lens Tool String
magicalStrL = toStrLens magicBonus magicalL

sanctificationL : Lens Tool Sanctification
sanctificationL = Lens .sanctification (\x a -> { a | sanctification = x } )

sanctificationStrL : Lens Tool String
sanctificationStrL = toStrLens sanctification sanctificationL

------------------------------------------------------------------------------------------------------
-- WorkingConditions
------------------------------------------------------------------------------------------------------
type alias WorkingConditions =
  { crafterType : CrafterType
  , magicItemAdept : Bool
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
  }

initWorkingConditions : WorkingConditions
initWorkingConditions =
  { crafterType = crafterType.def
  , magicItemAdept = boolStrConv.def
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
  }

crafterTypeL : Lens WorkingConditions CrafterType
crafterTypeL = Lens .crafterType (\x a -> { a | crafterType = x } )

crafterTypeStrL : Lens WorkingConditions String
crafterTypeStrL = toStrLens crafterType crafterTypeL

magicItemAdeptL : Lens WorkingConditions Bool
magicItemAdeptL = Lens .magicItemAdept (\x a -> { a | magicItemAdept = x } )

magicItemAdeptStrL : Lens WorkingConditions String
magicItemAdeptStrL = toStrLens boolStrConv magicItemAdeptL

craftingEnvironmentL : Lens WorkingConditions CraftingEnvironment
craftingEnvironmentL = Lens .craftingEnvironment (\x a -> { a | craftingEnvironment = x } )

craftingEnvironmentStrL : Lens WorkingConditions String
craftingEnvironmentStrL = toStrLens craftingEnvironment craftingEnvironmentL

environmentAttunedL : Lens WorkingConditions Bool
environmentAttunedL = Lens .environmentAttuned (\x a -> { a | environmentAttuned = x } )

environmentAttunedStrL : Lens WorkingConditions String
environmentAttunedStrL = toStrLens boolStrConv environmentAttunedL

environmentSanctificationL : Lens WorkingConditions Sanctification
environmentSanctificationL = Lens .environmentSanctification (\x a -> { a | environmentSanctification = x } )

environmentSanctificationStrL : Lens WorkingConditions String
environmentSanctificationStrL = toStrLens sanctification environmentSanctificationL

additionalCostReductionL : Lens WorkingConditions Int
additionalCostReductionL = Lens .additionalCostReduction (\x a -> { a | additionalCostReduction = x } )

additionalCostReductionStrL : Lens WorkingConditions String
additionalCostReductionStrL = toStrLens intStrConv additionalCostReductionL

assistant1L : Lens WorkingConditions AssistantType
assistant1L = Lens .assistant1 (\x a -> { a | assistant1 = x } )

assistant1StrL : Lens WorkingConditions String
assistant1StrL = toStrLens assistantType assistant1L

assistant2L : Lens WorkingConditions AssistantType
assistant2L = Lens .assistant2 (\x a -> { a | assistant2 = x } )

assistant2StrL : Lens WorkingConditions String
assistant2StrL = toStrLens assistantType assistant2L

assistant3L : Lens WorkingConditions AssistantType
assistant3L = Lens .assistant3 (\x a -> { a | assistant3 = x } )

assistant3StrL : Lens WorkingConditions String
assistant3StrL = toStrLens assistantType assistant3L

assistant4L : Lens WorkingConditions AssistantType
assistant4L = Lens .assistant4 (\x a -> { a | assistant4 = x } )

assistant4StrL : Lens WorkingConditions String
assistant4StrL = toStrLens assistantType assistant4L

assistant5L : Lens WorkingConditions AssistantType
assistant5L = Lens .assistant5 (\x a -> { a | assistant5 = x } )

assistant5StrL : Lens WorkingConditions String
assistant5StrL = toStrLens assistantType assistant5L

tool1L : Lens WorkingConditions Tool
tool1L = Lens .tool1 (\x a -> { a | tool1 = x } )

tool2L : Lens WorkingConditions Tool
tool2L = Lens .tool2 (\x a -> { a | tool2 = x } )

tool3L : Lens WorkingConditions Tool
tool3L = Lens .tool3 (\x a -> { a | tool3 = x } )

tool4L : Lens WorkingConditions Tool
tool4L = Lens .tool4 (\x a -> { a | tool4 = x } )

tool5L : Lens WorkingConditions Tool
tool5L = Lens .tool5 (\x a -> { a | tool5 = x } )

------------------------------------------------------------------------------------------------------
-- BaseItemConstruction
------------------------------------------------------------------------------------------------------
type alias BaseItemConstruction =
  { baseItemPrice : Int
  , additionalCraftingAssistanceCost : Int
  , miscAdditionalCost : Int
  }

initBaseItemConstruction : BaseItemConstruction
initBaseItemConstruction =
  { baseItemPrice = intStrConv.def
  , additionalCraftingAssistanceCost = intStrConv.def
  , miscAdditionalCost = intStrConv.def
  }

baseItemPriceL : Lens BaseItemConstruction Int
baseItemPriceL = Lens .baseItemPrice (\x a -> { a | baseItemPrice = x } )

baseItemPriceStrL : Lens BaseItemConstruction String
baseItemPriceStrL = toStrLens intStrConv baseItemPriceL

additionalCraftingAssistanceCostL : Lens BaseItemConstruction Int
additionalCraftingAssistanceCostL = Lens .additionalCraftingAssistanceCost (\x a -> { a | additionalCraftingAssistanceCost = x } )

additionalCraftingAssistanceCostStrL : Lens BaseItemConstruction String
additionalCraftingAssistanceCostStrL = toStrLens intStrConv additionalCraftingAssistanceCostL

miscAdditionalCostL : Lens BaseItemConstruction Int
miscAdditionalCostL = Lens .miscAdditionalCost (\x a -> { a | miscAdditionalCost = x } )

miscAdditionalCostStrL : Lens BaseItemConstruction String
miscAdditionalCostStrL = toStrLens intStrConv miscAdditionalCostL

------------------------------------------------------------------------------------------------------
-- BaseItemImprovement
------------------------------------------------------------------------------------------------------
type alias BaseItemImprovement =
  { itemCategory : ItemCategory
  , currentValue : Int
  , currentStatus : ItemStatus
  , craftingRoll : Int
  }

initBaseItemImprovement : BaseItemImprovement
initBaseItemImprovement =
  { itemCategory = itemCategory.def
  , currentValue = intStrConv.def
  , currentStatus = itemStatus.def
  , craftingRoll = intStrConv.def
  }

itemCategoryL : Lens BaseItemImprovement ItemCategory
itemCategoryL = Lens .itemCategory (\x a -> { a | itemCategory = x } )

itemCategoryStrL : Lens BaseItemImprovement String
itemCategoryStrL = toStrLens itemCategory itemCategoryL

currentValueL : Lens BaseItemImprovement Int
currentValueL = Lens .currentValue (\x a -> { a | currentValue = x } )

currentValueStrL : Lens BaseItemImprovement String
currentValueStrL = toStrLens intStrConv currentValueL

currentStatusL : Lens BaseItemImprovement ItemStatus
currentStatusL = Lens .currentStatus (\x a -> { a | currentStatus = x } )

currentStatusStrL : Lens BaseItemImprovement String
currentStatusStrL = toStrLens itemStatus currentStatusL

craftingRollL : Lens BaseItemImprovement Int
craftingRollL = Lens .craftingRoll (\x a -> { a | craftingRoll = x } )

craftingRollStrL : Lens BaseItemImprovement String
craftingRollStrL = toStrLens intStrConv craftingRollL

------------------------------------------------------------------------------------------------------
-- ItemBonusImprovement
------------------------------------------------------------------------------------------------------
type alias ItemBonusImprovement =
  { currentRarity : StartingItemRarity
  }

initItemBonusImprovement : ItemBonusImprovement
initItemBonusImprovement =
  { currentRarity = startingItemRarity.def
  }

currentRarityL : Lens ItemBonusImprovement StartingItemRarity
currentRarityL = Lens .currentRarity (\x a -> { a | currentRarity = x } )

currentRarityStrL : Lens ItemBonusImprovement String
currentRarityStrL = toStrLens startingItemRarity currentRarityL

------------------------------------------------------------------------------------------------------
-- ItemEnchantment
------------------------------------------------------------------------------------------------------
type alias ItemEnchantment =
  { itemRarity : ItemRarity
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

itemRarityL : Lens ItemEnchantment ItemRarity
itemRarityL = Lens .itemRarity (\x a -> { a | itemRarity = x } )

itemRarityStrL : Lens ItemEnchantment String
itemRarityStrL = toStrLens itemRarity itemRarityL

oneUseItemL : Lens ItemEnchantment Bool
oneUseItemL = Lens .oneUseItem (\x a -> { a | oneUseItem = x } )

oneUseItemStrL : Lens ItemEnchantment String
oneUseItemStrL = toStrLens boolStrConv oneUseItemL

mimicASpellL : Lens ItemEnchantment MimicASpell
mimicASpellL = Lens .mimicASpell (\x a -> { a | mimicASpell = x } )

mimicASpellStrL : Lens ItemEnchantment String
mimicASpellStrL = toStrLens mimicASpell mimicASpellL

numberOfDifferentSpellsL : Lens ItemEnchantment Int
numberOfDifferentSpellsL = Lens .numberOfDifferentSpells (\x a -> { a | numberOfDifferentSpells = x } )

numberOfDifferentSpellsStrL : Lens ItemEnchantment String
numberOfDifferentSpellsStrL = toStrLens intStrConv numberOfDifferentSpellsL

accessToIdenticalItemL : Lens ItemEnchantment Bool
accessToIdenticalItemL = Lens .accessToIdenticalItem (\x a -> { a | accessToIdenticalItem = x } )

accessToIdenticalItemStrL : Lens ItemEnchantment String
accessToIdenticalItemStrL = toStrLens boolStrConv accessToIdenticalItemL

replicateMagicItemL : Lens ItemEnchantment ReplicateMagicItem
replicateMagicItemL = Lens .replicateMagicItem (\x a -> { a | replicateMagicItem = x } )

replicateMagicItemStrL : Lens ItemEnchantment String
replicateMagicItemStrL = toStrLens replicateMagicItem replicateMagicItemL

component1L : Lens ItemEnchantment MagicComponent
component1L = Lens .component1 (\x a -> { a | component1 = x } )

component2L : Lens ItemEnchantment MagicComponent
component2L = Lens .component2 (\x a -> { a | component2 = x } )

component3L : Lens ItemEnchantment MagicComponent
component3L = Lens .component3 (\x a -> { a | component3 = x } )

component4L : Lens ItemEnchantment MagicComponent
component4L = Lens .component4 (\x a -> { a | component4 = x } )

component5L : Lens ItemEnchantment MagicComponent
component5L = Lens .component5 (\x a -> { a | component5 = x } )

additionalCostL : Lens ItemEnchantment Int
additionalCostL = Lens .additionalCost (\x a -> { a | additionalCost = x } )

additionalCostStrL : Lens ItemEnchantment String
additionalCostStrL = toStrLens intStrConv additionalCostL

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

componentTypeL : Lens MagicComponent ComponentItemRarity
componentTypeL = Lens .componentType (\x a -> { a | componentType = x } )

componentTypeStrL : Lens MagicComponent String
componentTypeStrL = toStrLens componentItemRarity componentTypeL

alignmentL : Lens MagicComponent ComponentAlignment
alignmentL = Lens .alignment (\x a -> { a | alignment = x } )

alignmentStrL : Lens MagicComponent String
alignmentStrL = toStrLens componentAlignment alignmentL

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

------------------------------------------------------------------------------------------------------
-- MagicBonus
------------------------------------------------------------------------------------------------------
type MagicBonus
  = MagicBonusNone
  | MagicBonusPlus1
  | MagicBonusPlus2
  | MagicBonusPlus3

magicBonus : StrConv MagicBonus
magicBonus =
  let
    to x =
      case x of
        MagicBonusNone -> "None"
        MagicBonusPlus1 -> "Plus 1"
        MagicBonusPlus2 -> "Plus 2"
        MagicBonusPlus3 -> "Plus 3"
    all = [MagicBonusNone, MagicBonusPlus1, MagicBonusPlus2, MagicBonusPlus3]
    def = MagicBonusNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

