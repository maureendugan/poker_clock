module PokerClock where

import Effects exposing (Effects)
import Html exposing (..)
import StartApp
import Task exposing (Task)
import Time exposing ( every, second )


-- Model

type alias Model = Int


model : Model
model =
  900


init : ( Model, Effects Action )
init =
  ( model, Effects.none )


-- View

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text (formatSeconds model) ]
    -- , button [] [ text "Play" ]
    -- , button [] [ text "Pause" ]
    ]


formatSeconds : Int -> String
formatSeconds seconds =
  toString seconds


-- Update

type Action = Tick | Noop


update : Action -> Model -> ( Model, Effects Action )
update action model =
  let
    updatedModel =
      clamp 0 900 (model - 1)

  in
    case action of
      Tick -> ( updatedModel, playBeepIf <| updatedModel == 0 )
      Noop -> ( model, Effects.none )


-- Effects

playBeepIf : Bool -> Effects Action
playBeepIf condition =
  let
    playBeepTask : Task x ()
    playBeepTask =
      Signal.send playBeepMailbox.address True

    playBeepEffect : Effects Action
    playBeepEffect =
      Effects.map (always Noop) (Effects.task playBeepTask)

  in
    if condition
      then playBeepEffect
      else Effects.none


playBeepSignal : Signal Bool
playBeepSignal =
  playBeepMailbox.signal


playBeepMailbox : Signal.Mailbox Bool
playBeepMailbox =
  Signal.mailbox False


-- StartApp

app : StartApp.App Model
app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


inputs : List (Signal Action)
inputs =
  [ Signal.map (always Tick) (every second) ]


tasks : Signal (Task Effects.Never ())
tasks = app.tasks


html : Signal Html
html = app.html

