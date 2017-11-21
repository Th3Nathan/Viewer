module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (page)
import Commands exposing (fetchStories, fetchStoryIds)
import Time exposing (every, second)

init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchStoryIds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch 
    [
        every second Msgs.SetTime
    ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = page
        , update = update
        , subscriptions = subscriptions
        }