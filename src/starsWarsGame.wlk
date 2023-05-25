import wollok.game.*
import Personaje.*
import Direccion.*
import Obstaculo.*

object starsWarsGame {

	method iniciar() {
		const mandalorian = new Heroe(position = game.at(5, 5), alcanceDisparo = 5, direccionMovimiento = abajo)
		const tropper = new Tropper(position = game.at(1, 4), alcanceDisparo = 5, direccionMovimiento = derecha)
		const tropper2 = new Tropper(position = game.at(12, 4), alcanceDisparo = 5, direccionMovimiento = izquierda)
		
		self.agregarConfiguracion()
		self.agregarControles(mandalorian)
		self.agregarVisualesEscenario()
		tropper.disparoSecuencial()		// Dispara cada 25 ms y se mueve aleatoriamente
		tropper2.disparoSecuencial()	// Dispara cada 25 ms y se mueve aleatoriamente
		
		game.ground("fondo.png")
		tropper.aparecer()
		tropper2.aparecer()				// TODO si se disparan, se matan, pero sigue disparando
		
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

