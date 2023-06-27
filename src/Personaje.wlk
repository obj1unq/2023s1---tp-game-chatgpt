import wollok.game.*
import Direccion.*
import Laser.*
import extras.*
import StarWarsObject.*
import Nivel.*
import PosicionMutable.*
import EstadoPersonaje.*
import Inamovible.*

class Personaje inherits StarWarsObject {

	var property direccionDondeMira
	var property alcanceDisparo = 3

	method esColisionable() = true

	method disparar()

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

	method colision(objecto)

	method pasarDeNivel(objecto) {
	}

}

object mandalorian inherits Personaje(position = new PosicionMutable(x = 10, y = 7), direccionDondeMira = abajo) {

	var property estado = vivo
	var property vida = 2
	var property score = 0
	var property nivelDondeSeEncuentra = nivelUno

	override method image() = "mandalorian-" + direccionDondeMira.toString() + ".png"

	override method colision(objecto) {
		self.restarVida(objecto.danio())
		self.verificarEstado()
	}

	method verificarEstado() {
		if (vida <= 0) {
			self.estado(muerto)
			gameOver.finalizarJuego()
		}
	}

	method cumplioLaMision() = nivelDondeSeEncuentra.puedeIrASiguienteNivel()

	method cambiarDeNivel(_nivel) {
		nivelDondeSeEncuentra = _nivel
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

	method restarVida(danio) {
		vida -= danio
	}

	method reiniciarEstado() {
		self.position(new PosicionMutable(x = 14, y = 7))
		self.estado(vivo)
		self.score(0)
		self.vida(2)
	}

	method textColor() = "#ffffff"

	method text() = self.score().toString()

	method consiguioLosPuntos() = nivelDondeSeEncuentra.puedeIrASiguienteNivel(self)

	override method pasarDeNivel(objecto) {
		objecto.subirDeNivel()
	}

}

class Trooper inherits Personaje {

	method sufijo()

	override method colision(objeto) {
		self.desaparecer()
		objeto.desaparecer()
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
		self.dispararSecuencialmente()
	}

	method puntosQueOtorga()

	method danio() = 1

}

class TrooperCadete inherits Trooper {

	override method sufijo() = "cadete-"

	override method puntosQueOtorga() = 1

}

class TrooperSargento inherits Trooper {

	override method sufijo() = "sargento-"

	override method puntosQueOtorga() = 5

	override method aparecer() {
		super()
		self.dispararSecuencialmente()
	}

}

const cadete = new TrooperCadete(position = new PosicionMutable(x = 2, y = 2), direccionDondeMira = abajo)

