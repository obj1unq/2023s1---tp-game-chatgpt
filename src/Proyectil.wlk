import Colisionable.*
import wollok.game.*
import pantalla.*

class Proyectil inherits Colisionable {

	var direccionMovimiento
	var alcance

	override method desaparecer() {
		game.removeTickEvent(self.nroSerialDisparo())
		super()
	}

	method desplazar() {
		if (pantalla.estaDentro(direccionMovimiento.proxima(self)) and alcance > 0) {
			self.position(direccionMovimiento.proxima(self))
			alcance -= 1
		} else {
			self.desaparecer()
		}
	}

	method disparar() {
		game.onTick(70, self.nroSerialDisparo(), { self.desplazar()})
		game.onCollideDo(self, { objeto => objeto.desaparecer()})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

}

class Laser inherits Proyectil {

	override method image() {
		return "laser-rojo-" + direccionMovimiento.toString() + ".png"
	}

}

