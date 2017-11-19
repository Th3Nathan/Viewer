module View exposing (..)

import Html exposing (Html, div, text, ol, li)
import Msgs exposing (Msg)
import Models exposing (Model, Player)
import Players.List 

playerItem : Player -> Html Msg
playerItem player = 
    li []
       [
           text player.name 
       ]

page : Model -> Html Msg
page model =
    Players.List.view model.players