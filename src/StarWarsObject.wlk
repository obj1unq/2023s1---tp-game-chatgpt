import wollok.game.*

class StarWarsObject {

	var property position

	method esColisionable() = true

	method image()

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method colision(objeto) {
	}

	method colionasteConBomba(objeto) {
	}

	method colisionasteConCaja(objeto) {
	}

	method colisionasteConLaser(objeto) {
	}

	method colisionasteConMandalorian(objeto) {
	}

	method colisionasteConPlataforma(objeto) {
	}

	method colisionasteConPortal(objeto) {
	}

	method colisionasteConTrooper(objeto) {
	}

}

