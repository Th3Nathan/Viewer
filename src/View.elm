module View exposing (..)

import Html exposing (Html, div, text, ol, li)
import Msgs exposing (Msg)
import Models exposing (Model)
import Stories


page : Model -> Html Msg
page model =
        Stories.view model