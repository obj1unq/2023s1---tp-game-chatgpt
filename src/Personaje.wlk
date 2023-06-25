import wollok.game.*
import Direccion.*
import Laser.*
import EstadoPersonaje.*
import StarWarsObject.*

class Personaje inherits StarWarsObject {

	var property direccionDondeMira
	var property alcanceDisparo = 3

	method disparar()

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

}

object mandalorian inherits Personaje(position = game.at(3, 3), direccionDondeMira = abajo) {

	var property estado = vivo
	var property vida = 2
	var property puntos = 0
	var property score = 0

	override method image() = "mandalorian-" + direccionDondeMira.toString() + ".png"

	override method colision(objeto) {
		self.restarVida(objeto.danio())
		if (vida <= 0) {
			self.estado(muerto)
		}
		console.println(vida)
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

}

class Trooper inherits Personaje {

	method sufijo()

	override method colision(objeto) {
		if (objeto.toString().equals("un/a  LaserAzul")) {
			self.desaparecer()
			mandalorian.sumarScore(self.puntosQueOtorga())
		}
		console.println("MANDALORIAN PUNTOS:" + mandalorian.score())
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
		// self.mover([ abajo, arriba, izquierda, derecha ].anyOne())
		self.disparar()
	}

	method nroSerialDeTrooper() {
		return self.identity().toString()
	}

	override method image() = "trooper-" + self.sufijo() + direccionDondeMira.toString() + ".png"

	override method desaparecer() {
		super()
		game.removeTickEvent(self.nroSerialDeTrooper())
		mandalorian.sumarScore(10)
	}

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => console.println("TROOPER:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
		self.dispararSecuencialmente()
	}

	method puntosQueOtorga()

}

class TrooperCadete inherits Trooper {

	override method sufijo() = "cadete-"

	override method puntosQueOtorga() = 3

}

class TrooperSargento inherits Trooper {

	override method sufijo() = "sargento-"

	override method puntosQueOtorga() = 5

}

const cadete = new TrooperCadete(position = game.at(7, 7), direccionDondeMira = abajo)

