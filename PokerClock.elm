module PokerClock where

import Effects
import Html exposing (..)
import StartApp
import Task exposing (Task)
import Time exposing ( every, second )


app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


port tasks : Signal (Task Effects.Never ())
port tasks = app.tasks


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
    -- , button [] [ text "Play" ]
    -- , button [] [ text "Pause" ]
    ]


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  let
    playBeepIfZero =
      if model - 1 == 0
        then playBeepEffect
        else Effects.none

  in
    case action of
      Tick -> ( clamp 0 900 (model - 1), playBeepIfZero )
      Noop -> ( model, Effects.none )


formatSeconds : Int -> String
formatSeconds seconds =
  toString seconds


inputs : List (Signal Action)
inputs =
  [ Signal.map (always Tick) (every second) ]


type Action = Tick | Noop


type alias Model = Int


port playBeep : Signal Bool
port playBeep =
  playBeepMailbox.signal


playBeepMailbox : Signal.Mailbox Bool
playBeepMailbox =
  Signal.mailbox False


playBeepTask : Task x ()
playBeepTask =
  Signal.send playBeepMailbox.address True


playBeepEffect : Effects.Effects Action
playBeepEffect =
  Effects.map (always Noop) (Effects.task playBeepTask)

-- To Dos:
-- 1) Add logic to handle model = 0; It should make a noise, hold at zero
-- 2) Implement restart/refresh button
-- 3) Implement pause
