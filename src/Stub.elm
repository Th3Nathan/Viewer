module Stub exposing (..) 
import Json.Decode as Decode
import Models exposing (Player)
import Json.Decode.Pipeline exposing (decode, required)
playersDecoder : Decode.Decoder (List Player)
playersDecoder = 
    Decode.list playerDecoder

playerDecoder : Decode.Decoder Player 
playerDecoder = 
    decode Player
        |> required "id" Decode.string 
        |> required "name" Decode.string 
        |> required "level" Decode.int

json : String 
json = """{"players":[{"id":"1","name":"Sally","level":2},{"id":"2","name":"Lance","level":1},{"id":"3","name":"Aki","level":3},{"id":"4","name":"Maria","level":4},{"id":"5","name":"Julian","level":1},{"id":"6","name":"Jaime","level":1}]}"""



-- Decode.decodeString (Decode.field "players" Stub.playersDecoder) Stub.json
