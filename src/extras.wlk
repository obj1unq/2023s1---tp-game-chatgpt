import wollok.game.*

object pantalla {

	method estaDentro(posicionObjeto) {
		return self.estaDentroDeEjeX(posicionObjeto) && self.estaDentroDeEjeY(posicionObjeto)
	}

	method estaDentroDeEjeX(posicionObjeto) {
		return posicionObjeto.x().between(0, game.width())
	}

	method estaDentroDeEjeY(posicionObjeto) {
		return posicionObjeto.y().between(0, game.height())
	}

	method mover(objeto, direccion) {
		if (self.puedeMover(objeto, direccion)) {
			objeto.position(direccion.proxima(objeto))
		}
	}

	method puedeMover(objeto, direccion) = self.estaDentro(direccion.proxima(objeto)) && not self.hayObjetoAdelante(direccion.proxima(objeto))

	method hayObjetoAdelante(posicion) = game.getObjectsIn(posicion).any{ objeto => not objeto.esColisionable() }

}

