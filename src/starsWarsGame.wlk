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
		keyboard.w().onPressDo({ personaje.mover(arriba)})
		keyboard.s().onPressDo({ personaje.mover(abajo)})
		keyboard.a().onPressDo({ personaje.mover(izquierda)})
		keyboard.d().onPressDo({ personaje.mover(derecha)})
	}

	method agregarVisuales() {
		game.addVisual(new Caja(position = game.at(10, 5)))
		game.addVisual(new Caja(position = game.at(7, 5)))
		game.addVisual(new Caja(position = game.at(7, 13)))
		game.addVisual(personaje)
	}

}

