module PokerClock where

import Effects
import Html exposing (..)
import StartApp
import Time exposing ( every, second )


app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


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


inputs : List (Signal Action)
inputs =
  [ Signal.map countdown (every second) ]


countdown : a -> Action
countdown _ =
  Decrement


type Action = Decrement | Noop
