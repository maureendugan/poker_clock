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


update : Action -> Model -> ( Model, Effects.Effects a )
update action model =
  case action of
    Decrement -> ( model - 1, Effects.none )


formatSeconds : Int -> String
formatSeconds seconds =
  toString seconds


inputs : List (Signal Action)
inputs =
  [ Signal.map (always Decrement) (every second) ]


type Action = Decrement

type alias Model = Int
