import wollok.game.*
import Personaje.*
import Direccion.*
import Obstaculo.*

object starsWarsGame {

	method iniciar() {
		const mandalorian = new Heroe(position = game.at(2, 3), alcanceDisparo = 5, direccionMovimiento = abajo)
		const tropper = new Tropper(position = game.at(3, 4), alcanceDisparo = 5, direccionMovimiento = abajo)
		self.agregarConfiguracion()
		self.agregarControles(mandalorian)
		self.agregarVisualesEscenario()
		tropper.disparoSecuencial()
		game.ground("fondo.png")
		tropper.aparecer()
		mandalorian.aparecer()
		game.start()
	}

	method agregarConfiguracion() {
		game.title("Star Wars Game")
		game.height(15)
		game.width(15)
	}

	method agregarControles(personaje) {
		keyboard.up().onPressDo({ personaje.mover(arriba)})
		keyboard.down().onPressDo({ personaje.mover(abajo)})
		keyboard.left().onPressDo({ personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.z().onPressDo({ personaje.accion()})
	}

	method agregarVisualesEscenario() {
		game.addVisual(new Obstaculo(position = game.at(10, 5)))
		game.addVisual(new Obstaculo(position = game.at(7, 5)))
		game.addVisual(new Obstaculo(position = game.at(7, 13)))
	}

}

