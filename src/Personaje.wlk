import Proyectil.*
import wollok.game.*
import Direccion.*
import estados.*

class Personaje {

	var property position // = game.center()
	var property direccionDondeMira = abajo
	const property estado = atravesable
	const property condicion = vivo
	var cooldown = false

	// TODO: var vida - 
	method image()

	method mover(direccion) {
		direccionDondeMira = direccion
		direccion.mover(self)
	}

	method accion()

	method eliminar() {
		game.removeVisual(self)
	}

	method cooldown(_cooldown) {
		cooldown = not cooldown
	}

}

class Heroe inherits Personaje {

	const alcanceDisparo

	override method image() = "heroe-" + direccionDondeMira.toString() + ".png"

	override method accion() {
		self.disparar()
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionDondeMira.proxima(self), direccion = direccionDondeMira, alcance = alcanceDisparo)
			laser.aparecer()
			laser.disparar()
			cooldown = true
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

}

class Enemigo inherits Personaje {

	const alcanceDisparo

	override method accion() {
		self.disparar()
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionDondeMira.proxima(self), direccion = direccionDondeMira, alcance = alcanceDisparo)
			laser.aparecer()
			laser.disparar()
			cooldown = true
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	method disparoSecuencial() {
		game.onTick(800, self.nroSerialDisparo(), { self.accion()})
		game.onTick(800, self.nroSerialDisparo(), { self.mover([ abajo, arriba, derecha, izquierda ].anyOne())})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	override method eliminar() {
		game.removeTickEvent(self.nroSerialDisparo())
		super()
	}

}

class Tropper inherits Enemigo {

	override method image() = "tropper-" + direccionDondeMira.toString() + ".png"

}

