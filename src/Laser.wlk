import wollok.game.*
import Direccion.*
import extras.*
import Personaje.*

class Laser {

	var property position
	var property direccionDeMovimiento
	var property alcance

	method esColisionable() = true

	method aparecer() {
		game.addVisual(self)
	}

	method colision(objeto) {
		objeto.desaparecer()
		self.desaparecer()
	}

	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent(self.nroSerialDisparo())
	}

	method desplazar() {
		if (pantalla.puedeMover(self, direccionDeMovimiento) and alcance > 0) {
			self.position(direccionDeMovimiento.proxima(self))
			alcance--
		} else {
			self.desaparecer()
		}
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	method disparar() {
		game.onTick(25, self.nroSerialDisparo(), { self.desplazar()})
	}

	method image() = direccionDeMovimiento.toString() + ".png"

}

class LaserAzul inherits Laser {

	override method image() = "laserAzul-" + super()

	override method colision(objeto) {
		if (not objeto.equals(mandalorian)) {
			objeto.desaparecer()
			self.desaparecer()
		}
	}

}

class LaserRojo inherits Laser {

	override method image() = "laserRojo-" + super()

	override method colision(objeto) {
		if (objeto.equals(mandalorian)) {
			objeto.desaparecer()
			console.println("ENTRANDO..")
			self.desaparecer()
		}
	}

}

