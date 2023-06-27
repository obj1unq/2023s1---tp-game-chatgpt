import wollok.game.*
import Direccion.*
import extras.*
import Personaje.*
import StarWarsObject.*

class Laser inherits StarWarsObject {

	var property direccionDeMovimiento
	var property alcance

	method colision(objeto) {
		objeto.desaparecer()
		self.desaparecer()
	}

	override method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent(self.nroSerialDisparo())
	}

	method desplazar() {
		if (screen.puedeMover(self, direccionDeMovimiento) and alcance > 0) {
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
		game.onTick(75, self.nroSerialDisparo(), { self.desplazar()})
		game.onCollideDo(self, { objeto => console.println("LASER:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	override method image() = "laser" + self.sufijo() + direccionDeMovimiento.toString() + ".png"

	method sufijo()

	method danio()

	method esColisionable() = true

	method pasarDeNivel(objecto) {
	}

}

class LaserAzul inherits Laser {

	override method sufijo() = "Azul-"

	override method danio() = 1

}

class LaserRojo inherits Laser {

	override method sufijo() = "Rojo-"

	override method danio() = 1

}

