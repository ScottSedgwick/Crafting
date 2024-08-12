module Model.BaseItemImprovement exposing (..)

import Model exposing (..)
import Utils exposing (..)

thresholds : ItemCategory -> (ItemStatus -> Int)
thresholds x = case x of
  ItemCategoryWeaponsAndArmor -> thresholdsWeaponsArmour
  ItemCategoryArtObjects      -> thresholdsArtObjects
  ItemCategoryJeweleryAndGems -> thresholdsJeweleryGems
  ItemCategoryClothing        -> thresholdsClothing
  ItemCategoryMiscellaneous   -> thresholdsMisc

thresholdsWeaponsArmour : ItemStatus -> Int
thresholdsWeaponsArmour x = case x of
  ItemStatusCrudeOrRaw          -> 6
  ItemStatusStandardOrUnworked  -> 10
  ItemStatusWorked              -> 14
  ItemStatusMasterworked        -> 20

thresholdsArtObjects : ItemStatus -> Int
thresholdsArtObjects x = case x of
  ItemStatusCrudeOrRaw            -> 2
  ItemStatusStandardOrUnworked    -> 5
  ItemStatusWorked              -> 8
  ItemStatusMasterworked        -> 23

thresholdsJeweleryGems : ItemStatus -> Int
thresholdsJeweleryGems x = case x of
  ItemStatusCrudeOrRaw            -> 3
  ItemStatusStandardOrUnworked    -> 4
  ItemStatusWorked              -> 8
  ItemStatusMasterworked        -> 18

thresholdsClothing : ItemStatus -> Int
thresholdsClothing x = case x of
  ItemStatusCrudeOrRaw            -> 2
  ItemStatusStandardOrUnworked    -> 4
  ItemStatusWorked              -> 9
  ItemStatusMasterworked        -> 14

thresholdsMisc : ItemStatus -> Int
thresholdsMisc x = case x of
  ItemStatusCrudeOrRaw            -> 4
  ItemStatusStandardOrUnworked    -> 7
  ItemStatusWorked              -> 12
  ItemStatusMasterworked        -> 15

craftingThreshold : ItemCategory -> ItemStatus -> Int
craftingThreshold cat sta = (thresholds cat) sta

craftingResult : BaseItemImprovement -> Int
craftingResult model =
  let
    cr = model.craftingRoll
    ct = craftingThreshold model.itemCategory model.currentStatus
    val = truncate (toFloat cr / toFloat ct)
  in 
    if (val > 5) then 5 else val

newItemValue : BaseItemImprovement -> Int
newItemValue model =
  let
    oldVal = model.currentValue
    res = craftingResult model
  in
    oldVal * res

timeToCompletion : BaseItemImprovement -> Float
timeToCompletion model =
  let
    sct = model.standardCraftingTime
    crs = craftingResult model
  in
    sct * toFloat crs