module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )
import Model exposing (..)
import Model.Shared exposing (..)
import View.BaseItemConstruction as BaseItemConstruction
import View.BaseItemImprovement as BaseItemImprovement
import View.ItemEnchantment as ItemEnchantment
import View.ItemBonusImprovement as ItemBonusImprovement
import View.ItemAbilityImprovement as ItemAbilityImprovement
import View.NewItemResearch as NewItemResearch
import View.SentientItems as SentientItems
import View.Artifacts as Artifacts

view : Model -> Html Msg
view model = 
  div []
    [ div [ class "w3-tab-bar w3-block" ] (List.map (tabButton model) allTabs)
    , div [class "tabs" ] (List.map (tabView model) allTabs)
    ]
    
tabButton : Model -> TabName -> Html Msg
tabButton model tab =
  button [ class (tabButtonClass (currentTab.get model == tab)), onClick (ChangeTab tab) ] [ text (tabName tab) ]

tabButtonClass : Bool -> String
tabButtonClass current = if current then "tab-button w3-tab-bar-item w3-button w3-highlight-tab" else "tab-button w3-tab-bar-item w3-button"

tabView : Model -> TabName -> Html Msg
tabView model tab =
  div [ id (tabId tab), class "city", style "display" (tabViewDisplay (tab == currentTab.get model)) ]
    [ case tab of
        TabNameBaseItemConstruction -> BaseItemConstruction.view model
        TabNameBaseItemImprovement -> BaseItemImprovement.view model
        TabNameItemEnchantment -> ItemEnchantment.view model
        TabNameItemBonusImprovement -> ItemBonusImprovement.view model
        TabNameItemAbilityImprovement -> ItemAbilityImprovement.view model
        TabNameNewItemResearch -> NewItemResearch.view model
        TabNameSentientItems -> SentientItems.view model
        TabNameArtifacts -> Artifacts.view model
    ]

tabViewDisplay : Bool -> String
tabViewDisplay show = if show then "block" else "none"