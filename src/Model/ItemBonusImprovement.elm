module Model.ItemBonusImprovement exposing (..)

import Model.Shared exposing (..)
import Monocle.Lens exposing (..)
import Utils exposing (..)

type alias ItemBonusImprovement =
  { currentRarity : StartingItemRarity
  , crafterType : CrafterType
  }

initItemBonusImprovement : ItemBonusImprovement
initItemBonusImprovement =
  { currentRarity = StartingItemRarityUncommon
  , crafterType = CrafterTypePlayerCharacter
  }

currentRarityL : Lens ItemBonusImprovement StartingItemRarity
currentRarityL = Lens .currentRarity (\x a -> { a | currentRarity = x } )

crafterTypeL : Lens ItemBonusImprovement CrafterType
crafterTypeL = Lens .crafterType (\x a -> { a | crafterType = x } )

type StartingItemRarity
  = StartingItemRarityUncommon
  | StartingItemRarityRare
  | StartingItemRarityVeryRare

startingItemRarity : StrConv StartingItemRarity
startingItemRarity =
  let
    to c =
      case c of
        StartingItemRarityUncommon -> "Uncommon"
        StartingItemRarityRare     -> "Rare"
        StartingItemRarityVeryRare -> "Very Rare"
    all = [ StartingItemRarityUncommon, StartingItemRarityRare, StartingItemRarityVeryRare ]
    def = StartingItemRarityUncommon
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

finalRarity : StartingItemRarity -> ItemRarity
finalRarity r =
  case r of
    StartingItemRarityUncommon -> ItemRarityRare
    StartingItemRarityRare     -> ItemRarityVeryRare
    StartingItemRarityVeryRare -> ItemRarityLegendary

baseEnchantmentCost : ItemRarity -> Int
baseEnchantmentCost r =
  case r of
    ItemRarityCommon    -> 50
    ItemRarityUncommon  -> 200
    ItemRarityRare      -> 2000
    ItemRarityVeryRare  -> 20000
    ItemRarityLegendary -> 100000

baseEnchantmentTimeWeeks : ItemRarity -> Int
baseEnchantmentTimeWeeks r =
  case r of
    ItemRarityCommon    -> 1
    ItemRarityUncommon  -> 2
    ItemRarityRare      -> 10
    ItemRarityVeryRare  -> 25
    ItemRarityLegendary -> 50

crafterImprovementPercentage : CrafterType -> Float
crafterImprovementPercentage t =
  case t of
    CrafterTypePlayerCharacter     -> 0.85
    CrafterTypeArtificer           -> 0.75
    CrafterTypeArtificerSpecialist -> 0.65

totalImprovementCost : ItemBonusImprovement -> Float
totalImprovementCost model = toFloat (baseEnchantmentCost (finalRarity model.currentRarity)) * crafterImprovementPercentage model.crafterType

totalImprovementTimeWeeks : ItemBonusImprovement -> Float
totalImprovementTimeWeeks model = toFloat (baseEnchantmentTimeWeeks (finalRarity model.currentRarity)) * crafterImprovementPercentage model.crafterType

totalImprovementTimeHours : ItemBonusImprovement -> Float
totalImprovementTimeHours model = totalImprovementTimeWeeks model * 56