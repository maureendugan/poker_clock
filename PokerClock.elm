module PokerClock where

import Effects exposing (Effects)
import Html exposing (..)
import StartApp
import String exposing (padLeft)
import Task exposing (Task)
import Time exposing ( every, second )


---- MODEL ----

type alias Model = Int


init : ( Model, Effects Action )
init =
  ( 900, Effects.none )


---- UPDATE ----

type Action = Tick | Noop


update : Action -> Model -> ( Model, Effects Action )
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


---- VIEW ----

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text (formatTime model) ]
    ]


formatTime : Int -> String
formatTime seconds =
  let
    min = toString <| seconds // 60
    sec = padLeft 2 '0' <| toString <| seconds % 60
  in
    min ++ ":" ++ sec


---- INPUTS ----

inputs : List (Signal Action)
inputs =
  [ Signal.map (always Tick) (every second) ]



---- OUTPUTS ----

port playBeep : Signal Bool
port playBeep =
  playBeepMailbox.signal


playBeepMailbox : Signal.Mailbox Bool
playBeepMailbox =
  Signal.mailbox False


playBeepTask : Task x ()
playBeepTask =
  Signal.send playBeepMailbox.address True


playBeepEffect : Effects Action
playBeepEffect =
  Effects.map (always Noop) (Effects.task playBeepTask)


---- APP ----

app : StartApp.App Model
app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


main : Signal Html
main =
  app.html


port tasks : Signal (Task Effects.Never ())
port tasks = app.tasks

