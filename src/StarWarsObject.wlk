import wollok.game.*

class StarWarsObject {

	var property position
	var property esColisionable = true

	method colision(objeto)

	method esColisionable()

	method image()

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		game.removeVisual(self)
	}

}

