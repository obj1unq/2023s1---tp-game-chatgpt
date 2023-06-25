import wollok.game.*
import StarWarsObject.*

class Caja inherits StarWarsObject {

	override method image() = "caja.png"

	override method esColisionable() = false

	override method colision(objeto) {
	}

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => console.println("CAJA:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

}

class Bomba inherits StarWarsObject {

	var property estado = armada

	override method image() = estado.image()

	override method colision(objeto) {
	}

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => console.println("BOMBA:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method danio() = 2

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

class ObjectInteratuable {

}

