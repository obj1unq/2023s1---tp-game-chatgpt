import wollok.game.*
import extras.*
import Direccion.*
import EstadoPersonaje.*
import Inamovible.*
import Proyectil.*
import Nivel.nivelUno
import PosicionMutable.*
import StarWarsObject.*
import Visor.*

class Personaje inherits StarWarsObject {

	var property direccionDondeMira = abajo
	var property estado

	method realizarAccion()

	method direccionProxima() = direccionDondeMira.proxima(self)

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self, direccion)
	}

	method moverSiPuede(direccion) {
		if (self.puedeMoverse(self, direccion) && estado.puedeMoverse()) {
			self.mover(direccion)
		}
	}

	method realizarAccionSiPuede() {
		if (estado.puedeRealizarLaAccion(self)) {
			self.realizarAccion()
		}
	}

}

object mandalorian inherits Personaje(position = new PosicionMutable(x = 19, y = 12), estado = mandalorianVivo) {

	var property alcanceDisparo = 3
	var property nivelDondeSeEncuentra = nivelUno
	var property score = 0
	var property vida = 2

	method cumplioLaMision() = nivelDondeSeEncuentra.puedeIrASiguienteNivel()

	override method image() = "mandalorian-" + direccionDondeMira.toString() + ".png"

	override method colision(objeto) {
		objeto.colisionasteConMandalorian(self)
	}

	override method desaparecer() {
		if (vida <= 0) {
			self.estado(mandalorianDerrotado)
			gameOver.reiniciarJuego()
			estado.teEliminaron(self)
		}
	}

