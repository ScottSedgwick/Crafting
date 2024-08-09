module Model.BaseItemImprovement.Lenses exposing (..)

import Monocle.Lens exposing (..)
import Model.BaseItemImprovement exposing (..)
import Utils exposing (..)

itemCategoryL : Lens BaseItemImprovement ItemCategory
itemCategoryL = Lens .itemCategory_ (\x a -> { a | itemCategory_ = x })

currentValueL : Lens BaseItemImprovement Int
currentValueL = Lens .currentValue_ (\x a -> { a | currentValue_ = x })

currentStatusL : Lens BaseItemImprovement ItemStatus
currentStatusL = Lens .currentStatus_ (\x a -> { a | currentStatus_ = x })

craftingRollL : Lens BaseItemImprovement Int
craftingRollL = Lens .craftingRoll_ (\x a -> { a | craftingRoll_ = x })

standardCraftingTimeL : Lens BaseItemImprovement Float
standardCraftingTimeL = Lens .standardCraftingTime_ (\x a -> { a | standardCraftingTime_ = x })
