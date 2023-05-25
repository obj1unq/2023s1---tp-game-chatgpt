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
			const laser = new Laser(position = direccionMovimiento.proxima(self), 
									direccionMovimiento = direccionMovimiento, 
									alcance = alcanceDisparo
			)
			laser.aparecer()
			laser.disparar()
			cooldown = true
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	override method desaparecer() {
		super()
		game.schedule(2000, {game.stop()})		// TODO falta poner alguna imagen de fin de juego, subtarea?		
	}

}

class Enemigo inherits Personaje {

	const alcanceDisparo

	override method accion() {
		estado.accion(self)
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), 
									direccionMovimiento = direccionMovimiento, 
									alcance = alcanceDisparo
			)
			laser.aparecer()
			laser.disparar()
			cooldown = true
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	method disparoSecuencial() {
		game.onTick(800, self.nroSerialDisparo(),{ self.mover([ derecha ].anyOne())}) //{ self.mover([ abajo, arriba, derecha, izquierda ].anyOne())}) TODO eliminar lo del bloque xq es para prueba.
		game.onTick(800, self.nroSerialDisparo(), { self.accion()})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	override method desaparecer() {
		super()
		game.removeTickEvent(self.nroSerialDisparo())
		game.removeVisual(self)
		
	}

}

class Tropper inherits Enemigo {

	override method image() = "tropper-" + direccionMovimiento.toString() + ".png"

}

