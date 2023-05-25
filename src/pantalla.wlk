import wollok.game.*

object pantalla {

	method estaDentro(posicionPersonaje) {
		return self.estaDentroDeEjeX(posicionPersonaje) && self.estaDentroDeEjeY(posicionPersonaje)
	}

	method estaDentroDeEjeX(posicionPersonaje) {
		return posicionPersonaje.x().between(0, game.width() - 1)
	}

	method estaDentroDeEjeY(posicionPersonaje) {
		return posicionPersonaje.y().between(0, game.height() - 2)
	}

	method mover(personaje, direccion) {
		if (self.estaDentro(direccion.proxima(personaje)) && not self.hayObjetoAdelante(direccion.proxima(personaje))) {
			personaje.position(direccion.proxima(personaje))
		}
	}

	method hayObjetoAdelante(posicion) {
		return game.getObjectsIn(posicion).any({ objeto => objeto.position().equals(posicion) })
	}

}

