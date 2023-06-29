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

object gameWin {

	method iniciar() {
		game.clear()
		fondoGameWin.aparecer()
		game.schedule(4000, { game.stop()})
	}

}

object portal inherits StarWarsObject(position = new PosicionMutable(x = 10, y = 7)) {

	method estado() = if (mandalorian.cumplioLaMision()) activo else inactivo

	override method image() = "portal-" + self.estado().condicion() + ".png"

	override method aparecer() {
		super()
		game.onCollideDo(self, { objecto => objecto.colision(self)})
	}

	override method colision(objeto) {
		objeto.colisionasteConPortal(self)
	}

	override method colisionasteConMandalorian(objeto) {
		console.println(self.estado())
		self.estado().cambiarDeNivel(self)
	}

}

object activo {

	method condicion() = self.toString()

	method cambiarDeNivel(portal) {
		console.println("PORTAL ACTIVO")
		mandalorian.teletranspotarse()
		mandalorian.nivelDondeSeEncuentra().iniciar()
	}

}

object inactivo {

	method condicion() = self.toString()

	method cambiarDeNivel(portal) {
		console.println("PORTAL INACTIVO")
		game.say(portal, "NO SE CUMPLIO LA MISION!!")
	}

}

