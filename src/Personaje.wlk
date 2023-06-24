import wollok.game.*
import Direccion.*
import Laser.*

class Personaje {

	var property position
	var property direccionDondeMira
	var property alcanceDisparo = 3

	method image() = direccionDondeMira.toString() + ".png"

	method aparecer() {
		game.addVisual(self)
	}

	method disparar() {
		const laser = new LaserAzul(position = position, direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	method colision(objeto) {
	// IMPLEMENTAR DISMUNIR VIDA
	}

	method esColisionable()

	method desaparecer() {
		game.removeVisual(self)
	}

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

}

object mandalorian inherits Personaje(position = game.at(3, 3), direccionDondeMira = abajo) {

	override method image() = "mandalorian-" + super()

	override method esColisionable() = true

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	override method colision(objeto) {
		self.desaparecer()
	}

}

class Trooper inherits Personaje {

	override method disparar() {
		const laser = new LaserRojo(position = position, direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	override method aparecer() {
		super()
		self.dispararSecuencialmente()
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	override method esColisionable() = true

	override method colision(objeto) {
	}

	method dispararSecuencialmente() {
		// / esto es un cambio 
		game.onTick(800, self.nroSerialMovimiento(), { self.mover([ abajo ].anyOne())})
		game.onTick(800, self.nroSerialDisparo(), { self.disparar()})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	method nroSerialMovimiento() {
		return self.identity().toString()
	}

	method esEnemigo() = true

}

class TrooperCadete inherits Trooper {

	override method image() = "trooper-cadete-" + super()

}

class TrooperSargento inherits Trooper {

	override method image() = "trooper-sargento-" + super()

}

const cadete = new TrooperCadete(position = game.at(7, 7), direccionDondeMira = abajo)

