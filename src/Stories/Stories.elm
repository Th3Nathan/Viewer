module Stories.Stories exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Story)


view : List Story -> Html Msg
view response = 
    div []
        [ nav
        ,  list response
        ]
        

nav : Html Msg 
nav = 
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2"] [text "Items"] ]

list : List Story -> Html Msg 
list items = 
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
            , tbody [] (List.map itemRow items)
            ]
        ]

itemRow : Story -> Html Msg 
itemRow item = 
    tr [] 
        [ td [] [ text item.by ]
        , td [] [ text (toString item.descendants) ]
        , td [] [ text (toString item.id) ]
        , td [] [ text (toString item.score) ]
        , td [] [ text (toString item.time) ]
        , td [] [ text item.title ]
        , td [] [ text item.url ]
        , td [] [ text item.type_ ]
        ]