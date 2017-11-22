module Stories exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Story, Model)
import Util exposing (timeAgo)
import Material.Layout as Layout
import Html.Attributes exposing(style)
import Material.Color as Color
import Material.Scheme
import Material.List as List exposing (ul, li)
import Material.Options as Options 
import Material.Progress as Loading

view : Model -> Html Msg
view model = 
    Material.Scheme.topWithScheme Color.Teal Color.Orange <|
    Layout.render Msgs.Mdl
    model.mdl
    [ Layout.fixedHeader
    , Layout.onSelectTab Msgs.SelectTab
    , Layout.selectedTab model.selectedTab
    ]
    { header = 
        [ h3 
            [ style [ ( "text-align", "center" ), ("margin-bottom", "5px") ] ]
            [ text "Hacker News"]
        ]
    , drawer = [] 
    , tabs = ( 
            [text "New", text "Comments", text "Rating" ]
            , [Options.attribute (Html.Attributes.style 
                [ ("justify-content", "center")
                , ("cursor", "pointer")
                , ("padding-left", "90px")])
            ])
    , main = [ handleLoading model ]
    }

handleLoading : Model -> Html Msg 
handleLoading model = 
    let 
        toGo = model.toDownload 
        fetched = List.length model.collectedStories 
        ratio = (toFloat fetched) / (toFloat toGo)
        percent = ratio * 100 
    in 
        if (List.length model.stories == 0) then
            Loading.progress percent
        else 
            list model 

nav : Html Msg 
nav = 
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2"] [text "Items"] ]

infotext : Int -> Story -> String 
infotext time story = 
    (Util.timeAgo time story.time)
        ++ "  Comments: "
        ++ (toString story.descendants)
        ++ ("  Score: " ++ (toString story.score))
    

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
        [ List.withSubtitle
        , Color.text Color.primaryDark
        , Color.background (Color.color Color.Teal Color.S100)
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
                        text (infotext time story) 
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
