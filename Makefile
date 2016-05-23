default:
	bin/elm-make PokerClock.elm --yes --output public/PokerClock.js

deploy:
	make &&	bin/firebase deploy

setup:
	npm install
