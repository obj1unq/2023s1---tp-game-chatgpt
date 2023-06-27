import wollok.game.*

class StarWarsObject {

	var property position

	method image()

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		game.removeVisual(self)
	}

}

