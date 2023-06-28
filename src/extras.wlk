import wollok.game.*
import Background.*
import EstadoPersonaje.*
import Nivel.*
import StarWarsObject.*
import Personaje.*
import PosicionMutable.*

object mainMenu {

	method iniciar() {
		fondoInicio.aparecer()
		keyboard.space().onPressDo({ nivelUno.iniciar()})
	}

}

object gameOver {

	method finalizarJuego() {
		fondoGameOver.aparecer()
		keyboard.r().onPressDo({ nivelUno.iniciar()})
	}

}

object portal inherits StarWarsObject(position = new PosicionMutable(x = 10, y = 7)) {

	var property nivel = mandalorian.nivelDondeSeEncuentra()

	override method image() = "portal-" + (if(mandalorian.cumplioLaMision()) "activo" else "inactivo") + ".png"

	override method aparecer() {
		super()
		game.onCollideDo(self, { objecto => objecto.colision(self)})
	}

	method subirDeNivel() {
		if (mandalorian.cumplioLaMision()) {
			mandalorian.nivelDondeSeEncuentra(nivel.siguienteNivel())
			self.nivel(nivel.siguienteNivel())
			mandalorian.estado(mandalorianGanador)
			mandalorian.reiniciarEstado()
			nivel.siguienteNivel().iniciar()
		} else {
			game.say(self, "NO SE CUMPLIO LA MISION!!")
		}
	}

	override method colision(objeto) {
		objeto.colisionasteConPortal(self)
	}

	override method colisionasteConMandalorian(objeto) {
		self.subirDeNivel()
	}

}

object plataforma inherits StarWarsObject(position = new PosicionMutable(x = 19, y = 12)) {

	override method image() = "plataforma.png"

	override method colision(objeto) {
		objeto.colisionasteConPlataforma(self)
	}

}

object screen {

	method estaDentro(posicionObjeto) {
		return self.estaDentroDeEjeX(posicionObjeto) && self.estaDentroDeEjeY(posicionObjeto)
	}

	method estaDentroDeEjeX(posicionObjeto) {
		return posicionObjeto.x().between(0, self.limiteX())
	}

	method estaDentroDeEjeY(posicionObjeto) {
		return posicionObjeto.y().between(1, self.limiteY())
	}

	method hayObjetoAdelante(posicion) = game.getObjectsIn(posicion).any{ objeto => not objeto.esColisionable() }

	method limiteX() = game.width() - 2

	method limiteY() = game.height() - 2

	method puedeMover(objeto, direccion) = self.estaDentro(direccion.proxima(objeto)) && not self.hayObjetoAdelante(direccion.proxima(objeto))

	method mover(objeto, direccion) {
		if (self.puedeMover(objeto, direccion)) {
			direccion.moverProxima(objeto)
		}
	}

}

