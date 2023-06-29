import wollok.game.*
import extras.*
import Background.*
import Direccion.*
import EnemigoFactory.*
import Inamovible.*
import Personaje.*
import Visor.*

class Nivel {

	const property personajes = []
	var property cantMaxEnemigosSoportados

	method agregarFondo()

	method puntosRequeridos()

	method siguienteNivel()

	method cantidadEnemigosActivos() = personajes.size()

	method nroSerialGenerador() = self.identity().toString()

	method puedeIrASiguienteNivel() = mandalorian.score() >= self.puntosRequeridos()

	method agregarCajas() {
		// CAJAS DEL CENTRO
		caja1.aparecer()
		caja2.aparecer()
			// caja3.aparecer()
			// caja4.aparecer()
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
		keyboard.up().onPressDo({ mandalorian.moverSiPuede(arriba)})
		keyboard.down().onPressDo({ mandalorian.moverSiPuede(abajo)})
		keyboard.left().onPressDo({ mandalorian.moverSiPuede(izquierda)})
		keyboard.right().onPressDo({ mandalorian.moverSiPuede(derecha)})
		keyboard.z().onPressDo({ mandalorian.realizarAccionSiPuede()})
	}

	method agregarEnemigo(enemigo) {
		personajes.add(enemigo)
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
		plataforma.aparecer()
	}

	method agregarVisualesPersonajes() {
		game.onTick(3000, self.nroSerialGenerador(), { trooperCadeteFactory.generarPara(self)})
		game.onTick(2000, self.nroSerialGenerador(), { trooperSargentoFactory.generarPara(self)})
		mandalorian.aparecer()
	}

	method iniciar() {
		game.clear()
		personajes.clear()
		self.agregarControles()
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
	}

	method removerEnemigo(enemigo) {
		personajes.remove(enemigo)
	}

	method removerEvento() {
		game.removeTickEvent(self.nroSerialGenerador())
		personajes.forEach{ personaje => personaje.desaparecer()}
	}

}

object nivelUno inherits Nivel(cantMaxEnemigosSoportados = 4) {

	override method puntosRequeridos() = 3

	override method siguienteNivel() = nivelDos

	override method agregarFondo() {
		fondoNivelUno.aparecer()
	}

	override method agregarVisualesEscenario() {
		super()
		self.agregarCajas()
		portal.aparecer()
	}

	override method agregarVisualesPersonajes() {
		game.onTick(4000, self.nroSerialGenerador(), { trooperCadeteFactory.generarPara(self)})
		super()
	}

}

object nivelDos inherits Nivel(cantMaxEnemigosSoportados = 6) {

	override method puntosRequeridos() = 5

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

object nivelTres inherits Nivel(cantMaxEnemigosSoportados = 6) {

	override method puntosRequeridos() = 20

	override method siguienteNivel() = self

	override method agregarFondo() {
		fondoNivelTres.aparecer()
	}

	override method agregarVisualesPersonajes() {
		game.onTick(2000, self.nroSerialGenerador(), { lordSithFactory.generarPara(self)})
		mandalorian.aparecer()
	}

}

