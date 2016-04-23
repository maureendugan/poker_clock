module PokerClock where

import Html exposing (..)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = model, view = view, update = update }


model : Int
model = 900


view address model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text (formatSeconds model) ]
    , button [] [ text "Play" ]
    , button [] [ text "Pause" ]
    ]


update action model =
  model


formatSeconds : Int -> String
formatSeconds seconds =
  toString seconds
