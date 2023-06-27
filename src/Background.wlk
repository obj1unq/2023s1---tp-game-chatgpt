import wollok.game.*
import PosicionMutable.*
import StarWarsObject.*

class Background inherits StarWarsObject(position = new PosicionMutable()) {

	var property fondo = null

	override method image() = "background-" + fondo + ".png"

}

const fondoInicio = new Background(fondo = "inicio")

const fondoNivelUno = new Background(fondo = "nivelUno")

const fondoNivelDos = new Background(fondo = "nivelDos")

const fondoNivelTres = new Background(fondo = "nivelTres")

const fondoGameOver = new Background(fondo = "gameOver")

