import wollok.game.*
import Direccion.*
import Personaje.*
import Obstaculo.*

object starsWarsGame {

	method iniciar() {
		nivelUno.iniciar()
	}

}

class Nivel {

	const property personaje
	const property enemigos = []

	method agregarEnemigos()

	method agregarControles() {
		keyboard.up().onPressDo({ personaje.mover(arriba)})
		keyboard.down().onPressDo({ personaje.mover(abajo)})
		keyboard.left().onPressDo({ personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.z().onPressDo({ personaje.accion()})
	}

	method agregarVisualesPersonajes()

	method agregarVisualesEscenario()

	method iniciar()

}

object nivelUno inherits Nivel(personaje = mandalorian) {

	override method iniciar() {
		// background.fondo("nivel1")
		// game.addVisual(background)
		game.boardGround("background-nivel1.png")
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
		self.agregarControles()
		self.agregarEnemigos()
		game.start()
	}

	override method agregarVisualesPersonajes() {
		tropperCadete.aparecer()
		tropperSargento.aparecer()
		mandalorian.aparecer()
	}

	override method agregarVisualesEscenario() {
		game.addVisual(new Obstaculo(position = game.at(10, 5)))
		game.addVisual(new Obstaculo(position = game.at(7, 5)))
		game.addVisual(new Obstaculo(position = game.at(7, 13)))
		game.addVisual(new Obstaculo(position = game.at(7, 14)))
	}

	override method agregarEnemigos() {
		tropperCadete.disparoSecuencial()
		tropperSargento.disparoSecuencial()
	}

}

object factoryEnemigos {

}

object background {

	var property position = game.at(2, 2)
	var property fondo = null

	method image() {
		return "background-" + fondo + ".png"
	}

}

object gameOver {

	method fondo() {
		background.fondo("yodaGameOver")
		background.position(game.at(0, 0))
		game.addVisual(background)
	}

}

const mandalorian = new Heroe(position = game.at(5, 5), alcanceDisparo = 5, direccionMovimiento = abajo)

const tropperCadete = new Tropper(position = game.at(2, 5), alcanceDisparo = 5, direccionMovimiento = abajo, rango = "cadete")

const tropperSargento = new Tropper(position = game.at(1, 4), alcanceDisparo = 5, direccionMovimiento = abajo, rango = "sargento")

