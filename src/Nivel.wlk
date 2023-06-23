import wollok.game.*
import extras.*
import Direccion.*
import Personaje.*
import Obstaculo.*
import Posicion.*
import EnemigoFactory.*
import Visor.*

class Nivel {

	method agregarControles() {
		keyboard.up().onPressDo({ heroe.mover(arriba)})
		keyboard.down().onPressDo({ heroe.mover(abajo)})
		keyboard.left().onPressDo({ heroe.mover(izquierda)})
		keyboard.right().onPressDo({ heroe.mover(derecha)})
		keyboard.z().onPressDo({ heroe.accion()})
	}

	method agregarVisualesEscenario()

	method agregarVisualesPersonajes()

	method iniciar()

}

object nivelUno inherits Nivel {

	override method agregarVisualesEscenario() {
		background.fondo("nivel1")
		background.aparecer()
		visorVida.aparecer()
		visorNivel.aparecer()
		visorPuntos.aparecer()
	}

	override method agregarVisualesPersonajes() {
		heroe.aparecer()
		game.onTick(1000, self.nombreGeneradorEnemigos(), { trooperFactory.generar()})
	}

	override method iniciar() {
		mainMenu.finalizar()
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
		self.agregarControles()
		heroe.puntos(0)
	}

	method nombreGeneradorEnemigos() {
		return self.identity().toString()
	}

}

const caja1 = new Obstaculo(position = new Posicion(x = 5, y = 5))

object portal {

	const property position = new Posicion(x = 14, y = 10)

	method image() {
		return "background-portal.png"
	}

	method aparecer() {
		game.addVisual(self)
	}

}

