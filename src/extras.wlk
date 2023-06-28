import wollok.game.*
import Background.*
import EstadoPersonaje.*
import Nivel.*
import StarWarsObject.*
import Personaje.*
import PosicionMutable.*

object starWarsGame {

	method iniciar() {
		game.title("Star Wars Game")
		game.height(15)
		game.width(22)
		fondoInicio.aparecer()
		keyboard.space().onPressDo({ nivelUno.iniciar()})
		game.start()
	}

}

object gameOver {

	method reiniciarJuego() {
		game.clear()
		fondoGameOver.aparecer()
		keyboard.r().onPressDo({ nivelUno.iniciar()})
	}

}

object portal inherits StarWarsObject(position = new PosicionMutable(x = 10, y = 7)) {

	var property estado = inactivo
	var property nivel = nivelUno

	method estado() = if (mandalorian.cumplioLaMision()) activo else inactivo

	override method image() = "portal-" + self.estado().condicion() + ".png"

	method siguienteNivel() = nivel.siguienteNivel()

	override method aparecer() {
		super()
		game.onCollideDo(self, { objecto => objecto.colision(self)})
	}

	override method colision(objeto) {
		objeto.colisionasteConPortal(self)
	}

	override method colisionasteConMandalorian(objeto) {
		estado.cambiarDeNivel()
	}

}

object inactivo {

	method condicion() = self.toString()

	method cambiarDeNivel() {
		portal.nivel(portal.siguienteNivel())
		mandalorian.teletranspotarse()
		portal.nivel().iniciar()
	}

}

object activo {

	method condicion() = self.toString()

	method cambiarDeNivel() {
		game.say(self, "NO SE CUMPLIO LA MISION!!")
	}

}

object plataforma inherits StarWarsObject(position = new PosicionMutable(x = 19, y = 12)) {

	override method image() = "plataforma.png"

	override method colision(objeto) {
		objeto.colisionasteConPlataforma(self)
	}

}

