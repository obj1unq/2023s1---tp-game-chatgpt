import wollok.game.*
import extras.*
import Direccion.*
import Nivel.*
import PosicionMutable.*

object mandalorian {

	var property direccionDondeMira = abajo
	var property score = 0
	var property vida = 2
	var property nivelDondeSeEncuentra = nivelUno
	var property position = new PosicionMutable(x = 10, y = 7)

	method cumplioLaMision() = nivelDondeSeEncuentra.puedeIrASiguienteNivel()

	method cambiarDeNivel(_nivel) {
		nivelDondeSeEncuentra = _nivel
	}

	method esColisionable() = true

	method aparecer() {
		game.addVisual(self)
		game.onCollideDo(self, { objeto => console.println("MANDALORIAN:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method desaparecer() {
	}

	method reiniciarEstado() {
		self.position(new PosicionMutable(x = 14, y = 7))
		self.score(0)
		self.vida(2)
	}

	method image() = "mandalorian-" + direccionDondeMira.toString() + ".png"

	method colision(objeto) {
	// self.desaparecer()
	// gameOver.finalizarJuego()
	}

	method mover(direccion) {
		direccion.mover(self)
		self.direccionDondeMira(direccion)
	}

	method sumarScore(_score) {
		score += _score
	}

}

class Trooper {

	var property direccionDondeMira = abajo
	var property position = new PosicionMutable(x = 2, y = 2)

	method aparecer() {
		game.addVisual(self)
		game.onCollideDo(self, { objeto => console.println("TROOPER:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method sufijo()

	method colision(objeto) {
		mandalorian.sumarScore(2)
	}

	method image() = "trooper-" + self.sufijo() + direccionDondeMira.toString() + ".png"

	method esColisionable() = true

}

class TrooperCadete inherits Trooper {

	override method sufijo() = "cadete-"

}

const cadete = new TrooperCadete()

