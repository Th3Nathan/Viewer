module Update exposing (..)
import Models exposing (Model, Story)
import Commands exposing (fetchStories)
import Msgs exposing (..)
import Time exposing (inMilliseconds)
import Material exposing (..)
import Util exposing (Category, sortBy)

update : Msgs.Msg -> Models.Model -> ( Models.Model, Cmd Msgs.Msg )
update msg model =
    case msg of
        OnFetchStory (Result.Ok story) ->
            if ( model.toDownload == 1) then 
                ({model | stories = (sortBy Util.New (story :: model.collectedStories))}, Cmd.none )
            else 
                ({model | collectedStories = (story :: model.collectedStories), toDownload = model.toDownload - 1}, Cmd.none )
        OnFetchStory (Result.Err _) ->
            ({model | toDownload = model.toDownload - 1}, Cmd.none )
        OnFetchStoryIds (Result.Ok ids) ->
            ({model | storyIds = ids, toDownload = (List.length ids) }, (fetchStories ids))
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
        Msgs.SelectTab tab -> 
            (sortByTab tab model)

categoryFromTab : Int -> Category 
categoryFromTab tab = 
    if tab == 0 then Util.New 
    else if tab == 1 then Util.Comments 
    else Util.Rating

sortByTab : Int -> Models.Model -> ( Models.Model, Cmd Msgs.Msg )
sortByTab tab model = 
    ({model | stories = sortBy (categoryFromTab tab) model.collectedStories, selectedTab = tab}, Cmd.none)