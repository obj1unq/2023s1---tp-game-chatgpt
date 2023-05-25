import wollok.game.*
import Objeto.*

class NoColisionable inherits Objeto {

	override method desaparecer() {
		game.colliders(self).first().desaparecer()
	}

}

