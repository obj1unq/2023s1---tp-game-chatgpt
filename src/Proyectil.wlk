import pantalla.*
import wollok.game.*
import estados.*

class Proyectil {

	var property position
	// TODO: var property danio
	var property direccion
	const property estado = atravesable
	var alcance

	method image()

	method desplazar() {
		if (pantalla.estaDentro(direccion.proxima(self)) and alcance > 0) {
			self.position(direccion.proxima(self))
			alcance -= 1
		} else {
			self.eliminar()
		}
	}

	method disparar() {
		game.onTick(25, self.nroSerialDisparo(), { self.desplazar()})
		game.onCollideDo(self, { objeto => objeto.estado().eliminar(self, objeto)})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	method eliminar() {
		game.removeTickEvent(self.nroSerialDisparo())
		game.removeVisual(self)
	}

	method aparecer() {
		game.addVisual(self)
	}

}

class Laser inherits Proyectil {

	override method image() {
		return "laser-rojo-" + direccion + ".png"
	}

}

