import wollok.game.*

object pantalla {

	method estaDentro(posicionPersonaje) {
		return self.estaDentroDeEjeX(posicionPersonaje) && self.estaDentroDeEjeY(posicionPersonaje)
	}

	method estaDentroDeEjeX(posicionPersonaje) {
		return posicionPersonaje.x().between(1, game.width() - 2)
	}

	method estaDentroDeEjeY(posicionPersonaje) {
		return posicionPersonaje.y().between(2, game.height() - 4)
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

