import wollok.game.*
import extras.*
import Background.*
import Direccion.*
import Inamovible.*
import Personaje.*
import Visor.*

class Nivel {

	method agregarFondo()

	method puntosRequeridos()

	method siguienteNivel()

	method puedeIrASiguienteNivel() = mandalorian.score() >= self.puntosRequeridos()

	method agregarCajas() {
		// CAJAS DEL CENTRO
		caja1.aparecer()
		caja2.aparecer()
		caja3.aparecer()
		caja4.aparecer()
			// CAJAS DE CRUZ ESQUINA SUPERIOR IZQUIERDA
		caja5.aparecer()
		caja6.aparecer()
		caja7.aparecer()
		caja8.aparecer()
			// CAJAS DE CRUZ ESQUINA INFERIOR IZQUIERDA
		caja9.aparecer()
		caja10.aparecer()
		caja11.aparecer()
		caja12.aparecer()
			// CAJAS DE CRUZ ESQUINA INFERIOR DERECHA
		caja13.aparecer()
		caja14.aparecer()
		caja15.aparecer()
		caja16.aparecer()
			// CAJAS DE CRUZ ESQUINA SUPERIOR DERECHA
		caja17.aparecer()
		caja18.aparecer()
		caja19.aparecer()
		caja20.aparecer()
	}

	method agregarControles() {
		keyboard.up().onPressDo({ mandalorian.mover(arriba)})
		keyboard.down().onPressDo({ mandalorian.mover(abajo)})
		keyboard.left().onPressDo({ mandalorian.mover(izquierda)})
		keyboard.right().onPressDo({ mandalorian.mover(derecha)})
		keyboard.z().onPressDo({ mandalorian.dispararSiPuede()})
	}

	method agregarVisores() {
		visorScore.aparecer()
		visorNivel.aparecer()
		visorPuntosRequeridos.aparecer()
		visorVida.aparecer()
	}

	method agregarVisualesEscenario() {
		self.agregarFondo()
		self.agregarVisores()
		bomba.aparecer()
	}

	method agregarVisualesPersonajes() {
		cadete.aparecer()
		mandalorian.aparecer()
	}

	method iniciar() {
		game.clear()
		self.agregarControles()
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
	}

}

object nivelUno inherits Nivel {

	override method puntosRequeridos() = 1

	override method siguienteNivel() = nivelDos

	override method agregarFondo() {
		fondoNivelUno.aparecer()
	}

	override method agregarVisualesEscenario() {
		super()
		self.agregarCajas()
		portal.aparecer()
	}

}

object nivelDos inherits Nivel {

	override method puntosRequeridos() = 1 // 20

	override method siguienteNivel() = nivelTres

	override method agregarFondo() {
		fondoNivelDos.aparecer()
	}

	override method agregarVisualesEscenario() {
		super()
		self.agregarCajas()
		portal.aparecer()
	}

	override method agregarCajas() {
		super()
			// HILERA ARRIBA
		caja21.aparecer()
		caja22.aparecer()
		caja23.aparecer()
			// HILERA ABAJO
		caja24.aparecer()
		caja25.aparecer()
		caja26.aparecer()
			// HILERA IZQUIERDA
		caja27.aparecer()
		caja28.aparecer()
		caja29.aparecer()
		caja30.aparecer()
			// HILERA DERECHA
		caja31.aparecer()
		caja32.aparecer()
		caja33.aparecer()
		caja34.aparecer()
	}

}

object nivelTres inherits Nivel {

	override method puntosRequeridos() = 30

	override method siguienteNivel() = self

	override method agregarFondo() {
		fondoNivelTres.aparecer()
	}

}

