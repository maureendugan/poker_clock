default:
	bin/elm-make PokerClock.elm --output public/PokerClock.js

deploy:
	bin/firebase deploy

setup:
	npm install
