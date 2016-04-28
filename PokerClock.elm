module PokerClock where

import Effects
import Html exposing (..)
import StartApp
import String
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
  let
    minutes =
      toString <| seconds // 60

    secondsWithoutZeroPadding =
      toString <| seconds % 60

    secondsWithZeroPadding =
      String.padLeft 2 '0' secondsWithoutZeroPadding

  in
    minutes ++ ":" ++ secondsWithZeroPadding


inputs : List (Signal Action)
inputs =
  [ Signal.map (always Decrement) (every second) ]


type Action = Decrement

type alias Model = Int

-- To Dos: 
-- 1) Add logic to handle model = 0; It should make a noise, hold at zero
-- 2) Implement restart/refresh button
-- 3) Implement pause
