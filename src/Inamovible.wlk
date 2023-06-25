import wollok.game.*
import StarWarsObject.*
import Visor.*

class Caja inherits StarWarsObject {

	override method image() = "caja.png"

	override method esColisionable() = false

	override method colision(objeto) {
	}

	method interactuarCon(objeto) {
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

	method impactasteConMandalorian(objeto) {
		objeto.interactuarConBomba()
	}

	method impactasteConTrooper(objeto) {
	}

	override method aparecer() {
		game.addVisual(self)
	}

	method danio() = 2

}

object armada {

	method image() = "bomba.png"

}

object explosion {

	method image() = "explosion.png"

}

