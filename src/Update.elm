module Update exposing (..)


import Models exposing (Model, Story)
import Commands exposing (fetchStories)
import Http exposing (..)
import Msgs exposing (..)
import Time exposing (inMilliseconds)
import Material exposing (..)

idsPerPage : Int -> List Int -> List Int 
idsPerPage pageNum allIds = 
        List.take (pageNum * 30) allIds

-- when all the data comes in, trigger an event to take the list, sort it, and put it in a sorted slice of state. 
-- check if all data comes in by triggering event when each story comes in, check if length of storeis == the boss 
--doesnt work, use task instead of command batch 

update : Msgs.Msg -> Models.Model -> ( Models.Model, Cmd Msgs.Msg )
update msg model =
    case msg of
        OnFetchStory (Result.Ok story) ->
            if ( model.toDownload == 1) then 
                ({model | stories = (story :: model.sorted)}, Cmd.none )
            else 
                ({model | sorted = (story :: model.sorted), toDownload = model.toDownload - 1}, Cmd.none )
        OnFetchStory (Result.Err _) ->
            ({model | toDownload = model.toDownload - 1}, Cmd.none )
        OnFetchStoryIds (Result.Ok ids) ->
            let 
                numIds = List.length ids 
            in 
                ({model | storyIds = ids, toDownload = numIds}, (fetchStories ids))
        OnFetchStoryIds (Result.Err _) ->
            (model, Cmd.none )
        OnFetchStories (Result.Ok stories) ->
            ({ model | stories = stories }, Cmd.none )
        OnFetchStories (Result.Err _) ->
            (model, Cmd.none )
        SetTime time -> 
            ({ model | time = (floor (inMilliseconds time))}, Cmd.none )
        Msgs.Mdl message_ -> 
            Material.update Mdl message_ model
        Msgs.SelectTab num -> 
            let 
                _ = 
                    Debug.log "SelectTab: " num 
            in model ! []  


