module PokerClock where

import Effects
import Html exposing (..)
import Html.Events exposing (..)
import StartApp
import String
import Time exposing ( every, second )


app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


main =
  app.html


init =
  ( initialModel, Effects.none )


type alias Model = { counter : Int, isPaused : Bool }

initialModel : Model
initialModel =
  { counter = 900
  , isPaused = True
  }


view address model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text (formatSeconds model.counter) ]
    , button [ onClick address Toggle ]
      [ text (if model.isPaused then "Play" else "Pause") ]
    ]


update : Action -> Model -> ( Model, Effects.Effects a )
update action model =
  let
    updatedModel =
      case action of
        Decrement ->
          if model.isPaused
            then model
            else { model | counter = model.counter - 1 }

        Toggle ->
          { model | isPaused = not model.isPaused }

  in
    ( updatedModel, Effects.none )


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


type Action = Decrement | Toggle

-- To Dos: 
-- 1) Add logic to handle model = 0; It should make a noise, hold at zero
-- 2) Implement restart/refresh button
-- 3) Implement pause
