module Utils exposing (..)

toInt : String -> Int
toInt s = case (String.toInt s) of
            Just x  -> x
            Nothing -> 0

strToFloat : String -> Float
strToFloat s = case (String.toFloat s) of
            Just x  -> x
            Nothing -> 0
