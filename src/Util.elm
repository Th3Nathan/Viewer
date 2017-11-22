module Util exposing (..)
import Tuple exposing (first, second)
import Models exposing (Story)

type Category = New | Comments | Rating 
sortBy : Category -> List Story -> List Story 
sortBy category stories = 
    case category of 
        New -> List.sortBy (\a -> a.time * -1) stories 
        Comments -> List.sortBy (\a -> a.descendants * -1) stories 
        Rating -> List.sortBy (\a -> a.score * -1) stories 

timeData : Int -> Int -> (Int, String)
timeData current past = 
    let 
        secondsAgo = ((current // 1000) - past)
        years = secondsAgo // 31556926 
        months = secondsAgo // 2629743 
        days = secondsAgo // 86400 
        hours = secondsAgo // 3600 
        minutes = secondsAgo // 60 
    in 
        if years > 0 then 
            (years, "year")
        else if months > 0 then 
            (months, "month")
        else if days > 0 then 
            (days, "day")
        else if hours > 0 then 
            (hours, "hour")
        else if minutes > 0 then 
            (minutes, "minute")
        else
            (secondsAgo, "second")

pluralize : String -> Int -> String
pluralize singular count =
    if count /= 1 then singular ++ "s"
    else singular 

timeAgo : Int -> Int -> String 
timeAgo current past = 
    let
        data = timeData current past 
    in 
        toString (first data)  ++ " " ++ (pluralize (second data) (first data) ) ++ " ago"

chopHttp : String -> String 
chopHttp url =
    if (String.slice 0 8 url == "https://") then 
        String.slice 8 (String.length url - 1) url 
    else if (String.slice 0 7 url == "http://") then 
        String.slice 7 (String.length url - 1) url 
    else url 

getDomain : String -> String 
getDomain url = 
    let 
        afterhttp = chopHttp url
        slashplaces = String.indices "/" afterhttp
        firstPlace = List.head slashplaces

    in 
        case firstPlace of 
            Nothing -> url 
            Just firstPlace -> (String.slice 0 firstPlace afterhttp) 

