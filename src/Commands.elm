module Commands exposing (..)

import Http 
import Json.Decode as Decode 
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Story)
import Msgs exposing (..)

fetchStoryIds : Cmd Msg
fetchStoryIds = 
    Http.send Msgs.OnFetchStoryIds (Http.get fetchStoriesUrl idsDecoder)
       
fetchStories : List Int -> Cmd Msg
fetchStories ids = 
    Cmd.batch ( List.map (\x -> fetchStory x) ids ) 

fetchStory : Int -> Cmd Msg
fetchStory id = 
    Http.send Msgs.OnFetchStory (Http.get (fetchStoryUrl id) storyDecoder) 


fetchStoriesUrl : String 
fetchStoriesUrl = 
    "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"

fetchStoryUrl : Int -> String 
fetchStoryUrl id = 
    "https://hacker-news.firebaseio.com/v0/item/" ++ (toString id) ++ ".json?print=pretty"

storyDecoder : Decode.Decoder Story
storyDecoder = 
    decode Story
        |> required "by" Decode.string 
        |> required "descendants" Decode.int
        |> required "id" Decode.int
        |> required "kids" (Decode.list Decode.int)
        |> required "score" Decode.int
        |> required "time" Decode.int
        |> required "title" Decode.string
        |> required "url" Decode.string
        |> required "type" Decode.string

idsDecoder : Decode.Decoder (List Int)
idsDecoder = 
    Decode.list Decode.int
