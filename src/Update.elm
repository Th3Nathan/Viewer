module Update exposing (..)


import Models exposing (Model, Story)
import Commands exposing (fetchStories)
import Http exposing (..)
import Msgs exposing (..)


idsPerPage : Int -> List Int -> List Int 
idsPerPage pageNum allIds = 
        List.take (pageNum * 30) allIds

update : Msg -> a -> ( a, Cmd Msgs.Msg )
update msg model =
    case msg of
        OnFetchStory (Result.Ok story) ->
            (model, Cmd.none )
        OnFetchStory (Result.Err _) ->
            (model, Cmd.none )
        OnFetchStoryIds (Result.Ok ids) ->
            (model, (fetchStories [1, 2, 3]))
        OnFetchStoryIds (Result.Err _) ->
            (model, Cmd.none )
        OnFetchStories (Result.Ok stories) ->
            (model, Cmd.none )
        OnFetchStories (Result.Err _) ->
            (model, Cmd.none )


