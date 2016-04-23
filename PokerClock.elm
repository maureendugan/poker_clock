module PokerClock where

import Html exposing (..)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = model, view = view, update = update }


model = ""


view address model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text "00:00" ]
    , button [] [ text "Play" ]
    , button [] [ text "Pause" ]
    ]


update action model =
  model
