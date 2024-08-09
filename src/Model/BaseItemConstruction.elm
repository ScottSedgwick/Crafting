module Model.BaseItemConstruction exposing (..)

import Monocle.Lens exposing (..)
import Utils exposing (..)

type CrafterType = CrafterTypePlayerCharacter
                 | CrafterTypeArtificer
                 | CrafterTypeArtificerSpecialist

crafterType : StrConv CrafterType
crafterType =
  let
    to c =
      case c of
        CrafterTypePlayerCharacter     -> "Player Character/Non-Artificer"
        CrafterTypeArtificer           -> "Artificer (non-speciality)"
        CrafterTypeArtificerSpecialist -> "Artificer (speciality)"
    all = [ CrafterTypePlayerCharacter, CrafterTypeArtificer, CrafterTypeArtificerSpecialist ]
    def = CrafterTypePlayerCharacter
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

type CraftingEnvironment = CraftingEnvironmentVeryCrude
                         | CraftingEnvironmentCrude
                         | CraftingEnvironmentBasic
                         | CraftingEnvironmentAdvanced
                         | CraftingEnvironmentExpert
                         | CraftingEnvironmentApex

craftingEnvironment : StrConv CraftingEnvironment
craftingEnvironment =
  let
    to e =
      case e of
        CraftingEnvironmentVeryCrude  -> "Very Crude"
        CraftingEnvironmentCrude      -> "Crude"
        CraftingEnvironmentBasic      -> "Basic"
        CraftingEnvironmentAdvanced   -> "Advanced"
        CraftingEnvironmentExpert     -> "Expert"
        CraftingEnvironmentApex       -> "Apex"
    all = [ CraftingEnvironmentVeryCrude, CraftingEnvironmentCrude, CraftingEnvironmentBasic, CraftingEnvironmentAdvanced, CraftingEnvironmentExpert, CraftingEnvironmentApex ]
    def = CraftingEnvironmentBasic
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

craftingEnvironmentModifier : CraftingEnvironment -> Int
craftingEnvironmentModifier e =
  case e of 
    CraftingEnvironmentVeryCrude  -> 15
    CraftingEnvironmentCrude      -> 10
    CraftingEnvironmentBasic      -> 0
    CraftingEnvironmentAdvanced   -> -10
    CraftingEnvironmentExpert     -> -15
    CraftingEnvironmentApex       -> -20

type Sanctification = SanctificationNone
                    | SanctificationBasic
                    | SanctificationThemed

sanctification : StrConv Sanctification
sanctification =
  let
    to s =
      case s of
        SanctificationNone    -> "None"
        SanctificationBasic   -> "Basic"
        SanctificationThemed  -> "Themed"
    all = [ SanctificationNone, SanctificationBasic, SanctificationThemed ]
    def = SanctificationNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

type AssistantType = AssistantTypeNone
                   | AssistantTypeNotProficient
                   | AssistantTypeHalfProficient
                   | AssistantTypeProficient
                   | AssistantTypePlayerCharacter
                   | AssistantTypeExpertise
                   | AssistantTypeArtificer
                   | AssistantTypeArtificerSpecialist

assistantType : StrConv AssistantType
assistantType =
  let
    to t =
      case t of
        AssistantTypeNone                 -> "None"
        AssistantTypeNotProficient        -> "Not Proficient"
        AssistantTypeHalfProficient       -> "Half Proficient"
        AssistantTypeProficient           -> "Proficient"
        AssistantTypePlayerCharacter      -> "Player Character"
        AssistantTypeExpertise            -> "Expertise"
        AssistantTypeArtificer            -> "Artificer (non-specialist)"
        AssistantTypeArtificerSpecialist  -> "Artificer (specialist)"
    all = [ AssistantTypeNone
          , AssistantTypeNotProficient
          , AssistantTypeHalfProficient
          , AssistantTypeProficient
          , AssistantTypePlayerCharacter
          , AssistantTypeExpertise
          , AssistantTypeArtificer
          , AssistantTypeArtificerSpecialist
          ]
    def = AssistantTypeNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

