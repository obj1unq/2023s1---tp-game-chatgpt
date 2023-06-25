import wollok.game.*
import Direccion.*
import screen.*
import Personaje.*
import StarWarsObject.*

class Laser inherits StarWarsObject {

	var property direccionDeMovimiento
	var property alcance

	override method colision(objeto) {
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
		game.onTick(25, self.nroSerialDisparo(), { self.desplazar()})
		game.onCollideDo(self, { objeto => console.println("LASER:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	override method image() = "laser" + self.sufijo() + direccionDeMovimiento.toString() + ".png"

	method sufijo()

	method danio()

	method impactasteConMandalorian(objeto) {
	}

	method impactasteConTrooper(objeto) {
	}

}

class LaserAzul inherits Laser {

	override method colision(objeto) {
		objeto.impactasteConMandalorian(objeto)
		objeto.impactasteConTrooper(objeto)
	}

	override method sufijo() = "Azul-"

	override method danio() = 1

	override method impactasteConMandalorian(objeto) {
	}

	override method impactasteConTrooper(objeto) {
		objeto.desaparecer()
	}

}

class LaserRojo inherits Laser {

	override method colision(objeto) {
		objeto.impactasteConMandalorian(objeto)
		objeto.impactasteConTrooper(objeto)
	}

	override method sufijo() = "Rojo-"

	override method danio() = 1

	override method impactasteConMandalorian(objeto) {
		objeto.colision(self.danio())
	}

	override method impactasteConTrooper(objeto) {
	}

}

