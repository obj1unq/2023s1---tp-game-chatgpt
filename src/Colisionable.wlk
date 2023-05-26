import Objeto.*
import wollok.game.*

class Colisionable inherits Objeto {

	override method desaparecer() {
		game.removeVisual(self)
	}

}

