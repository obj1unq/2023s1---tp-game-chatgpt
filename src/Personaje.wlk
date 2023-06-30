import wollok.game.*
import Direccion.*
import EstadoPersonaje.*
import Proyectil.*
import PosicionMutable.*
import StarWarsObject.*
import Nivel.*

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

	method recibirDanio(danio) {
		self.restarVida(danio)
		self.desaparecer()
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

