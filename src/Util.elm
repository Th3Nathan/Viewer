module Util exposing (..)
import Tuple exposing (first, second)

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
