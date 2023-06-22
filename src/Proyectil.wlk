import wollok.game.*
import extras.*

class Proyectil {

	var property position
	var property direccionDeMovimiento
	var property alcance

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		game.removeVisual(self)
		game.removeTickEvent(self.nroSerialDisparo())
	}

	method desplazar() {
		if (pantalla.estaDentro(direccionDeMovimiento.proxima(self)) and alcance > 0) {
			self.position(direccionDeMovimiento.proxima(self))
			alcance--
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

	const property color

	method image() {
		return color + "-" + direccionDeMovimiento.toString() + ".png"
	}

	override method disparar() {
		game.onTick(25, self.nroSerialDisparo(), { self.desplazar()})
		game.onCollideDo(self, { objeto => objeto.desaparecer()})
	}

}

