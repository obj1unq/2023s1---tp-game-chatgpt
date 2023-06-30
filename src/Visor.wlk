import wollok.game.*
import Enemigo.*
import Personaje.*
import PosicionMutable.*

class Visor {

	var property position

	method image() = "visor.png"

	method textColor() = "#FFFFFF1"

	method aparecer() {
		game.addVisual(self)
	}

}

object visorScore inherits Visor(position = new PosicionMutable(x = 2, y = 14)) {

	method text() = "     " + mandalorian.score().toString()

}

object visorNivel inherits Visor(position = new PosicionMutable(x = 10, y = 14)) {

	override method image() = mandalorian.nivelDondeSeEncuentra().toString() + ".png"

}

object visorPuntosRequeridos inherits Visor (position = new PosicionMutable(x = 15, y = 14)) {

	override method image() = "visorPuntosDeNivel.png"

	method text() = "                " + mandalorian.nivelDondeSeEncuentra().puntosRequeridos().toString()

	override method textColor() = "#FFFFFF"

	override method aparecer() {
		super()
		game.addVisual(puntosRequeridosPorNivel)
	}

}

object visorVida inherits Visor(position = new PosicionMutable(x = 19, y = 14)) {

	override method image() = if (mandalorian.vida().equals(2)) "mandalorian-dos-vidas.png" else "mandalorian-una-vida.png"

}

object puntosRequeridosPorNivel {

	method image() = "visorPuntosDeNivel.png"

	method position() = new PosicionMutable(x = 14, y = 14)

	method text() = "           PtosNivel"

	method textColor() = "#FFFFFF"

}

object barraDeVida {

	method esColisionable() = true

	method image() = "vida-" + darthVader.vida() + ".png"

	method position() = new PosicionMutable(x = darthVader.position().x(), y = darthVader.position().y() + 1)

	method aparecer() {
		game.addVisual(self)
	}

	method colision(objeto) {
	}

}

