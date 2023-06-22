import wollok.game.*
import Posicion.*
import extras.*
import Personaje.*

class Visor {

	method image() {
		return "visor.png"
	}

	method position()

	method textColor() = "#ffffff"

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
	}

}

object visorVida inherits Visor {

	override method position() {
		return new Posicion(x = 5, y = 14)
	}

	method text() {
		return "          VIDAS: " + heroe.vida().toString()
	}

}

object visorNivel inherits Visor {

	override method position() {
		return new Posicion(x = 2, y = 14)
	}

	method text() {
		return "         NIVEL: " + heroe.nivel().toString()
	}

}

object visorPuntos inherits Visor {

	override method position() {
		return new Posicion(x = 10, y = 14)
	}

	method text() {
		return "           SCORE: " + heroe.puntos().toString()
	}

}

