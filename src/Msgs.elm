module Msgs exposing (..)

import Models exposing (Story)
import Http exposing (..)
import Time exposing (Time)
import Material 

type alias Mdl = Material.Model

type Msg
    = OnFetchStoryIds (Result Http.Error (List Int))
    | OnFetchStories (Result Http.Error (List Story))
    | OnFetchStory (Result Http.Error Story)
    | SetTime Time 
    | Mdl (Material.Msg Msg)
    | SelectTab Int 
