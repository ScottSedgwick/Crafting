module Model.ItemBonusImprovement exposing (..)

baseEnchantmentCost : Float
baseEnchantmentCost = 50

-- import Model exposing (..)
-- import Model.Shared exposing (..)
-- import Monocle.Lens exposing (..)
-- import Utils exposing (..)

-- finalRarity : StartingItemRarity -> ItemRarity
-- finalRarity r =
--   case r of
--     StartingItemRarityUncommon -> ItemRarityRare
--     StartingItemRarityRare     -> ItemRarityVeryRare
--     StartingItemRarityVeryRare -> ItemRarityLegendary

-- baseEnchantmentCost : ItemRarity -> Int
-- baseEnchantmentCost r =
--   case r of
--     ItemRarityCommon    -> 50
--     ItemRarityUncommon  -> 200
--     ItemRarityRare      -> 2000
--     ItemRarityVeryRare  -> 20000
--     ItemRarityLegendary -> 100000

-- baseEnchantmentTimeWeeks : ItemRarity -> Int
-- baseEnchantmentTimeWeeks r =
--   case r of
--     ItemRarityCommon    -> 1
--     ItemRarityUncommon  -> 2
--     ItemRarityRare      -> 10
--     ItemRarityVeryRare  -> 25
--     ItemRarityLegendary -> 50

-- crafterImprovementPercentage : CrafterType -> Float
-- crafterImprovementPercentage t =
--   case t of
--     CrafterTypePlayerCharacter        -> 0.85
--     CrafterTypeArtificerNotSpeciality -> 0.75
--     CrafterTypeArtificerSpeciality    -> 0.65

-- totalImprovementCost : ItemBonusImprovement -> Float
-- totalImprovementCost model = toFloat (baseEnchantmentCost (finalRarity model.currentRarity)) * crafterImprovementPercentage model.crafterType

-- totalImprovementTimeWeeks : ItemBonusImprovement -> Float
-- totalImprovementTimeWeeks model = toFloat (baseEnchantmentTimeWeeks (finalRarity model.currentRarity)) * crafterImprovementPercentage model.crafterType

-- totalImprovementTimeHours : ItemBonusImprovement -> Float
-- totalImprovementTimeHours model = totalImprovementTimeWeeks model * 56