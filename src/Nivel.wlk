import wollok.game.*
import Direccion.*
import StarWarsObject.*
import Personaje.*
import Inamovible.*
import Visor.*

object mainMenu {

	method iniciar() {
		fondoInicio.aparecer()
		keyboard.space().onPressDo({ nivelUno.iniciar()})
	}

}

class Nivel {

	const property puntosRequeridos

	method iniciar()

	method reiniciar()

	method agregarControles() {
		keyboard.up().onPressDo({ mandalorian.mover(arriba)})
		keyboard.down().onPressDo({ mandalorian.mover(abajo)})
		keyboard.left().onPressDo({ mandalorian.mover(izquierda)})
		keyboard.right().onPressDo({ mandalorian.mover(derecha)})
		keyboard.z().onPressDo({ mandalorian.disparar()})
	}

	method agregarVisualesEscenario() {
		portal.aparecer()
		bomba.aparecer()
		visorVida.aparecer()
		visorPuntos.aparecer()
		caja1.aparecer()
	}

	method agregarVisualesPersonajes() {
		mandalorian.aparecer()
		cadete.aparecer()
		cadete1.aparecer()
		cadete2.aparecer()
	}

	method puedeIrASiguienteNivel(heroe) = heroe.score() >= puntosRequeridos

	method IrASiguienteNivelPara(personaje) {
	}

}

object nivelUno inherits Nivel(puntosRequeridos = 4) {

	override method iniciar() {
		fondoInicio.desaparecer()
		self.reiniciar()
	}

	override method reiniciar() {
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
			// game.onTick(2000, "", { self.IrASiguienteNivelPara(mandalorian)})
		self.agregarControles()
	}

	override method IrASiguienteNivelPara(heroe) {
		if (self.puedeIrASiguienteNivel(heroe)) {
		// cadete.desaparecer()
		}
	}

	override method agregarVisualesEscenario() {
		fondoNivelUno.aparecer()
			// game.addVisual(tpNivel2)
		super()
	}

}

object nivelDos inherits Nivel(puntosRequeridos = 4) {

	override method iniciar() {
		self.reiniciar()
	}

	override method reiniciar() {
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
		game.onTick(2000, "", { self.IrASiguienteNivelPara(mandalorian)})
		self.agregarControles()
	}

	override method IrASiguienteNivelPara(heroe) {
		if (self.puedeIrASiguienteNivel(heroe)) {
			cadete.desaparecer()
		}
	}

	override method agregarVisualesEscenario() {
		fondoNivelDos.aparecer()
		super()
	}

}

class Background {

	var property position = new Posicion(x = 0, y = 0)
	var property fondo = null

	method image() {
		return "background-" + fondo + ".png"
	}

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		game.removeVisual(self)
	}

}

object gameOver {

	method finalizarJuego() {
		game.clear()
		fondoGameOver.aparecer()
		mandalorian.reiniciarEstado()
		keyboard.r().onPressDo({ nivelUno.reiniciar()})
	// TODO: COMO HACER PARA QUE NO SE PUEDA USAR DE NUEVO, UNA VEZ QUE REINICIAS EL NIVEL?
	}

}

object portal inherits StarWarsObject(position = new Posicion(x = 10, y = 10)) {

	override method image() = "portal-" + self.estado() + ".png"

	method estado() {
		return if (mandalorian.consiguioLosPuntos()) {
			"activo"
		} else "inactivo"
	}

	override method colision(objeto) {
		tpNivel2.colision(objeto)
	}

}

const cadete = new TrooperCadete(position = new Posicion(x = 7, y = 7), direccionDondeMira = abajo)

const cadete1 = new TrooperCadete(position = new Posicion(x = 10, y = 7), direccionDondeMira = abajo)

const cadete2 = new TrooperCadete(position = new Posicion(x = 7, y = 10), direccionDondeMira = abajo)

const caja = new Caja(position = new Posicion(x = 7, y = 9))

const caja1 = new Caja(position = new Posicion(x = 7, y = 5))

const bomba = new Bomba(position = new Posicion(x = 4, y = 4))

const fondoInicio = new Background(fondo = "inicio")

const fondoNivelUno = new Background(fondo = "nivel1")

const fondoNivelDos = new Background(fondo = "nivel2")

const fondoGameOver = new Background(fondo = "gameOver")

