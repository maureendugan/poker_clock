module PokerClock where

import Audio
import Effects
import Html exposing (..)
import Html.Events exposing (..)
import StartApp
import String
import Time exposing ( every, second )


app : StartApp.App Model
app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


main : Signal Html
main =
  app.html


init : ( Model, Effects.Effects Action )
init =
  ( initialModel, Effects.none )


type alias Model = { counter : Int, isPaused : Bool }

initialModel : Model
initialModel =
  { counter = 10
  , isPaused = False
  }


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ text "Poker Clock" ]
    , h2 [] [ text (formatSeconds model.counter) ]
    , button [ onClick address Toggle ]
      [ text (if model.isPaused then "Play" else "Pause") ]
    ]


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  let
    updatedModel =
      case action of
        Noop ->
          model

        Decrement ->
          if model.isPaused
            then model
            else { model | counter = model.counter - 1 }

        Toggle ->
          { model | isPaused = not model.isPaused }

    updatedEffects =
      if model.counter % 2 == 0
        then Signal.send audioActionMailbox.address Audio.Play |> Effects.task |> Effects.map (always Noop)
        else Effects.none

  in
    ( updatedModel, updatedEffects )


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
  [ Signal.map (always Decrement) (every second)
  , Signal.map (\s -> always Noop (Debug.log "omg" s)) audioSignal
  ]


type Action = Decrement | Toggle | Noop


audioActionMailbox : Signal.Mailbox Audio.Action
audioActionMailbox =
  Signal.mailbox Audio.NoChange


audioSignal : Signal ( Audio.Event, Audio.Properties )
audioSignal =
  Audio.audio
    { src = "snd/theme.mp3"
    , triggers = { timeupdate = True, ended = True }
    , propertiesHandler = always Nothing
    , actions = audioActionMailbox.signal
    }


-- To Dos: 
-- 1) Add logic to handle model = 0; It should make a noise, hold at zero
-- 2) Implement restart/refresh button
-- 3) Implement pause
