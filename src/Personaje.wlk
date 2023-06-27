import wollok.game.*
import Direccion.*
import Laser.*
import extras.*
import StarWarsObject.*
import Nivel.*
import PosicionMutable.*
import EstadoPersonaje.*

class Personaje inherits StarWarsObject {

	var property direccionDondeMira = abajo
	var property alcanceDisparo

	method dispararSiPuede() {
		if (not screen.hayObjetoAdelante(direccionDondeMira.proxima(self))) {
			self.disparar()
		}
	}

	method disparar()

	method mover(direccion) {
		self.direccionDondeMira(direccion)
		direccion.mover(self)
	}

	method pasarDeNivel(objecto) {
	}

}

object mandalorian inherits Personaje(position = new PosicionMutable(x = 19, y = 12), alcanceDisparo = 3) {

	var property estado = vivo
	var property nivelDondeSeEncuentra = nivelUno
	var property score = 0
	var property vida = 2

	method cumplioLaMision() = nivelDondeSeEncuentra.puedeIrASiguienteNivel()

	override method image() = "mandalorian-" + direccionDondeMira.toString() + ".png"

	method cambiarDeNivel(_nivel) {
		nivelDondeSeEncuentra = _nivel
	}

	override method colision(objeto) {
		objeto.colisionasteConMandalorian(self)
	}

	method crearDisparo() {
		const laser = new LaserAzul(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	override method desaparecer() {
	// TODO: IMPLEMENTAR METOODO PARA LA VIDA DEL MANDALORIAN
	}

	override method disparar() {
		estado.disparar(self)
	}

	override method mover(direccion) {
		estado.mover(self, direccion)
	}

	method reiniciarEstadoGanador() {
		self.position(new PosicionMutable(x = 19, y = 12))
		self.estado(vivo)
		self.score(0)
		self.vida(2)
		self.direccionDondeMira(abajo)
	}

	method reiniciarEstadoPerdedor() {
		self.reiniciarEstadoGanador()
		self.nivelDondeSeEncuentra(nivelUno)
	}

	method restarVida(danio) {
		console.println(vida)
		vida -= danio // TODO: FIJARSE DEL ERROR EN LA VISUAL DE LA VIDA
	}

	method sumarScore(_score) {
		score += _score
	}

	method verificarEstado() {
		if (vida <= 0) {
			self.estado(muerto)
			gameOver.finalizarJuego()
		}
	}

}

class Trooper inherits Personaje {

	method puntosQueOtorga()

	method sufijo()

	method danio() = 1

	override method image() = "trooper-" + self.sufijo() + direccionDondeMira.toString() + ".png"

	method nroSerialDeTrooper() = self.identity().toString()

	override method aparecer() {
		super()
		self.dispararSecuencialmente()
	}

	override method colision(objeto) {
		objeto.colisionasteConTrooper(self)
	}

	override method desaparecer() {
		super()
		game.removeTickEvent(self.nroSerialDeTrooper())
		mandalorian.sumarScore(self.puntosQueOtorga())
	}

	override method disparar() {
		const laser = new LaserRojo(position = direccionDondeMira.proxima(self), direccionDeMovimiento = direccionDondeMira, alcance = alcanceDisparo)
		laser.aparecer()
		laser.disparar()
	}

	method dispararSecuencialmente() {
		game.onTick(800, self.nroSerialDeTrooper(), { self.moverYDisparar()})
	}

	method moverYDisparar() {
		// self.mover([ abajo, arriba, izquierda, derecha ].anyOne())
		self.dispararSiPuede()
	}

}

class TrooperCadete inherits Trooper {

	override method puntosQueOtorga() = 2

	override method sufijo() = "cadete-"

}

class TrooperSargento inherits Trooper {

	override method puntosQueOtorga() = 3

	override method sufijo() = "sargento-"

}

const cadete = new TrooperCadete(position = new PosicionMutable(x = 10, y = 12), alcanceDisparo = 3)

const cadete2 = new TrooperCadete(position = new PosicionMutable(x = 2, y = 2), alcanceDisparo = 3)

