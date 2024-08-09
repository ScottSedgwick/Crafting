module Model.BaseItemConstruction.Lenses exposing (..)

import Monocle.Lens exposing (..)
import Model.BaseItemConstruction exposing (..)
import Utils exposing (..)

baseItemPrice : Lens BaseItemConstruction Int
baseItemPrice = Lens .baseItemPrice_ (\x a -> { a | baseItemPrice_ = x })

baseItemPriceStr : Lens BaseItemConstruction String
baseItemPriceStr = toStrLens intStrConv baseItemPrice

crafterTypeL : Lens BaseItemConstruction CrafterType
crafterTypeL = Lens .crafterType_ (\x a -> { a | crafterType_ = x })

crafterTypeStr : Lens BaseItemConstruction String
crafterTypeStr = toStrLens crafterType crafterTypeL

craftingEnvironmentL : Lens BaseItemConstruction CraftingEnvironment
craftingEnvironmentL = Lens .craftingEnvironment_ (\x a -> { a | craftingEnvironment_ = x })

craftingEnvironmentStr : Lens BaseItemConstruction String
craftingEnvironmentStr = toStrLens craftingEnvironment craftingEnvironmentL

environmentAttuned : Lens BaseItemConstruction Bool
environmentAttuned = Lens .environmentAttuned_ (\x a -> { a | environmentAttuned_ = x })

environmentAttunedStr : Lens BaseItemConstruction String
environmentAttunedStr = toStrLens boolStrConv environmentAttuned

environmentSanctification : Lens BaseItemConstruction Sanctification
environmentSanctification = Lens .environmentSanctification_ (\x a -> { a | environmentSanctification_ = x })

environmentSanctificationStr : Lens BaseItemConstruction String
environmentSanctificationStr = toStrLens sanctification environmentSanctification

additionalCostReduction : Lens BaseItemConstruction Int
additionalCostReduction = Lens .additionalCostReduction_ (\x a -> { a | additionalCostReduction_ = x })

assistant1 : Lens BaseItemConstruction AssistantType
assistant1 = Lens .assistant1_ (\x a -> { a | assistant1_ = x })

assistant1Str : Lens BaseItemConstruction String
assistant1Str = toStrLens assistantType assistant1

assistant2 : Lens BaseItemConstruction AssistantType
assistant2 = Lens .assistant2_ (\x a -> { a | assistant2_ = x })

assistant2Str : Lens BaseItemConstruction String
assistant2Str = toStrLens assistantType assistant2

assistant3 : Lens BaseItemConstruction AssistantType
assistant3 = Lens .assistant3_ (\x a -> { a | assistant3_ = x })

assistant3Str : Lens BaseItemConstruction String
assistant3Str = toStrLens assistantType assistant3

assistant4 : Lens BaseItemConstruction AssistantType
assistant4 = Lens .assistant4_ (\x a -> { a | assistant4_ = x })

assistant4Str : Lens BaseItemConstruction String
assistant4Str = toStrLens assistantType assistant4

assistant5 : Lens BaseItemConstruction AssistantType
assistant5 = Lens .assistant5_ (\x a -> { a | assistant5_ = x })

assistant5Str : Lens BaseItemConstruction String
assistant5Str = toStrLens assistantType assistant5

tool1 : Lens BaseItemConstruction Tool
tool1 = Lens .tool1_ (\x a -> { a | tool1_ = x })

tool2 : Lens BaseItemConstruction Tool
tool2 = Lens .tool2_ (\x a -> { a | tool2_ = x })

tool3 : Lens BaseItemConstruction Tool
tool3 = Lens .tool3_ (\x a -> { a | tool3_ = x })

tool4 : Lens BaseItemConstruction Tool
tool4 = Lens .tool4_ (\x a -> { a | tool4_ = x })

tool5 : Lens BaseItemConstruction Tool
tool5 = Lens .tool5_ (\x a -> { a | tool5_ = x })

additionalCraftingAssistanceCost : Lens BaseItemConstruction Int
additionalCraftingAssistanceCost = Lens .additionalCraftingAssistanceCost_ (\x a -> { a | additionalCraftingAssistanceCost_ = x })

miscAdditionalCost : Lens BaseItemConstruction Int
miscAdditionalCost = Lens .miscAdditionalCost_ (\x a -> { a | miscAdditionalCost_ = x })