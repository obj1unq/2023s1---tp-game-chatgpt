import wollok.game.*
import PosicionMutable.*
import StarWarsObject.*

class Background {

	var property position = new PosicionMutable(x = 0, y = 0)
	var property fondo = null

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

