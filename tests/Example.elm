module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Monocle.Lens exposing (..)
import Model exposing (..)
import Model.WorkingConditions exposing (..)


workingConditions : Test
workingConditions =
  let
    m1 = (compose workingConditionsL assistant1L).set AssistantTypeArtificerSpeciality initModel 
    m2 = (compose workingConditionsL assistant3L).set AssistantTypeExpertise m1
  in
    describe "Model tests"
        [ test "starting tab is correct" (\_ -> Expect.equal tabName.def m2.currentTab)
        , test "assistant input total correct" (\_ -> Expect.equal 130 (assistanceInputTotal m2.workingConditions))
        ]
