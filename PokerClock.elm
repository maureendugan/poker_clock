module PokerClock where

import Effects
import Html exposing (..)
import StartApp


app =
  StartApp.start { init = init, view = view, update = update, inputs = [] }


main =
  app.html


init =
  ( model, Effects.none )


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
  ( model, Effects.none )


formatSeconds : Int -> String
formatSeconds seconds =
  toString seconds
