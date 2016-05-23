port module PokerClock exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as Html
import String exposing (padLeft)
import Task exposing (Task)
import Time exposing ( every, second )


---- MODEL ----

type alias Model =
  { seconds : Int
  , isPaused : Bool
  }


init : ( Model, Cmd Message )
init =
  ( Model 900 True, Cmd.none )


---- UPDATE ----

type Message = Tick | Noop | TogglePause | RestartClock


update : Message -> Model -> ( Model, Cmd Message )
update message model =
  let
    playBeepIfZero =
      if model.seconds - 1 == 0
        then playBeep True
        else Cmd.none

    decrementWhenNotPaused =
      if model.isPaused
        then model
        else
          { model | seconds = clamp 0 900 (model.seconds - 1) }
  in
    case message of
      Tick -> ( decrementWhenNotPaused, playBeepIfZero )
      Noop -> ( model, Cmd.none )
      TogglePause -> ( { model | isPaused = not model.isPaused }, playBeep False )
      RestartClock -> ( { model | seconds = 900, isPaused = False }, playBeep False )


---- VIEW ----

view : Model -> Html Message
view model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text (formatTime model.seconds) ]
    , button [ onClick TogglePause ] [ text <| if model.isPaused then "Play" else "Pause" ]
    , button [ onClick RestartClock ] [ text "Restart" ]
    ]


formatTime : Int -> String
formatTime seconds =
  let
    min = toString <| seconds // 60
    sec = padLeft 2 '0' <| toString <| seconds % 60
  in
    min ++ ":" ++ sec


---- INPUTS ----

subscriptions : Model -> Sub Message
subscriptions _ =
  every second (always Tick)


---- OUTPUTS ----

port playBeep : Bool -> Cmd message


---- APP ----

main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }
