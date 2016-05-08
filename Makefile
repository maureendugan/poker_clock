default:
	elm make PokerClock.elm --output public/PokerClock.js

deploy:
	firebase deploy
