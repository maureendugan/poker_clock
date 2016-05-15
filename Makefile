default:
	bin/elm-make PokerClock.elm --yes --output public/PokerClock.js

deploy:
	bin/firebase deploy

setup:
	npm install
