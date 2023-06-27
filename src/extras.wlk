import wollok.game.*
import Background.*
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
		mandalorian.reiniciarEstado()
		keyboard.r().onPressDo({ nivelUno.iniciar()})
	}

}

object portal inherits StarWarsObject(position = new PosicionMutable(x = 10, y = 7)) {

	var property nivel = mandalorian.nivelDondeSeEncuentra()

	method esColisionable() = true

	override method image() = "portal-" + (if(mandalorian.cumplioLaMision()) "activo" else "inactivo") + ".png"

	override method aparecer() {
		super()
		game.onCollideDo(self, { objecto => objecto.pasarDeNivel(self)})
	}

	method subirDeNivel() {
		if (mandalorian.cumplioLaMision()) {
			mandalorian.cambiarDeNivel(nivel.siguienteNivel())
			console.println(mandalorian.nivelDondeSeEncuentra())
			nivel.siguienteNivel().iniciar()
			self.nivel(nivel.siguienteNivel())
			console.println(self.nivel())
			mandalorian.reiniciarEstado()
		} else {
			game.say(self, "NO SE CUMPLIO LA MISION!!")
		}
	}

	method colision(objeto) {
	}

	override method desaparecer() {
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

