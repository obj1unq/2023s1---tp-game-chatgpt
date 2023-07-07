import wollok.game.*
import StarWarsObject.*
import Personaje.*
import PosicionMutable.*

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
		self.estado().cambiarDeNivel(self)
	}

}

class EstadoPortal {

	method condicion() = self.toString()

}

object activo inherits EstadoPortal {

	method cambiarDeNivel(portal) {
		mandalorian.teletranspotarse()
		mandalorian.nivelDondeSeEncuentra().iniciar()
	}

}

object inactivo inherits EstadoPortal {

	method cambiarDeNivel(portal) {
		game.say(portal, "NO SE CUMPLIO LA MISION!!")
	}

}

