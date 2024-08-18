module Model.BaseItemConstruction exposing (..)

import Model exposing (..)
import Monocle.Lens exposing (..)
import Model.Shared exposing (..)
import Model.WorkingConditions exposing (..)

baseMaterialCost : BaseItemConstruction -> Float
baseMaterialCost model = toFloat (baseItemPriceL.get model) * 0.15

-- Divide Total Hours by 56
totalWorkWeeks : Model -> Float
totalWorkWeeks model = totalHours model / 56

totalHours : Model -> Float
totalHours model =
  let
    cet = environmentTotal model.workingConditions
    wwh = cet + 56
    cin = crafterInput (crafterTypeL.get model.workingConditions)
    cat = assistanceInputPerWeekTotal model.workingConditions
    stt = toolTotal model.workingConditions
    tci = stt + toFloat cat + toFloat cin
    bip = baseItemPriceL.get model.baseItemConstruction
    tww = toFloat bip / tci
  in
    tww * toFloat wwh

-- Add Base Materials Costs, Crafting Assistance Cost Total, Additional Crafting Assistance Cost, and Miscellaneous Additional Cost.
totalCosts : Model -> Float
totalCosts model =
  let
    bmc = baseMaterialCost model.baseItemConstruction
    totalWW = totalWorkWeeks model
    cact = allAssistantsCostTotal totalWW model.workingConditions
    acac = additionalCraftingAssistanceCostL.get model.baseItemConstruction
    mac = miscAdditionalCostL.get model.baseItemConstruction
  in
    bmc + cact + toFloat acac + toFloat mac
