import Direction.*
import wollok.game.*

object personaje {

	var property position = game.center()
	var property direccionDondeMira = abajo

	method image() = "heroe-" + direccionDondeMira.toString() + ".png"

	method mover(direccion) {
		direccionDondeMira = direccion
		direccion.mover(self)
	}

}

