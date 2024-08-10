module Model exposing (..)

import Model.BaseItemConstruction exposing (..)
import Model.BaseItemConstruction.Calculations exposing (..)
import Model.BaseItemConstruction.Lenses exposing (..)
import Model.BaseItemImprovement exposing (..)
import Model.ItemEnchantment exposing (..)
import Model.Shared exposing (..)
import Monocle.Lens exposing (..)

type Msg = ChangeTab TabName
         | UpdateStr (Lens Model String) String
         | UpdateBool (Lens Model Bool) Bool

type alias Model =
  { currentTab_ : TabName
  , baseItemConstruction_ : BaseItemConstruction 
  , baseItemImprovement_ : BaseItemImprovement
  , itemEnchantment_ : ItemEnchantment
  }

initModel : Model
initModel = 
  { currentTab_ = TabNameItemEnchantment
  , baseItemConstruction_ = initBaseItemConstruction
  , baseItemImprovement_ = initBaseItemImprovement
  , itemEnchantment_ = initItemEnchantment
  }

currentTab : Lens Model TabName
currentTab = Lens .currentTab_ (\x a -> { a | currentTab_ = x })

baseItemConstruction : Lens Model BaseItemConstruction
baseItemConstruction = Lens .baseItemConstruction_ (\x a -> { a | baseItemConstruction_ = x })

baseItemImprovementL : Lens Model BaseItemImprovement
baseItemImprovementL = Lens .baseItemImprovement_ (\x a -> { a | baseItemImprovement_ = x })

itemEnchantmentL : Lens Model ItemEnchantment
itemEnchantmentL = Lens .itemEnchantment_ (\x a -> { a | itemEnchantment_ = x } )

mCrafterInput : Model -> Int
mCrafterInput model = crafterInput ((compose baseItemConstruction Model.BaseItemConstruction.Lenses.crafterTypeL).get model)
