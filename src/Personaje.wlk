import wollok.game.*
import pantalla.*
import EstadoPersonaje.*
import Direccion.*
import Colisionable.*
import Proyectil.*
import Nivel.*

class Personaje inherits Colisionable {

	var cooldown = false
	var property estado = vivo
	var property direccionMovimiento

	method accion() {
		estado.accion(self)
	}

	method cooldown(_cooldown) {
		cooldown = not cooldown
	}

	override method desaparecer() {
		self.estado(muerto)
	}

	method mover(direccion) {
		estado.mover(self, direccion)
	}

}

class Heroe inherits Personaje {

	const alcanceDisparo

	override method image() {
		return "heroe-" + self.estado() + ".png"
	}

	override method estado() {
		return if (estado.equals(muerto)) {
			"tumba"
		} else {
			direccionMovimiento.toString()
		}
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), 
									direccionMovimiento = direccionMovimiento, 
									alcance = alcanceDisparo, tipo = laserAzul
									)
			laser.aparecer()
			laser.disparar()
			self.cooldown(true)
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	override method desaparecer() {
		super()
		game.schedule(1500, { self.finalizarJuego()}) // DELEGAR RESPONSABILIDAD
	}

	method finalizarJuego() {
		game.clear()
		gameOver.fondo()
	// game.schedule(3000, { game.stop()})
	}

/*
 * 	override method desaparecer() {
 * 		super()
 * 	// game.schedule(2000, {game.stop()})		// TODO falta poner alguna imagen de fin de juego, subtarea?		
 * 	}
 */
}

class Enemigo inherits Personaje {

	const alcanceDisparo

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), 
									direccionMovimiento = direccionMovimiento, 
									alcance = alcanceDisparo, 
									tipo = laserRojo
			)
			laser.aparecer()
			laser.disparar()
			self.cooldown(true)
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	method disparoSecuencial() {
		game.onTick(800, self.nroSerialDisparo(), { self.mover([ arriba, abajo, izquierda, derecha ].anyOne())}) // { self.mover([ abajo, arriba, derecha, izquierda ].anyOne())}) TODO eliminar lo del bloque xq es para prueba.
		game.onTick(800, self.nroSerialDisparo(), { self.accion()})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	override method desaparecer() {
		if (not game.colliders(self).first().tipo().equals(laserRojo)) {
			super()
			game.removeVisual(self)
			game.removeTickEvent(self.nroSerialDisparo())
		}
	}

}

class Tropper inherits Enemigo {

	const property rango

	override method image() = "tropper-" + rango + "-" + direccionMovimiento.toString() + ".png"

}

object tumba {

}

