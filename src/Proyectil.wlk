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

	method disparar()

	method nroSerialDisparo() {
		return self.identity().toString()
	}

}

class Laser inherits Proyectil {

	const property tipo

	override method image() {
		return tipo.toString() + "-" + direccionMovimiento.toString() + ".png"
	}

	override method disparar() {
		game.onTick(25, self.nroSerialDisparo(), { self.desplazar()})
		game.onCollideDo(self, { objeto => objeto.desaparecer()})
	}

}

object laserAzul {

}

object laserRojo {

}

