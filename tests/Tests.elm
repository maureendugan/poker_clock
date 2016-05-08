module Tests where

import Effects
import ElmTest exposing (..)
import PokerClock
import String


all : Test
all =
  suite "A Test Suite"
    [ test "formatSections" <|
      assertEqual "900" <| PokerClock.formatSeconds 900
    ]

