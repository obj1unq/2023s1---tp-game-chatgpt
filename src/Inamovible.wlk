import wollok.game.*

class Inamovible {

	var property position

	method image()

	method aparecer() {
		game.addVisual(self)
	}

	method esColisionable()

	method colision(objeto) {
	}

}

class Caja inherits Inamovible {

	override method image() = "caja.png"

	override method esColisionable() = false

	override method colision(objeto) {
	}

}

class Bomba inherits Inamovible {

	var property estado = armada

	override method image() = estado.image()

	override method esColisionable() = true

	override method colision(objeto) {
	}

}

object armada {

	method image() = "bomba.png"

}

object explosion {

	method image() = "explosion.png"

}

const caja = new Caja(position = game.at(7, 9))

const caja1 = new Caja(position = game.at(7, 5))

const bomba = new Bomba(position = game.at(4, 4))

