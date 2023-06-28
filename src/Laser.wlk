import wollok.game.*
import extras.*
import Direccion.*
import StarWarsObject.*

class Laser inherits StarWarsObject {

	var property alcance
	var property direccionDeMovimiento

	method danio()

	override method image() = "laser" + self.sufijo() + direccionDeMovimiento.toString() + ".png"

	method sufijo()

	override method desaparecer() {
		super()
		game.removeTickEvent(self.nroSerialDisparo())
	}

	override method colision(objeto) {
		objeto.colisionasteConLaser(self)
	}

	override method colisionasteConTrooper(objeto) {
		self.desaparecer()
	}

	method desplazar() {
		if (screen.puedeRealizarLaAccionPara(self, direccionDeMovimiento) and alcance > 0) {
			self.position(direccionDeMovimiento.proxima(self))
			alcance--
		} else {
			self.desaparecer()
		}
	}

	method disparar() {
		game.onTick(75, self.nroSerialDisparo(), { self.desplazar()})
			// game.onCollideDo(self, { objeto => console.println("LASER:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

}

class LaserAzul inherits Laser {

	override method danio() = 1

	override method sufijo() = "Azul-"

	override method colisionasteConTrooper(objeto) {
		super(objeto)
		objeto.desaparecer()
	}

}

class LaserRojo inherits Laser {

	override method danio() = 1

	override method sufijo() = "Rojo-"

	override method colisionasteConMandalorian(objeto) {
		objeto.restarVida(self.danio())
		objeto.desparecer()
	}

}