	method disparar() {
		const laser = new LaserAzul(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	override method realizarAccion() {
		self.disparar()
	}

	method restarVida(_vida) {
		vida -= _vida
	}

	method sumarScore(_score) {
		score += _score
	}

	method teletranspotarse() {
		self.nivelDondeSeEncuentra(nivelDondeSeEncuentra.siguienteNivel())
		self.estado(mandalorianGanador)
		estado.reiniciar()
	}

}

class Trooper inherits Personaje {

	method direccionAleatoria() = [ abajo, arriba, izquierda, derecha ].anyOne()

	method puntosQueOtorga()

	method sufijo()

	method tiempoParaAccion()

	override method image() = "trooper-" + self.sufijo() + direccionDondeMira.toString() + ".png"

	method nroSerialDeTrooper() = self.identity().toString()

	override method aparecer() {
		super()
		self.realizarAccionSecuencialmente()
	}

	override method colision(objeto) {
		objeto.colisionasteConTrooper(self)
	}

	override method desaparecer() {
		super()
		self.estado(trooperDerrotado)
		estado.teEliminaron(self)
	}

	method realizarAccionSecuencialmente() {
		game.onTick(self.tiempoParaAccion(), self.nroSerialDeTrooper(), { self.realizarAccionSiPuede()})
	}

	method removerEvento() {
		game.removeTickEvent(self.nroSerialDeTrooper())
	}

}

class TrooperCadete inherits Trooper {

	var property alcanceDisparo

	override method tiempoParaAccion() = 800

	override method puntosQueOtorga() = 2

	override method sufijo() = "cadete-"

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

	// / drop(3)
	method moverAleatorio() {
		const direccion = direccionesAleatoria.first()
		self.moverSiPuede(direccion)
		direccionesAleatoria = direccionesAleatoria.drop(1)
		direccionesAleatoria.add(direccion)
	}

	override method tiempoParaAccion() = 5000

	override method puntosQueOtorga() = 3

	override method sufijo() = "sargento-"

	method colocarBomba() {
		const bomba = new Bomba(position = direccionDondeMira.proxima(self))
		bomba.aparecer()
		bomba.activar()
	}

	override method realizarAccion() {
		self.colocarBomba()
	}

	override method realizarAccionSecuencialmente() {
		super()
		game.onTick(800, self.nroSerialDeTrooper(), { self.moverAleatorio()})
	}

}

class LordSith inherits Personaje {

	method direccionAleatoria() = [ abajo, arriba, izquierda, derecha ].anyOne()

	method tiempoParaAccion() = 5000

	method puntosQueOtorga() = 3

	override method image() = "lord-" + estado.imagenPara(self) + ".png"

	method nroSerialDeTrooper() = self.identity().toString()

	override method aparecer() {
		super()
		self.realizarAccionSecuencialmente()
	}

	override method colision(objeto) {
		objeto.colisionasteConUnlordSith(self)
	}

	override method desaparecer() {
		super()
		self.estado(lordSithDerrotado)
		estado.teEliminaron(self)
	}

	method realizarAccionSecuencialmente() {
		game.onTick(self.tiempoParaAccion(), self.nroSerialDeTrooper(), { self.realizarAccionSiPuede()})
		game.onTick(1500, self.nroSerialDeTrooper(), { self.moverSiPuede(self.direccionAleatoria())})
	}

	method removerEvento() {
		game.removeTickEvent(self.nroSerialDeTrooper())
	}

	override method realizarAccion() {
		self.direccionDondeMira(abajo)
		self.estado(lordSithAtacando)
		self.dispararRayo()
	}

	method proximoRayoDerecho(numero) {
		return new PosicionMutable(x = self.position().x() + numero, y = self.position().y())
	}

	method proximoRayoIzquierdo(numero) {
		return new PosicionMutable(x = self.position().x() - numero, y = self.position().y())
	}

	method dispararRayo() {
		const rayoDerecho = new Rayo(position = self.proximoRayoDerecho(1), direccionDeMovimiento = derecha, alcance = 5)
		const rayoIzquierdo = new Rayo(position = self.proximoRayoIzquierdo(1), direccionDeMovimiento = izquierda, alcance = 5)
//		const rayoDerecho1 = new Rayo(position = self.proximoRayoDerecho(2), direccionDeMovimiento = derecha, alcance = 5)
//		const rayoIzquierdo2 = new Rayo(position = self.proximoRayoIzquierdo(2), direccionDeMovimiento = izquierda, alcance = 5)
//		const rayoDerecho3 = new Rayo(position = self.proximoRayoDerecho(3), direccionDeMovimiento = derecha, alcance = 5)
//		const rayoIzquierdo3 = new Rayo(position = self.proximoRayoIzquierdo(3), direccionDeMovimiento = izquierda, alcance = 5)
		rayoIzquierdo.aparecer()
		rayoIzquierdo.disparar()
		rayoDerecho.aparecer()
		rayoDerecho.disparar()
//		rayoDerecho1.aparecer()
//		rayoDerecho1.disparar()
//		rayoIzquierdo2.aparecer()
//		rayoIzquierdo2.disparar()
//		rayoIzquierdo3.aparecer()
//		rayoIzquierdo3.disparar()
//		rayoDerecho3.aparecer()
//		rayoDerecho3.disparar()
	}

	override method mover(direccion) {
		self.estado(lordSithVivo)
		super(direccion)
	}

}

object darthVader inherits Personaje (position = new PosicionMutable(x = 10, y = 7), estado = darthVaderVivo) {

	var property vida = 5

	method posicionBarra() = 100

	method direccionAleatoria() = [ abajo, arriba, izquierda, derecha ].anyOne()

	method tiempoParaAccion() = 1000

	method puntosQueOtorga() = 100

	override method image() = "vader-" + estado.imagenPara(self) + ".png"

	method nroSerialDarthVader() = self.identity().toString()

	override method aparecer() {
		super()
		barraDeVida.aparecer()
		self.realizarAccionSecuencialmente()
	}

	override method colision(objeto) {
		objeto.colisionasteConDarthVader(self)
	}

	method realizarAccionSecuencialmente() {
		game.onTick(self.tiempoParaAccion(), self.nroSerialDarthVader(), { self.realizarAccionSiPuede()})
		game.onTick(1500, self.nroSerialDarthVader(), { self.moverSiPuede(mandalorian.direccionDondeMira().opuesto())})
	}

	method recibirDanio(danio) {
		vida -= estado.restarVida(danio)
	}

	override method realizarAccion() {
		game.onTick(1000, self.nroSerialDeVader(), { self.disparar()})
		game.onTick(5000, self.nroSerialDeVader(), { self.cambiarDeEstado()})
	}

	override method desaparecer() {
		if (vida <= 0) {
			self.estado(darthVaderDerrotado)
			estado.teEliminaron(self)
			super()
			gameWin.iniciar()
		}
	}

	method disparar() {
		const laser = new LaserNegro(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = 5)
		laser.aparecer()
		laser.disparar()
	}

	method cambiarDeEstado() {
		self.estado(estado.estadoOpuesto())
	}

	method nroSerialDeVader() = self.identity().toString()

	method removerEvento() {
		game.removeTickEvent(self.nroSerialDeVader())
	}

}

const sargentoArriba = new TrooperSargento(estado = trooperVivo, position = new PosicionMutable(x = 12, y = 13), direccionDondeMira = arriba)

const sargentoAbajo = new TrooperSargento(estado = trooperVivo, position = new PosicionMutable(x = 8, y = 1), direccionDondeMira = abajo)

