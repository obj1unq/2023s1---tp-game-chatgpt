import wollok.game.*
import extras.*
import portal.*
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
		portal.aparecer()
	}

	method agregarVisualesPersonajes() {
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

}

object nivelUno inherits Nivel(cantMaxEnemigosSoportados = 2) {

	method cajasDeNivel() = [ caja1, caja2, caja5, caja6, caja7, caja8, caja9, caja10, caja11, caja12, caja13, caja14, caja15, caja16, caja17, caja18, caja19, caja20 ]

	override method puntosRequeridos() = 3

	override method siguienteNivel() = nivelDos

	override method agregarFondo() {
		fondoNivelUno.aparecer()
	}

	override method agregarVisualesEscenario() {
		super()
		self.agregarCajas()
	}

	method agregarCajas() {
		self.cajasDeNivel().forEach{ caja => caja.aparecer()}
	}

	override method agregarVisualesPersonajes() {
		game.onTick(4000, self.nroSerialGenerador(), { trooperSargentoFactory.generarPara(self)})
		super()
	}

}

object nivelDos inherits Nivel(cantMaxEnemigosSoportados = 6) {

	method cajasDeNivel() = [ caja1, caja2, caja5, caja6, caja7, caja8, caja9, caja10, caja11, caja12, caja13, caja14, caja15, caja16, caja17, caja18, caja19, caja20, caja21, caja22, caja23, caja24, caja25, caja26, caja27, caja28, caja29, caja30, caja31, caja32, caja33, caja34 ]

	override method puntosRequeridos() = 4

	override method siguienteNivel() = nivelTres

	override method agregarFondo() {
		fondoNivelDos.aparecer()
	}

	override method agregarVisualesEscenario() {
		super()
		self.agregarCajas()
	}

	method agregarCajas() {
		self.cajasDeNivel().forEach{ caja => caja.aparecer()}
	}

	override method agregarVisualesPersonajes() {
		game.onTick(4000, self.nroSerialGenerador(), { trooperSargentoFactory.generarPara(self)})
		super()
	}

}

object nivelTres inherits Nivel(cantMaxEnemigosSoportados = 6) {

	override method puntosRequeridos() = 100

	override method siguienteNivel() = gameWin

	override method agregarFondo() {
		fondoNivelTres.aparecer()
	}

	override method agregarVisualesPersonajes() {
		game.onTick(2000, self.nroSerialGenerador(), { lordSithFactory.generarPara(self)})
		darthVader.aparecer()
		mandalorian.aparecer()
	}

}

