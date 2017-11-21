module Msgs exposing (..)

import Models exposing (Story)
import Http exposing (..)
import Time exposing (Time)

type Msg
    = OnFetchStoryIds (Result Http.Error (List Int))
    | OnFetchStories (Result Http.Error (List Story))
    | OnFetchStory (Result Http.Error Story)
    | SetTime Time 