assistantInput : AssistantType -> Int
assistantInput a = 
  case a of
    AssistantTypeNone                 -> 0
    AssistantTypeNotProficient        -> 5
    AssistantTypeHalfProficient       -> 7
    AssistantTypeProficient           -> 15
    AssistantTypePlayerCharacter      -> 25
    AssistantTypeExpertise            -> 30
    AssistantTypeArtificer            -> 50
    AssistantTypeArtificerSpecialist  -> 100

type ToolType = ToolTypeNone
              | ToolTypeSubstandard
              | ToolTypeStandard
              | ToolTypeAdvanced
              | ToolTypeMasterwork
              | ToolTypeMythic

toolType : StrConv ToolType
toolType = 
  let
    to t =
      case t of
        ToolTypeNone        -> "None"
        ToolTypeSubstandard -> "Substandard"
        ToolTypeStandard    -> "Standard"
        ToolTypeAdvanced    -> "Advanced"
        ToolTypeMasterwork  -> "Masterwork"
        ToolTypeMythic      -> "Mythic"
    all = [ ToolTypeNone, ToolTypeSubstandard, ToolTypeStandard, ToolTypeAdvanced, ToolTypeMasterwork, ToolTypeMythic ]
    def = ToolTypeNone
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

type alias Tool =
  { toolType_ : ToolType
  , magical_ : Bool
  , sanctification_ : Sanctification
  }

initTool : Tool
initTool =
  { toolType_ = toolType.def
  , magical_ = False
  , sanctification_ = sanctification.def
  }

toolTypeL : Lens Tool ToolType
toolTypeL = Lens .toolType_ (\x a -> { a | toolType_ = x })

toolTypeStr : Lens Tool String
toolTypeStr = toStrLens toolType toolTypeL

magicalL : Lens Tool Bool
magicalL = Lens .magical_ (\x a -> { a | magical_ = x })

sanctificationL : Lens Tool Sanctification
sanctificationL = Lens .sanctification_ (\x a -> { a | sanctification_ = x })

sanctificationStr : Lens Tool String
sanctificationStr = toStrLens sanctification sanctificationL

type alias BaseItemConstruction =
  { baseItemPrice_ : Int
  , crafterType_ : CrafterType
  , craftingEnvironment_ : CraftingEnvironment
  , environmentAttuned_ : Bool
  , environmentSanctification_ : Sanctification
  , additionalCostReduction_ : Int
  , assistant1_ : AssistantType
  , assistant2_ : AssistantType
  , assistant3_ : AssistantType
  , assistant4_ : AssistantType
  , assistant5_ : AssistantType
  , tool1_ : Tool
  , tool2_ : Tool
  , tool3_ : Tool
  , tool4_ : Tool
  , tool5_ : Tool
  , additionalCraftingAssistanceCost_ : Int
  , miscAdditionalCost_ : Int
  }

      
initBaseItemConstruction : BaseItemConstruction
initBaseItemConstruction =
  { baseItemPrice_ = 0
  , crafterType_ = CrafterTypePlayerCharacter
  , craftingEnvironment_ = CraftingEnvironmentBasic
  , environmentAttuned_ = False
  , environmentSanctification_ = SanctificationNone
  , additionalCostReduction_ = 0
  , assistant1_ = AssistantTypeNone
  , assistant2_ = AssistantTypeNone
  , assistant3_ = AssistantTypeNone
  , assistant4_ = AssistantTypeNone
  , assistant5_ = AssistantTypeNone
  , tool1_ = initTool
  , tool2_ = initTool
  , tool3_ = initTool
  , tool4_ = initTool
  , tool5_ = initTool
  , additionalCraftingAssistanceCost_ = 0
  , miscAdditionalCost_ = 0
  }
