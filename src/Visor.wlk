import wollok.game.*
import Personaje.*
import Nivel.*

class Visor {

	method image() {
		return "visor-puntaje.png"
	}

	method position()

	method textColor() = "#ffffff"

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
	}

	method colision(objecto) {
	}

}

object visorVida inherits Visor {

	override method position() = new Posicion(x = 5, y = 14)

	override method image() {
		return if (mandalorian.vida().equals(2)) {
			"dos-vidas.png"
		} else {
			"una-vida.png"
		}
	}

	override method aparecer() {
		game.addVisual(self)
	}

}

object visorPuntos inherits Visor {

	override method position() {
		return new Posicion(x = 10, y = 14)
	}

	method text() {
		return "      " + mandalorian.score().toString()
	}

}

class Teleport {

	var property xTP
	var property yTP
	var property nivel
	var property posX
	var property posY
	var property image = "void.png"

	method position() = new Posicion(x = xTP, y = yTP)

	method colision(objeto) {
		game.clear()
		nivelDos.iniciar()
		self.cambiarPosicion(objeto)
	}

	method cambiarPosicion(personaje) {
		personaje.position().x(posX)
		personaje.position().y(posY)
	}

	method esColisionable() = true

}

const tpNivel2 = new Teleport(xTP = 10, yTP = 10, nivel = nivelDos, posX = 5, posY = 8)

class Posicion {

	var property x = 0
	var property y = 0

	method right(n) = new Posicion(x = x + n, y = y)

	method left(n) = new Posicion(x = x - n, y = y)

	method up(n) = new Posicion(x = x, y = y + n)

	method down(n) = new Posicion(x = x, y = y - n)

}

