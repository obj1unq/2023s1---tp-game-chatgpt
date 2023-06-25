import wollok.game.*
import Direccion.*
import Laser.*
import EstadoPersonaje.*
import StarWarsObject.*
import Nivel.*
import Visor.*

class Personaje inherits StarWarsObject {

	var property direccionDondeMira
	var property alcanceDisparo = 3

	method disparar()

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

}

object mandalorian inherits Personaje(position = new Posicion(x = 3, y = 3), direccionDondeMira = abajo) {

	var property estado = vivo
	var property vida = 2
	var property score = 0
	var property nivelDondeEsta = nivelUno

	override method image() = "mandalorian-" + direccionDondeMira.toString() + ".png"

	override method colision(objeto) {
	}

	method impactarConLaserAzul(laser) {
	}

	method impactarConLaserRojo(laser) {
		self.restarVida(laser.danio())
		self.verificarEstado()
	}

	method verificarEstado() {
		if (vida <= 0) {
			self.estado(muerto)
			gameOver.finalizarJuego()
		}
	}

	override method desaparecer() {
	}

	override method mover(direccion) {
		estado.mover(self, direccion)
	}

	override method disparar() {
		estado.disparar(self)
	}

	method disparo() {
		const laser = new LaserAzul(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	method sumarScore(_score) {
		score += _score
	}

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => console.println("MANDALORIAN:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method restarVida(danio) {
		vida -= danio
	}

	method reiniciarEstado() {
		self.estado(vivo)
		self.vida(2)
		self.score(0)
		self.position(game.at(10, 10))
	}

	method textColor() = "#ffffff"

	method text() = self.score().toString()

	method consiguioLosPuntos() = nivelDondeEsta.puedeIrASiguienteNivel(self)

}

class Trooper inherits Personaje {

	method sufijo()

	override method colision(objeto) {
	}

	override method disparar() {
		const laser = new LaserRojo(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	method dispararSecuencialmente() {
		game.onTick(800, self.nroSerialDeTrooper(), { self.moverYDisparar()})
	}

	method moverYDisparar() {
		self.mover([ abajo, arriba, izquierda, derecha ].anyOne())
		self.disparar()
	}

	method nroSerialDeTrooper() {
		return self.identity().toString()
	}

	override method image() = "trooper-" + self.sufijo() + direccionDondeMira.toString() + ".png"

	override method desaparecer() {
		super()
		game.removeTickEvent(self.nroSerialDeTrooper())
		mandalorian.sumarScore(self.puntosQueOtorga())
	}

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => console.println("TROOPER:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
		self.dispararSecuencialmente()
	}

	method puntosQueOtorga()

	method danio() = 1

	method impactarConLaserAzul(laser) {
		self.desaparecer()
	}

	method impactarConLaserRojo(laser) {
	}

}

class TrooperCadete inherits Trooper {

	override method sufijo() = "cadete-"

	override method puntosQueOtorga() = 1

}

class TrooperSargento inherits Trooper {

	override method sufijo() = "sargento-"

	override method puntosQueOtorga() = 5

}

