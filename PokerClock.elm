module PokerClock where

import Html exposing (..)


main : Html
main =
  div []
    [ h1 [] [text "Poker Clock"]
    , h2 [] [text "00:00"]
    , button [] [text "Play"]
    , button [] [text "Pause"]
    ]
