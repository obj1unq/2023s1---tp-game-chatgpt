import wollok.game.*
import Personaje.*
import Direccion.*
import objetosInmoviles.*

object starsWarsGame {

	method iniciar() {
		const mandalorian = new Heroe(position = game.at(2, 2), alcanceDisparo = 5)
		const tropper = new Tropper(position = game.center(), alcanceDisparo = 5)
		self.agregarConfiguracion()
		self.agregarControles(mandalorian)
		self.agregarVisualesEscenario()
		tropper.disparoSecuencial()
		game.addVisual(mandalorian)
		game.addVisual(tropper)
		game.ground("fondo.png")
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
		keyboard.d().onPressDo({ personaje.accion()})
	}

	method agregarVisualesEscenario() {
		game.addVisual(new Caja(position = game.at(10, 5)))
		game.addVisual(new Caja(position = game.at(7, 5)))
		game.addVisual(new Caja(position = game.at(7, 13)))
	}

}

