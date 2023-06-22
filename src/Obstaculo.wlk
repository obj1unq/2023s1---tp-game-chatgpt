import wollok.game.*

class Obstaculo {

	var property position

	method image() {
		return "caja.png"
	}

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		game.colliders(self).first().desaparecer()
	}

}

