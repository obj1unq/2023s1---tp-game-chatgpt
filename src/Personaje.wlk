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

	method accion() {
		estado.accion(self)
	}

	method cooldown(_cooldown) {
		cooldown = not cooldown
	}

	override method desaparecer(proyectil) {
		self.estado(muerto)
	}

	method mover(direccion) {
		estado.mover(self, direccion)
	}

}

class Heroe inherits Personaje {

	const alcanceDisparo

	override method image() {
		return if (estado.equals(muerto)) {
			"tumba.png"
		} else {
			"heroe-" + direccionMovimiento.toString() + ".png"
		}
	}

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), direccionMovimiento = direccionMovimiento, alcance = alcanceDisparo, tipo = laserAzul)
			laser.aparecer()
			laser.disparar()
			self.cooldown(true)
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	override method desaparecer(proyectil) {
		super(proyectil)
	// game.schedule(2000, {game.stop()})		// TODO falta poner alguna imagen de fin de juego, subtarea?		
	}

}

class Enemigo inherits Personaje {

	const alcanceDisparo

	method disparar() {
		if (not cooldown) {
			const laser = new Laser(position = direccionMovimiento.proxima(self), direccionMovimiento = direccionMovimiento, alcance = alcanceDisparo, tipo = laserRojo)
			laser.aparecer()
			laser.disparar()
			self.cooldown(true)
			game.schedule(800, { self.cooldown(cooldown)})
		}
	}

	method disparoSecuencial() {
		game.onTick(800, self.nroSerialDisparo(), { self.mover([ abajo, arriba, derecha, izquierda ].anyOne())}) // { self.mover([ abajo, arriba, derecha, izquierda ].anyOne())}) TODO eliminar lo del bloque xq es para prueba.
		game.onTick(800, self.nroSerialDisparo(), { self.accion()})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	override method desaparecer(proyectil) {
		if (not proyectil.tipo().equals(laserRojo)) {
			super(proyectil)
			game.removeVisual(self)
			game.removeTickEvent(self.nroSerialDisparo())
		}
	}

/* 
 * // OTRA SOLUCION
 * 	override method desaparecer() {
 * 		if (not self.esElColorDeDisparoDe(self, laserRojo)) {
 * 			super()
 * 			game.removeVisual(self)
 * 			game.removeTickEvent(self.nroSerialDisparo())
 * 		}
 * 	}

 * 	method esElColorDeDisparoDe(enemigo, colorLaser) {
 * 		return game.colliders(self).first().tipo().equals(colorLaser)
 * 	}
 */
}

class Tropper inherits Enemigo {

	override method image() = "tropper-" + direccionMovimiento.toString() + ".png"

}

