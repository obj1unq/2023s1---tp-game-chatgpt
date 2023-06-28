import wollok.game.*
import extras.*
import Direccion.*
import EstadoPersonaje.*
import Inamovible.*
import Laser.*
import Nivel.nivelUno
import PosicionMutable.*
import StarWarsObject.*

class Personaje inherits StarWarsObject {

	var property direccionDondeMira = abajo
	var property alcanceDisparo
	var property estado

	method direccionProxima() = direccionDondeMira.proxima(self)

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

	method moverSiPuede(direccion) {
		if (estado.puedeMoverse()) {
			self.mover(direccion)
		}
	}

	method realizarAccion()

	method realizarAccionSiPuede() {
		if (estado.puedeRealizarLaAccion(self)) {
			self.realizarAccion()
		}
	}

}

object mandalorian inherits Personaje(position = new PosicionMutable(x = 19, y = 12), alcanceDisparo = 3, estado = mandalorianVivo) {

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
			estado.reiniciarPara(self)
		}
	}

	method disparar() {
		const laser = new LaserAzul(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	method reiniciarEstado() {
		estado.reiniciarPara(self)
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
		self.nivelDondeSeEncuentra(portal.siguienteNivel())
		self.estado(mandalorianGanador)
		self.reiniciarEstado()
	}

}

class Trooper inherits Personaje {

	method direccionAleatoria() = [ arriba, abajo, izquierda, derecha ].anyOne()

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
		self.estado(enemigoDerrotado)
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
		game.onTick(800, self.nroSerialDeTrooper(), { self.moverSiPuede(self.direccionAleatoria())})
	}

}

const cadete = new TrooperCadete(position = new PosicionMutable(x = 10, y = 11), alcanceDisparo = 3, estado = enemigoVivo)

//const cadete2 = new TrooperCadete(position = new PosicionMutable(x = 2, y = 2), alcanceDisparo = 3)
const sargento = new TrooperSargento(position = new PosicionMutable(x = 4, y = 2), alcanceDisparo = 1, estado = enemigoVivo)

