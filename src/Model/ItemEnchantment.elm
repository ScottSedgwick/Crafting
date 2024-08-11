module Model.ItemEnchantment exposing (..)

import Model.Shared exposing (..)
import Monocle.Lens exposing (..)
import Utils exposing (..)

type alias ItemEnchantment =
  { itemRarity_ : ItemRarity
  , crafterType_ : CrafterType
  , assistant1_ : AssistantType
  , assistant2_ : AssistantType
  , assistant3_ : AssistantType
  , assistant4_ : AssistantType
  , assistant5_ : AssistantType
  , magicItemAdept_ : Bool
  , oneUseItem_ : Bool
  , mimicASpell_ : MimicASpell
  , numberOfDifferentSpells_ : Int
  , accessToIdenticalItem_ : Bool
  , replicateMagicItem_ : ReplicateMagicItem
  , component1_ : MagicComponent
  , component2_ : MagicComponent
  , component3_ : MagicComponent
  , component4_ : MagicComponent
  , component5_ : MagicComponent
  , additionalCost_ : Int
  }

initItemEnchantment : ItemEnchantment
initItemEnchantment =
  { itemRarity_ = ItemRarityCommon
  , crafterType_ = CrafterTypePlayerCharacter
  , assistant1_ = AssistantTypeNone
  , assistant2_ = AssistantTypeNone
  , assistant3_ = AssistantTypeNone
  , assistant4_ = AssistantTypeNone
  , assistant5_ = AssistantTypeNone
  , magicItemAdept_ = False
  , oneUseItem_ = False
  , mimicASpell_ = MimicASpellNo
  , numberOfDifferentSpells_ = 0
  , accessToIdenticalItem_ = False
  , replicateMagicItem_ = ReplicateMagicItemNo
  , component1_ = initComponent
  , component2_ = initComponent
  , component3_ = initComponent
  , component4_ = initComponent
  , component5_ = initComponent
  , additionalCost_ = 0
  }

itemRarityL : Lens ItemEnchantment ItemRarity
itemRarityL = Lens .itemRarity_ (\x a -> { a | itemRarity_ = x } )

crafterTypeL : Lens ItemEnchantment CrafterType
crafterTypeL = Lens .crafterType_ (\x a -> { a | crafterType_ = x } )

assistant1L : Lens ItemEnchantment AssistantType
assistant1L = Lens .assistant1_ (\x a -> { a | assistant1_ = x})

assistant2L : Lens ItemEnchantment AssistantType
assistant2L = Lens .assistant2_ (\x a -> { a | assistant2_ = x})

assistant3L : Lens ItemEnchantment AssistantType
assistant3L = Lens .assistant3_ (\x a -> { a | assistant3_ = x})

assistant4L : Lens ItemEnchantment AssistantType
assistant4L = Lens .assistant4_ (\x a -> { a | assistant4_ = x})

assistant5L : Lens ItemEnchantment AssistantType
assistant5L = Lens .assistant5_ (\x a -> { a | assistant5_ = x})

magicItemAdeptL : Lens ItemEnchantment Bool
magicItemAdeptL = Lens .magicItemAdept_ (\x a -> { a | magicItemAdept_ = x } )

oneUseItemL : Lens ItemEnchantment Bool
oneUseItemL = Lens .oneUseItem_ (\x a -> { a | oneUseItem_ = x } )

mimicASpellL : Lens ItemEnchantment MimicASpell
mimicASpellL = Lens .mimicASpell_ (\x a -> { a | mimicASpell_ = x } )

numberOfDifferentSpellsL : Lens ItemEnchantment Int
numberOfDifferentSpellsL = Lens .numberOfDifferentSpells_ (\x a -> { a | numberOfDifferentSpells_ = x } )

accessToIdenticalItemL : Lens ItemEnchantment Bool
accessToIdenticalItemL = Lens .accessToIdenticalItem_ (\x a -> { a | accessToIdenticalItem_ = x } )

replicateMagicItemL : Lens ItemEnchantment ReplicateMagicItem
replicateMagicItemL = Lens .replicateMagicItem_ (\x a -> { a | replicateMagicItem_ = x } )

component1L : Lens ItemEnchantment MagicComponent
component1L = Lens .component1_ (\x a -> { a | component1_ = x } )

component2L : Lens ItemEnchantment MagicComponent
component2L = Lens .component2_ (\x a -> { a | component2_ = x } )

component3L : Lens ItemEnchantment MagicComponent
component3L = Lens .component3_ (\x a -> { a | component3_ = x } )

component4L : Lens ItemEnchantment MagicComponent
component4L = Lens .component4_ (\x a -> { a | component4_ = x } )

