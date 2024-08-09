module Utils exposing (..)

import List exposing (head, tail)
import Monocle.Lens exposing (..)

toInt : String -> Int
toInt s = case (String.toInt s) of
            Just x  -> x
            Nothing -> 0

type alias StrConv a =
  { toStr : a -> String
  , all : List a
  , def : a
  , fromStr : String -> a
  }

defFromStr : (a -> String) -> List a -> a -> String -> a
defFromStr toS all def s =
  case head all of
    Nothing -> def
    Just x  -> 
      if (toS x == s) 
      then x
      else 
        case (tail all) of
          Nothing -> def
          Just xs -> defFromStr toS xs def s

intStrConv : StrConv Int
intStrConv =
  { toStr = String.fromInt
  , fromStr = toInt
  , def = 0
  , all = []
  }

boolStrConv : StrConv Bool
boolStrConv =
  let
    to x = if x then "True" else "False"
    all = [True, False]
    def = False
  in
    { toStr = to
    , def = def
    , all = all
    , fromStr = defFromStr to all def
    }

toStrLens : StrConv b -> Lens a b -> Lens a String
toStrLens sc lens = Lens (\x -> sc.toStr (lens.get x)) (\x a -> lens.set (sc.fromStr x) a)