module Model.BaseItemImprovement exposing (..)

import Utils exposing (..)
import Dict exposing (Dict)

type alias BaseItemImprovement =
  { itemCategory_ : ItemCategory
  , currentValue_ : Int
  , currentStatus_ : ItemStatus
  , craftingRoll_ : Int
  , standardCraftingTime_ : Float
  }

initBaseItemImprovement : BaseItemImprovement
initBaseItemImprovement =
  { itemCategory_ = itemCategory.def
  , currentValue_ = 0
  , currentStatus_ = itemStatus.def
  , craftingRoll_ = 0
  , standardCraftingTime_ = 0
  }

type ItemCategory 
  = ItemCategoryWeaponsArmor
  | ItemCategoryArtObjects
  | ItemCategoryJeweleryGems
  | ItemCategoryClothing
  | ItemCategoryMisc

itemCategory : StrConv ItemCategory
itemCategory =
  let
    to c =
      case c of
        ItemCategoryWeaponsArmor -> "Weapons & Armor"
        ItemCategoryArtObjects -> "Art Objects"
        ItemCategoryJeweleryGems -> "Jewelery & Gems"
        ItemCategoryClothing -> "Clothing"
        ItemCategoryMisc -> "Miscellaneous"
    all = [ ItemCategoryWeaponsArmor, ItemCategoryArtObjects, ItemCategoryJeweleryGems, ItemCategoryClothing, ItemCategoryMisc ]
    def = ItemCategoryWeaponsArmor
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

type ItemStatus
  = ItemStatusCrudeRaw
  | ItemStatusStandardUnworked
  | ItemStatusWorked
  | ItemStatusMasterworked

itemStatus : StrConv ItemStatus
itemStatus =
  let
    to c =
      case c of
        ItemStatusCrudeRaw -> "Crude/Raw"
        ItemStatusStandardUnworked -> "Standard/Unworked"
        ItemStatusWorked -> "Worked"
        ItemStatusMasterworked -> "Masterworked"
    all = [ ItemStatusCrudeRaw, ItemStatusStandardUnworked, ItemStatusWorked, ItemStatusMasterworked ]
    def = ItemStatusCrudeRaw
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

thresholds : ItemCategory -> (ItemStatus -> Int)
thresholds x = case x of
  ItemCategoryWeaponsArmor  -> thresholdsWeaponsArmour
  ItemCategoryArtObjects    -> thresholdsArtObjects
  ItemCategoryJeweleryGems  -> thresholdsJeweleryGems
  ItemCategoryClothing      -> thresholdsClothing
  ItemCategoryMisc          -> thresholdsMisc

thresholdsWeaponsArmour : ItemStatus -> Int
thresholdsWeaponsArmour x = case x of
  ItemStatusCrudeRaw            -> 6
  ItemStatusStandardUnworked    -> 10
  ItemStatusWorked              -> 14
  ItemStatusMasterworked        -> 20

thresholdsArtObjects : ItemStatus -> Int
thresholdsArtObjects x = case x of
  ItemStatusCrudeRaw            -> 2
  ItemStatusStandardUnworked    -> 5
  ItemStatusWorked              -> 8
  ItemStatusMasterworked        -> 23

thresholdsJeweleryGems : ItemStatus -> Int
thresholdsJeweleryGems x = case x of
  ItemStatusCrudeRaw            -> 3
  ItemStatusStandardUnworked    -> 4
  ItemStatusWorked              -> 8
  ItemStatusMasterworked        -> 18

thresholdsClothing : ItemStatus -> Int
thresholdsClothing x = case x of
  ItemStatusCrudeRaw            -> 2
  ItemStatusStandardUnworked    -> 4
  ItemStatusWorked              -> 9
  ItemStatusMasterworked        -> 14

thresholdsMisc : ItemStatus -> Int
thresholdsMisc x = case x of
  ItemStatusCrudeRaw            -> 4
  ItemStatusStandardUnworked    -> 7
  ItemStatusWorked              -> 12
  ItemStatusMasterworked        -> 15

craftingThreshold : ItemCategory -> ItemStatus -> Int
craftingThreshold cat sta = (thresholds cat) sta

craftingResult : BaseItemImprovement -> Int
craftingResult model =
  let
    cr = model.craftingRoll_
    ct = craftingThreshold model.itemCategory_ model.currentStatus_
    val = truncate (toFloat cr / toFloat ct)
  in 
    if (val > 5) then 5 else val

newItemValue : BaseItemImprovement -> Int
newItemValue model =
  let
    oldVal = model.currentValue_
    res = craftingResult model
  in
    oldVal * res

timeToCompletion : BaseItemImprovement -> Float
timeToCompletion model =
  let
    sct = model.standardCraftingTime_
    crs = craftingResult model
  in
    sct * toFloat crs