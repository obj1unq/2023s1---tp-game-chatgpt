import wollok.game.*
import Direccion.*
import Laser.*
import EstadoPersonaje.*

class Personaje {

	var property position
	var property direccionDondeMira
	var property alcanceDisparo = 3

	method image() = direccionDondeMira.toString() + ".png"

	method aparecer() {
		game.addVisual(self)
	}

//////////////////////////////////////////////////////////
//  se tranformo este metodo en un metodo abstracto --> 
	// / trooper tiene una forma de disparar distinta a la de Mando
	// Mando dispara por medio de su estado Si esta vivo  o Muerto .
	// method disparar() {
//		const laser = new LaserAzul(position = position, direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
//		laser.aparecer()
//		laser.disparar()
//	} 
	// ///////////////////////////////////////////////
	method disparar()

	method colision(objeto)

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

	var property estado = vivo

	override method image() = "mandalorian-" + super()

	override method esColisionable() = true

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	override method colision(objeto) {
		self.desaparecer()
	}

	override method desaparecer() {
		super()
		self.estado(muerto)
	}

	override method mover(direccion) {
		estado.mover(self, direccion)
	}

	override method disparar() {
		estado.disparar(self)
	}

	method disparo() {
		const laser = new LaserAzul(position = position, direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
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
		game.onTick(800, self.nroSerialDeTrooper(), { self.mover([ abajo ].anyOne())
		; self.disparar()
		})
//		game.onTick(800, self.nroSerialDeTrooper(), { self.disparar()})  se coloco self.disparar() en el bloque de arriba 
	}

// cambiado por nroSerialDeTrooper() 
//	method nroSerialDisparo() {
//		return self.identity().toString()
//	}
//
//	method nroSerialMovimiento() {
//		return self.identity().toString()
//	}
	method nroSerialDeTrooper() {
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

