module Models exposing (..)
import Material exposing (..)

type alias Model =
    { storyIds : List Int 
    , stories : List Story
    , time : Int
    , mdl : Material.Model 
    }

initialModel : Model 
initialModel = 
    { storyIds = []
    , stories = []
    , time = 0
    , mdl = Material.model
    }


type alias Story = 
    { by : String 
    , descendants : Int
    , id : Int
    , kids : List Int
    , score : Int
    , time : Int 
    , title : String
    , url : String
    , type_: String
    }