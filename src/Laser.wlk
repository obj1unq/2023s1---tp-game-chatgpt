import wollok.game.*
import Direccion.*
import extras.*
import Personaje.*
import StarWarsObject.*

class Laser inherits StarWarsObject {

	var property direccionDeMovimiento
	var property alcance

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

	method pasarDeNivel(objecto) {
	}

	override method colision(objeto) {
		objeto.colisionasteConLaser(self)
	}

	override method colisionasteConTrooper(objeto) {
		self.desaparecer()
	}

}

class LaserAzul inherits Laser {

	override method sufijo() = "Azul-"

	override method danio() = 1

	override method colisionasteConTrooper(objeto) {
		super(objeto)
		objeto.desaparecer()
	}

}

class LaserRojo inherits Laser {

	override method sufijo() = "Rojo-"

	override method danio() = 1

	override method colisionasteConMandalorian(objeto) {
		super(objeto)
		objeto.restarVida(self.danio())
	}

}