component5L : Lens ItemEnchantment MagicComponent
component5L = Lens .component5_ (\x a -> { a | component5_ = x } )

additionalCostL : Lens ItemEnchantment Int
additionalCostL = Lens .additionalCost_ (\x a -> { a | additionalCost_ = x } )

type MimicASpell
  = MimicASpellNo
  | MimicASpellYesButNoAccess
  | MimicASpellYesAndWeeklyCast1
  | MimicASpellYesAndWeeklyCast2
  | MimicASpellYesAndWeeklyCast3
  | MimicASpellYesAndWeeklyCast4
  | MimicASpellYesAndWeeklyCast5
  | MimicASpellYesAndWeeklyCast6
  | MimicASpellYesAndWeeklyCast7

mimicASpell : StrConv MimicASpell
mimicASpell =
  let
    to e =
      case e of
        MimicASpellNo                -> "No"
        MimicASpellYesButNoAccess    -> "Yes, but crafter has no access to it"
        MimicASpellYesAndWeeklyCast1 -> "Yes, cast 1 time a week"
        MimicASpellYesAndWeeklyCast2 -> "Yes, cast 2 times a week"
        MimicASpellYesAndWeeklyCast3 -> "Yes, cast 3 times a week"
        MimicASpellYesAndWeeklyCast4 -> "Yes, cast 4 times a week"
        MimicASpellYesAndWeeklyCast5 -> "Yes, cast 5 times a week"
        MimicASpellYesAndWeeklyCast6 -> "Yes, cast 6 times a week"
        MimicASpellYesAndWeeklyCast7 -> "Yes, cast 7 times a week"
    all = [ MimicASpellNo, MimicASpellYesButNoAccess, MimicASpellYesAndWeeklyCast1, MimicASpellYesAndWeeklyCast2, MimicASpellYesAndWeeklyCast3, MimicASpellYesAndWeeklyCast4, MimicASpellYesAndWeeklyCast5, MimicASpellYesAndWeeklyCast6, MimicASpellYesAndWeeklyCast7]
    def = MimicASpellNo
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

type ReplicateMagicItem
  = ReplicateMagicItemNo
  | ReplicateMagicItemYesButNotKnown
  | ReplicateMagicItemYesButNotActive
  | ReplicateMagicItemYesAndActive

replicateMagicItem : StrConv ReplicateMagicItem
replicateMagicItem =
  let
    to e =
      case e of
        ReplicateMagicItemNo              -> "No"
        ReplicateMagicItemYesButNotKnown  -> "Yes, but the crafter has no access"
        ReplicateMagicItemYesButNotActive -> "Yes, but it is not active"
        ReplicateMagicItemYesAndActive    -> "Yes, and it is active"
    all = [ ReplicateMagicItemNo, ReplicateMagicItemYesButNotKnown, ReplicateMagicItemYesButNotActive, ReplicateMagicItemYesAndActive ]
    def = ReplicateMagicItemNo
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

type alias MagicComponent =
  { componentType_ : ComponentItemRarity
  , alignment_ : ComponentAlignment
  }

componentTypeL : Lens MagicComponent ComponentItemRarity
componentTypeL = Lens .componentType_ (\x a -> { a | componentType_ = x } )

componentAlignmentL : Lens MagicComponent ComponentAlignment
componentAlignmentL = Lens .alignment_ (\x a -> { a | alignment_ = x } )

initComponent : MagicComponent
initComponent =
  { componentType_ = ComponentItemRarityNone
  , alignment_ = ComponentAlignmentNone
  }

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
    to e =
      case e of
        ComponentAlignmentNone      -> "None"
        ComponentAlignmentThematic  -> "Thematic (x1.3)"
        ComponentAlignmentMagical   -> "Magical (x1.4)"
        ComponentAlignmentElemental -> "Elemental (x1.5)"
        ComponentAlignmentDraconic  -> "Draconic (x1.7)"
        ComponentAlignmentDivine    -> "Divine (x1.9)"
        ComponentAlignmentUnique    -> "Unique (x4)"
    all = [ ComponentAlignmentNone, ComponentAlignmentThematic, ComponentAlignmentMagical, ComponentAlignmentElemental, ComponentAlignmentDraconic, ComponentAlignmentDivine, ComponentAlignmentUnique ]
    def = ComponentAlignmentNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

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
    to e =
      case e of
        ComponentItemRarityNone      -> "None"
        ComponentItemRarityCommon    -> "Common"
        ComponentItemRarityUncommon  -> "Uncommon"
        ComponentItemRarityRare      -> "Rare"
        ComponentItemRarityVeryRare  -> "Very Rare"
        ComponentItemRarityLegendary -> "Legendary"
    all = [ ComponentItemRarityNone, ComponentItemRarityCommon, ComponentItemRarityUncommon, ComponentItemRarityRare, ComponentItemRarityVeryRare, ComponentItemRarityLegendary ]
    def = ComponentItemRarityNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

