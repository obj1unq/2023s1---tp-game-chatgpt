import wollok.game.*
import direccion.*

object personaje {

	var property position = game.center()
	var property direccionDondeMira = abajo

	method image() = "heroe-" + direccionDondeMira.toString() + ".png"

	method mover(direccion) {
		direccion.mover(self)
		direccionDondeMira = direccion
	}

}

