import wollok.game.*
import pantalla.*
import EstadoPersonaje.*
import Direccion.*
import Colisionable.*
import Proyectil.*

class Personaje inherits Colisionable {

	var cooldown = false
	var property estado = vivo
	var property direccionMovimiento

	method accion()

	method cooldown(_cooldown) {
		cooldown = not cooldown
	}

	override method desaparecer() {
		estado = muerto
		super()
	}

	method mover(direccion) {
		estado.mover(self, direccion)
	}

}

class Heroe inherits Personaje {

	const alcanceDisparo

	override method image() {
		return self.estado()
	}

	override method estado() {
		return if (estado.equals(muerto)) {
			"tumba.png"
		} else {
			"heroe-" + direccionMovimiento.toString() + ".png"
		}
	}

	override method accion() {
		estado.accion(self)
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), direccionMovimiento = direccionMovimiento, alcance = alcanceDisparo)
			laser.aparecer()
			laser.disparar()
			cooldown = true
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	override method desaparecer() {
		estado.desaparecer(self)
	}

}

class Enemigo inherits Personaje {

	const alcanceDisparo

	override method accion() {
		estado.accion(self)
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), direccionMovimiento = direccionMovimiento, alcance = alcanceDisparo)
			laser.aparecer()
			laser.disparar()
			cooldown = true
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	method disparoSecuencial() {
		// game.onTick(800, self.nroSerialDisparo(), { self.mover([ abajo, arriba, derecha, izquierda ].anyOne())})
		game.onTick(800, self.nroSerialDisparo(), { self.accion()})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	override method desaparecer() {
		estado = muerto
		game.removeTickEvent(self.nroSerialDisparo())
		super()
	}

}

class Tropper inherits Enemigo {

	override method image() = "tropper-" + direccionMovimiento.toString() + ".png"

}