baseEnchantmentCost : ItemEnchantment -> Float
baseEnchantmentCost model =
  let
    base = case model.itemRarity_ of 
                    ItemRarityCommon    -> 50
                    ItemRarityUncommon  -> 200
                    ItemRarityRare      -> 2000
                    ItemRarityVeryRare  -> 20000
                    ItemRarityLegendary -> 100000
    mult1 = if applyMagicItemAdept model then 0.5 else 1.0
    mult2 = if model.oneUseItem_ then 0.5 else 1.0
    mult3 = if model.accessToIdenticalItem_ then 0.9 else 1.0
    mult4 = case model.replicateMagicItem_ of
              ReplicateMagicItemNo              -> 1.0
              ReplicateMagicItemYesButNotKnown  -> 1.0
              ReplicateMagicItemYesButNotActive -> 0.9
              ReplicateMagicItemYesAndActive    -> 0.75
  in
    base * mult1 * mult2 * mult3 * mult4

baseEnchantmentTimeWeeks : ItemEnchantment -> Float
baseEnchantmentTimeWeeks model =
  let 
    base = case model.itemRarity_ of 
            ItemRarityCommon    -> 1
            ItemRarityUncommon  -> 2
            ItemRarityRare      -> 10
            ItemRarityVeryRare  -> 25
            ItemRarityLegendary -> 50
    mult1 = if applyMagicItemAdept model then 0.25 else 1.0
    mult2 = if model.oneUseItem_ then 0.5 else 1.0
  in
    base * mult1 * mult2 

baseWeekMultiplier : ItemEnchantment -> Int
baseWeekMultiplier model =
  let
    val = case model.mimicASpell_ of
            MimicASpellNo                -> 56
            MimicASpellYesButNoAccess    -> 56
            MimicASpellYesAndWeeklyCast1 -> 56 - model.numberOfDifferentSpells_
            MimicASpellYesAndWeeklyCast2 -> 56 - (model.numberOfDifferentSpells_ * 2)
            MimicASpellYesAndWeeklyCast3 -> 56 - (model.numberOfDifferentSpells_ * 3)
            MimicASpellYesAndWeeklyCast4 -> 56 - (model.numberOfDifferentSpells_ * 4)
            MimicASpellYesAndWeeklyCast5 -> 56 - (model.numberOfDifferentSpells_ * 5)
            MimicASpellYesAndWeeklyCast6 -> 56 - (model.numberOfDifferentSpells_ * 6)
            MimicASpellYesAndWeeklyCast7 -> 56 - (model.numberOfDifferentSpells_ * 7)
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
assistanceTotal model = List.sum (List.map (\l -> assistantInput (l.get model)) [assistant1L, assistant2L, assistant3L, assistant4L, assistant5L])

totalCrafterInput : ItemEnchantment -> Int
totalCrafterInput model = crafterInput model.crafterType_ + assistanceTotal model

commonOrUncommon : ItemEnchantment -> Bool
commonOrUncommon model = (model.itemRarity_ == ItemRarityCommon) || (model.itemRarity_ == ItemRarityUncommon)

applyMagicItemAdept : ItemEnchantment -> Bool
applyMagicItemAdept model = commonOrUncommon model && model.magicItemAdept_

componentTimeReductionHours : MagicComponent -> Float
componentTimeReductionHours mc =
  case mc.componentType_ of
    ComponentItemRarityNone       -> 0
    ComponentItemRarityCommon     -> 9
    ComponentItemRarityUncommon   -> 18
    ComponentItemRarityRare       -> 3 * 56
    ComponentItemRarityVeryRare   -> 8 * 56
    ComponentItemRarityLegendary  -> 10 * 56
      
alignmentMultiplier : MagicComponent -> Float
alignmentMultiplier mc =
  case mc.alignment_ of
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
  List.sum (List.map (\x -> componentHourReduction (x.get model)) [component1L, component2L, component3L, component4L, component5L])

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
assistantCostTotal model = List.sum (List.map (\x -> assistantCost (x.get model) (totalEnchantmentTimeWeeks model)) [assistant1L, assistant2L, assistant3L, assistant4L, assistant5L])

totalEnchantmentCost : ItemEnchantment -> Float
totalEnchantmentCost model = baseEnchantmentCost model + assistantCostTotal model + toFloat model.additionalCost_