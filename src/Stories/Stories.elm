module Stories.Stories exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Story)
import Util exposing (timeAgo)

view : List Story -> Int -> Html Msg
view stories time = 
    div []
        [ nav
        ,  list stories time 
        ]
        

nav : Html Msg 
nav = 
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2"] [text "Items"] ]

list : List Story -> Int -> Html Msg 
list stories time = 
    div [ class "p2" ]
        [ table [] 
            [ thead []
                [ tr []
                    [ th [] [ text "By" ]
                    , th [] [ text "Comments Count" ]
                    , th [] [ text "ID" ]
                    , th [] [ text "Score" ]
                    , th [] [ text "TimeStamp" ]
                    , th [] [ text "Title" ]
                    , th [] [ text "URL" ]
                    , th [] [ text "Type" ]
                    ]
                ]
            , tbody [] (List.map (storyRow time) stories)
            ]
        ]

storyRow : Int -> Story -> Html Msg 
storyRow time story = 
    tr [] 
        [ td [] [ text story.by ]
        , td [] [ text (toString story.descendants) ]
        , td [] [ text (toString story.id) ]
        , td [] [ text (toString story.score) ]
        , td [] [ text (timeAgo time story.time) ]
        , td [] [ text story.title ]
        , td [] [ text story.url ]
        , td [] [ text story.type_ ]
        ]