import wollok.game.*
import Direccion.*
import extras.*
import Personaje.*
import StarWarsObject.*

class Laser inherits StarWarsObject {

	var property direccionDeMovimiento
	var property alcance
	
	//TODO: Ver de donde sale esto URGENTE!!!!
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

	// metodos colision 
	method impactarConLaserAzul(laser) {
	}

	method impactarConLaserRojo(laser) {
	}

	method trooperColision(trooper) {
	}

	method colisionConBomba(_bomba) {
	}

}

class LaserAzul inherits Laser {

	override method colision(objeto) {
		objeto.impactarConLaserAzul(self)
		self.desaparecer()
	}

	override method sufijo() = "Azul-"

	override method danio() = 1

}

class LaserRojo inherits Laser {

	override method colision(objeto) {
		objeto.impactarConLaserRojo(self)
		self.desaparecer()
	}

	override method sufijo() = "Rojo-"

	override method danio() = 1

}

