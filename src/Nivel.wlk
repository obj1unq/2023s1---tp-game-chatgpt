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

	method reproducirMusica() {
		const sonido = new Sound(file = "musica-nivelUno.mp3")
		game.schedule(1000, { => sonido.play()})
	}

	method detenerMusica() {
		sonidoInicio.stop()
	}

}

object nivelUno inherits Nivel(cantMaxEnemigosSoportados = 4) {

	method cajasDeNivel() = [ caja1, caja2, caja5, caja6, caja7, caja8, caja9, caja10, caja11, caja12, caja13, caja14, caja15, caja16, caja17, caja18, caja19, caja20 ]

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

	method agregarCajas() {
		self.cajasDeNivel().forEach{ caja => caja.aparecer()}
	}

	override method agregarVisualesPersonajes() {
		game.onTick(4000, self.nroSerialGenerador(), { trooperCadeteFactory.generarPara(self)})
		super()
	}

	override method iniciar() {
		starWarsGame.detenerMusica()
		super()
		self.reproducirMusica()
	}

	override method reproducirMusica() {
		game.schedule(1000, { => self.sonido().play()})
	}

	override method detenerMusica() {
		self.sonido().stop()
	}

	method sonido() = new Sound(file = "musica-nivelUno.mp3")

}

object nivelDos inherits Nivel(cantMaxEnemigosSoportados = 4) {

	method cajasDeNivel() = [ caja1, caja2, caja5, caja6, caja7, caja8, caja9, caja10, caja11, caja12, caja13, caja14, caja15, caja16, caja17, caja18, caja19, caja20, caja21, caja22, caja23, caja24, caja25, caja26, caja27, caja28, caja29, caja30, caja31, caja32, caja33, caja34 ]

	override method puntosRequeridos() = 1

	override method siguienteNivel() = nivelTres

	override method agregarFondo() {
		fondoNivelDos.aparecer()
	}

	override method agregarVisualesEscenario() {
		super()
		self.agregarCajas()
		portal.aparecer()
	}

	method agregarCajas() {
		self.cajasDeNivel().forEach{ caja => caja.aparecer()}
	}

	override method agregarVisualesPersonajes() {
		game.onTick(2000, self.nroSerialGenerador(), { trooperCadeteFactory.generarPara(self)})
		game.onTick(2000, self.nroSerialGenerador(), { trooperSargentoFactory.generarPara(self)})
		super()
	}

	override method iniciar() {
		nivelUno.detenerMusica()
		super()
		self.reproducirMusica()
	}

	override method reproducirMusica() {
		game.schedule(1000, { => sonidoNivelDos.play()})
	}

	override method detenerMusica() {
		sonidoNivelDos.stop()
	}

}

object nivelTres inherits Nivel(cantMaxEnemigosSoportados = 2) {

	method cajasDeNivel() = [ caja1, caja2, caja5, caja6, caja7, caja8, caja9, caja10, caja11, caja12, caja13, caja14, caja15, caja16, caja17, caja18, caja19, caja20 ]

	override method puntosRequeridos() = 100

	override method siguienteNivel() = self

	override method agregarFondo() {
		fondoNivelTres.aparecer()
	}

	override method agregarVisualesPersonajes() {
		game.onTick(2000, self.nroSerialGenerador(), { lordSithFactory.generarPara(self)})
		darthVader.aparecer()
		super()
	}

	override method iniciar() {
		nivelDos.detenerMusica()
		super()
		self.reproducirMusica()
	}

	override method reproducirMusica() {
		game.schedule(1000, { => sonidoNivelTres.play()})
	}

	override method detenerMusica() {
		sonidoNivelTres.stop()
	}

}

