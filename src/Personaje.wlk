import wollok.game.*
import Direccion.*
import EstadoPersonaje.*
import Posicion.*
import Proyectil.*
import extras.*
import EnemigoFactory.*

class Personaje {

	var property position
	var property direccionDondeMira = abajo
	var property alcanceDisparo

	method accion() {
	}

	method aparecer() {
		game.addVisual(self)
	}

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method dispararCon(colorLaser) {
		const laser = new Laser(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo, color = colorLaser)
		laser.aparecer()
		laser.disparar()
	}

	method esImpactoPorColorDeLaser(colorLaser) {
		return game.colliders(self).first().color().equals(colorLaser)
	}

}

object heroe inherits Personaje(position = new Posicion(x = 10, y = 10), alcanceDisparo = 3) {

	var property estado = vivo
	var property puntos = 0
	var property vida = 2

	override method aparecer() {
		game.addVisual(self)
		self.estado(vivo)
	}

	method image() {
		return "heroe-" + estado.condicionPara(self) + ".png"
	}

	override method accion() {
		estado.accion(self, "laserAzul")
	}

	override method desaparecer() {
		vida -= 1
		if (vida.equals(0)) {
			self.estado(muerto)
			gameOver.finalizarJuego()
		}
	}

	override method mover(direccion) {
		estado.mover(self, direccion)
	}

	method nivel() = 1

	method sumarPuntos(_puntos) {
		puntos += _puntos
	}

}

class Tropper inherits Personaje {

	const property rango

	override method aparecer() {
		super()
		self.dispararSecuencialmente()
	}

	method image() = "trooper-" + rango.toString() + "-" + direccionDondeMira.toString() + ".png"

	method dispararSecuencialmente() {
		game.onTick(800, self.nroSerialMovimiento(), { self.mover([ arriba, abajo, izquierda, derecha ].anyOne())})
		game.onTick(800, self.nroSerialDisparo(), { self.dispararCon("laserRojo")})
	}

	method nroSerialDisparo() {
		return self.identity().toString()
	}

	method nroSerialMovimiento() {
		return self.identity().toString()
	}

	override method desaparecer() {
		if (self.esImpactoPorColorDeLaser("laserAzul")) {
			game.removeTickEvent(self.nroSerialDisparo())
			game.removeTickEvent(self.nroSerialMovimiento())
			heroe.sumarPuntos(rango.puntosQueOtorga())
			super()
		}
	}

}

object cadete {

	method puntosQueOtorga() {
		return 5
	}

}

object sargento {

	method puntosQueOtorga() {
		return 7
	}

}

object general {

	method puntosQueOtorga() {
		return 10
	}

}

