import Effects
import Html exposing (Html)
import Task exposing (Task)
import PokerClock


port tasks : Signal (Task Effects.Never ())
port tasks = PokerClock.tasks


port playBeep : Signal Bool
port playBeep = PokerClock.playBeepSignal


main : Signal Html
main = PokerClock.html

