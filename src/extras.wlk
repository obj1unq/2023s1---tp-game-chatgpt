import wollok.game.*
import Posicion.*
import Nivel.*
import EnemigoFactory.*
import Personaje.*

object starsWarsGame {

	method iniciar() {
		mainMenu.iniciar()
	}

}

object mainMenu {

	method iniciar() {
		background.fondo("inicio")
		game.addVisual(background)
		self.reproducirMusica()
		keyboard.any().onPressDo({ nivelUno.iniciar()})
	}

	method reproducirMusica() {
		game.schedule(1000, { => sonidoMainMenu.play()})
	}

	method detenerMusica() {
		sonidoMainMenu.stop()
	}

	method finalizar() {
		game.clear()
		self.detenerMusica()
	}

}

object background {

	var property position = new Posicion(x = 0, y = 0)
	var property fondo = null

	method image() {
		return "background-" + fondo + ".png"
	}

	method aparecer() {
		game.addVisual(self)
	}

}

object gameOver {

	method finalizarJuego() {
		game.clear()
		self.fondo()
		heroe.vida(2)
		trooperFactory.personajes().clear()
	}

	method fondo() {
		background.fondo("gameOver")
		background.aparecer()
		keyboard.r().onPressDo({ nivelUno.iniciar()})
	}

}

object pantalla {

	method estaDentro(posicionObjeto) {
		return self.estaDentroDeEjeX(posicionObjeto) && self.estaDentroDeEjeY(posicionObjeto)
	}

	method estaDentroDeEjeX(posicionObjeto) {
		return posicionObjeto.x().between(1, game.width() - 2)
	}

	method estaDentroDeEjeY(posicionObjeto) {
		return posicionObjeto.y().between(1, game.height() - 3)
	}

	method mover(objeto, direccion) {
		if (self.estaDentro(direccion.proxima(objeto)) && not self.hayObjetoAdelante(direccion.proxima(objeto))) {
			objeto.position(direccion.proxima(objeto))
		}
	}

	method hayObjetoAdelante(posicion) {
		return not game.getObjectsIn(posicion).isEmpty()
	}

}

// INSTANCIAS
const sonidoMainMenu = game.sound("musicaIntro.mp3")

