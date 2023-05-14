import wollok.game.*
import jugador.*
import Direction.*
import objetosInmoviles.*

object starsWarsGame {

	method iniciar() {
		self.agregarConfiguracion()
		self.agregarVisuales()
		self.agregarControles()
		game.start()
	}

	method agregarConfiguracion() {
		game.title("Star Wars Game")
		game.height(15)
		game.width(30)
	}

	method agregarControles() {
		keyboard.up().onPressDo({ personaje.mover(arriba)})
		keyboard.down().onPressDo({ personaje.mover(abajo)})
		keyboard.left().onPressDo({ personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.z().onPressDo({ personaje.disparar()})
	}

	method agregarVisuales() {
		game.addVisual(new Caja(position = game.at(10, 5)))
		game.addVisual(new Caja(position = game.at(7, 5)))
		game.addVisual(new Caja(position = game.at(7, 13)))
		game.addVisual(new Disparo(position = game.at(14, 7), direccion = izquierda))
		game.addVisual(personaje)
	}

}

