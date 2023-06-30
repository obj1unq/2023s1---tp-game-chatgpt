import wollok.game.*
import Direccion.*
import EstadoPersonaje.*
import Inamovible.*
import Personaje.*
import Proyectil.*
import PosicionMutable.*
import StarWarsObject.*
import Visor.*

class Enemigo inherits Personaje {

	method direccionAleatoria() = [ abajo, arriba, izquierda, derecha ].anyOne()

	method nroSerialEnemigo() = self.identity().toString()

	method puntosQueOtorga()

	method tiempoParaAccion()

	override method aparecer() {
		super()
		self.realizarAccionSecuencialmente()
	}

	override method desaparecer() {
		super()
		estado.teEliminaron(self)
	}

	method realizarAccionSecuencialmente() {
		game.onTick(self.tiempoParaAccion(), self.nroSerialEnemigo(), { self.realizarAccionSiPuede()})
	}

	method removerEvento() {
		game.removeTickEvent(self.nroSerialEnemigo())
	}

}

class Trooper inherits Enemigo {

	method sufijo()

	override method image() = "trooper-" + self.sufijo() + direccionDondeMira.toString() + ".png"

	override method colision(objeto) {
		objeto.colisionasteConTrooper(self)
	}

	override method desaparecer() {
		self.estado(trooperDerrotado)
		super()
	}

}

class TrooperCadete inherits Trooper {

	var property alcanceDisparo

	override method puntosQueOtorga() = 2

	override method sufijo() = "cadete-"

	override method tiempoParaAccion() = 800

	method disparar() {
		const laser = new LaserRojo(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	override method realizarAccion() {
		self.disparar()
	}

	override method realizarAccionSiPuede() {
		self.moverSiPuede(self.direccionAleatoria())
		super()
	}

}

class TrooperSargento inherits Trooper {

	var direccionesAleatoria = []

	override method puntosQueOtorga() = 3

	override method sufijo() = "sargento-"

	override method tiempoParaAccion() = 5000

	method colocarBomba() {
		const bomba = new Bomba(position = direccionDondeMira.proxima(self))
		bomba.aparecer()
		bomba.activar()
	}

	method moverAleatorio() {
		const direccion = direccionesAleatoria.first()
		self.moverSiPuede(direccion)
		direccionesAleatoria = direccionesAleatoria.drop(1)
		direccionesAleatoria.add(direccion)
	}

	override method realizarAccion() {
		self.colocarBomba()
	}

	override method realizarAccionSecuencialmente() {
		super()
		game.onTick(800, self.nroSerialEnemigo(), { self.moverAleatorio()})
	}

}

class LordSith inherits Enemigo {

	override method image() = "lord-" + estado.imagenPara(self) + ".png"

	override method puntosQueOtorga() = 3

	override method tiempoParaAccion() = 5000

	override method colision(objeto) {
		objeto.colisionasteConLordSith(self)
	}

	override method desaparecer() {
		self.estado(lordSithDerrotado)
	}

	method dispararRayo() {
		const rayoDerecho = new Rayo(position = self.proximoRayoDerecho(1), direccionDeMovimiento = derecha, alcance = 5)
		const rayoIzquierdo = new Rayo(position = self.proximoRayoIzquierdo(1), direccionDeMovimiento = izquierda, alcance = 5)
		const rayoDerecho1 = new Rayo(position = self.proximoRayoDerecho(2), direccionDeMovimiento = derecha, alcance = 5)
		const rayoIzquierdo2 = new Rayo(position = self.proximoRayoIzquierdo(2), direccionDeMovimiento = izquierda, alcance = 5)
		const rayoDerecho3 = new Rayo(position = self.proximoRayoDerecho(3), direccionDeMovimiento = derecha, alcance = 5)
		const rayoIzquierdo3 = new Rayo(position = self.proximoRayoIzquierdo(3), direccionDeMovimiento = izquierda, alcance = 5)
		rayoIzquierdo.aparecer()
		rayoIzquierdo.disparar()
		rayoDerecho.aparecer()
		rayoDerecho.disparar()
		rayoDerecho1.aparecer()
		rayoDerecho1.disparar()
		rayoIzquierdo2.aparecer()
		rayoIzquierdo2.disparar()
		rayoIzquierdo3.aparecer()
		rayoIzquierdo3.disparar()
		rayoDerecho3.aparecer()
		rayoDerecho3.disparar()
	}

	override method mover(direccion) {
		self.estado(lordSithVivo)
		super(direccion)
	}

	method proximoRayoDerecho(numero) {
		return new PosicionMutable(x = self.position().x() + numero, y = self.position().y())
	}

	method proximoRayoIzquierdo(numero) {
		return new PosicionMutable(x = self.position().x() - numero, y = self.position().y())
	}

	override method realizarAccionSecuencialmente() {
		super()
		game.onTick(1500, self.nroSerialEnemigo(), { self.moverSiPuede(self.direccionAleatoria())})
	}

	override method realizarAccion() {
		self.direccionDondeMira(abajo)
		self.estado(lordSithAtacando)
		self.dispararRayo()
	}

}

object darthVader inherits Enemigo (position = new PosicionMutable(x = 10, y = 7), estado = darthVaderVivo) {

	var property vida = 5

	override method image() = "vader-" + estado.imagenPara(self) + ".png"

	override method puntosQueOtorga() = 100

	override method tiempoParaAccion() = 1000

	override method aparecer() {
		super()
		barraDeVida.aparecer()
	}

	method cambiarDeEstado() {
		self.estado(estado.estadoOpuesto())
	}

	override method colision(objeto) {
		objeto.colisionasteConDarthVader(self)
	}

	override method desaparecer() {
		if (vida <= 0) {
			self.estado(darthVaderDerrotado)
			super()
		}
	}

	method disparar() {
		const laser = new LaserNegro(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = 5)
		laser.aparecer()
		laser.disparar()
	}

	override method realizarAccion() {
		self.disparar()
	}

	override method realizarAccionSecuencialmente() {
		super()
		game.onTick(5000, self.nroSerialEnemigo(), { self.cambiarDeEstado()})
		game.onTick(1500, self.nroSerialEnemigo(), { self.moverSiPuede(mandalorian.direccionDondeMira().opuesto())})
	}

	method recibirDanio(danio) {
		vida -= estado.restarVida(danio)
	}

}

