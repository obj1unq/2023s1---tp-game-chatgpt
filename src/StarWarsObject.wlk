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

	method colision(objeto)

	method colionasteConBomba(objeto) {
	}

	method colisionasteConCaja(objeto) {
	}

	method colisionasteConLaser(objeto) {
	}

	method colisionasteConMandalorian(objeto) {
	}

	method colisionasteConPortal(objeto) {
	}

	method colisionasteConTrooper(objeto) {
	}

	method estaDentro(posicionObjeto) = self.estaDentroDeEjeX(posicionObjeto) && self.estaDentroDeEjeY(posicionObjeto)

	method estaDentroDeEjeX(posicionObjeto) = posicionObjeto.x().between(0, self.limiteX())

	method estaDentroDeEjeY(posicionObjeto) = posicionObjeto.y().between(1, self.limiteY())

	method limiteX() = game.width() - 2

	method limiteY() = game.height() - 2

	method hayObjetoAdelante(posicion) = game.getObjectsIn(posicion).any{ objeto => not objeto.esColisionable() }

	method puedeMoverse(objeto, direccion) = self.estaDentro(direccion.proxima(objeto)) && not self.hayObjetoAdelante(direccion.proxima(objeto))

}

