import wollok.game.*
import Direccion.*
import StarWarsObject.*

class Proyectil inherits StarWarsObject {

	var property alcance
	var property direccionDeMovimiento

	method danio()

	override method image() = direccionDeMovimiento.toString() + ".png"

	override method colision(objeto) {
		objeto.colisionasteConLaser(self)
	}

	override method colisionasteConMandalorian(objeto) {
		objeto.restarVida(self.danio())
		objeto.desaparecer()
	}

	override method desaparecer() {
		super()
		game.removeTickEvent(self.nroSerialProyecyil())
	}

	method desplazar() {
		if (self.puedeMoverse(self, direccionDeMovimiento) and alcance > 0) {
			self.position(direccionDeMovimiento.proxima(self))
			alcance -= 1
		} else {
			self.desaparecer()
		}
	}

	method disparar() {
		game.onTick(self.velocidad(), self.nroSerialProyecyil(), { self.desplazar()})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method nroSerialProyecyil() = self.identity().toString()

	method velocidad()

}

class Laser inherits Proyectil {

	method sufijo()

	override method velocidad() = 75

	override method image() = "laser" + self.sufijo() + super()

	override method colisionasteConTrooper(objeto) {
		self.desaparecer()
	}

}

class LaserAzul inherits Laser {

	override method danio() = 1

	override method sufijo() = "Azul-"

	override method colisionasteConTrooper(objeto) {
		super(objeto)
		objeto.desaparecer()
	}

	override method colisionasteConDarthVader(objeto) {
		objeto.recibirDanio(self.danio())
		objeto.desaparecer()
	}

	override method colisionasteConUnlordSith(objeto) {
		super(objeto)
		objeto.desaparecer()
	}

	override method colisionasteConMandalorian(objeto) {
	}

}

class LaserRojo inherits Laser {

	override method danio() = 1

	override method sufijo() = "Rojo-"

}

class LaserNegro inherits Laser {

	override method danio() = 1

	override method sufijo() = "Negro-"

}

class Rayo inherits Proyectil {

	override method danio() = 1

	override method image() = "rayo-" + super()

	override method velocidad() = 20

}

