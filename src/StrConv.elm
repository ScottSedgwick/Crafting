module StrConv exposing (..)

import List exposing (head, tail)
import Monocle.Lens exposing (..)
import Utils exposing (..)

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

floatStrConv : StrConv Float
floatStrConv =
  { toStr = String.fromFloat
  , fromStr = strToFloat
  , def = 0.0
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