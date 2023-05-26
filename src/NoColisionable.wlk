import wollok.game.*
import Objeto.*

class NoColisionable inherits Objeto {

	override method desaparecer(proyectil) {
		game.colliders(self).first().desaparecer(proyectil)
	}

}

