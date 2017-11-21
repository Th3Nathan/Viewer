module Models exposing (..)


type alias Model =
    { storyIds : List Int 
    , stories : List Story
    , time : Int
    }

initialModel : Model 
initialModel = 
    { storyIds = []
    , stories = []
    , time = 0
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