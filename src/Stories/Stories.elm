module Stories.Stories exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Story, Model)
import Util exposing (timeAgo)
import Material.Layout as Layout
import Html.Attributes exposing(style)
import Material.Color as Color
import Material.Scheme
import Material.Table as Table
import Material.List as List exposing (ul, li)
import Material.Options as Options 

view : Model -> Html Msg
view model = 
    Material.Scheme.topWithScheme Color.LightBlue Color.Orange <|
    Layout.render Msgs.Mdl
    model.mdl
    [ Layout.fixedHeader
    , Layout.onSelectTab Msgs.SelectTab
    ]
    { header = [h3 [ style [ ( "text-align", "center" ), ("margin-bottom", "5px") ] ] [ text "Hacker News"] ]
    , drawer = [] 
    , tabs = ( [text "New", text "Comments", text "Rating" ], [Options.attribute (Html.Attributes.style [("justify-content", "center"), ("padding-left", "90px")])] )
    , main = [ list model ]
    }

nav : Html Msg 
nav = 
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2"] [text "Items"] ]

list : Model -> Html Msg 
list model = 
    div [ class "p2"
        , style [("max-width", "1000px"), ("margin", "auto")] ]
        [ List.ul [] 
           (List.map (storyRow model.time) model.stories)
        ]

storyRow : Int -> Story -> Html Msg 
storyRow time story = 
    List.li 
        [
            List.withSubtitle
            , Color.text Color.primaryDark
            , Color.background (Color.color Color.LightBlue Color.S100)
        ] 
        [ List.content [] 
            [ a 
                [ style 
                    [
                        ("cursor", "pointer"),
                        ("color", "inherit")
                    ]
                ]
                [ List.icon "commentanswer" []
                , text story.title
                ]
    
            , div 
                [ style 
                    [
                        ("padding-top", "4px")
                    ]
                ] 
                [
                    List.subtitle [] 
                    [
                        text ((Util.timeAgo time story.time) ++ ("  Comments: " ++ (toString story.descendants) ++ ("  Score: " ++ (toString story.score)))) 
                    ]
                ]
            ]
        , List.content2 [] 
            [ a [ Html.Attributes.href story.url
                , (style [("padding-bottom", "8px")])
                ]
                [
                    text (Util.getDomain story.url)
                ]
            , a [ style 
                    [
                        ("color", "inherit"),
                        ("cursor", "pointer")
                    ]
                ]
                [
                    text ("  " ++ story.by) 
                ]
            ]    
        ]



        --         Table.td [] [ text story.by ]
        -- , Table.td [] [ text (toString story.descendants) ]
        -- , Table.td [] [ text (toString story.id) ]
        -- , Table.td [] [ text (toString story.score) ]
        -- , Table.td [] [ text (timeAgo time story.time) ]
        -- , Table.td [] [ text story.title ]
        -- , Table.td [] [ text story.url ]
        -- , Table.td [] [ text story.type_ ]