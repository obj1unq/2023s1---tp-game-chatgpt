import wollok.game.*
import PosicionMutable.*

class Background {

	var property fondo = null
	var property position = new PosicionMutable(x = 0, y = 0)

	method image() = "background-" + fondo + ".png"

	method aparecer() {
		game.addVisual(self)
	}

}

const fondoInicio = new Background(fondo = "inicio")

const fondoNivelUno = new Background(fondo = "nivelUno")

const fondoNivelDos = new Background(fondo = "nivelDos")

const fondoNivelTres = new Background(fondo = "nivelTres")

const fondoGameOver = new Background(fondo = "gameOver")

const fondoGameWin = new Background(fondo = "gameWin")

