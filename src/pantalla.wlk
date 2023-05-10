import wollok.game.*
import objetosInmoviles.*

object pantalla {

	const property elementos = [ new Caja(position = game.at(10,5)), new Caja(position = game.at(7,5)), new Caja(position = game.at(7,13)) ]

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
		if (self.estaDentro(direccion.siguente(personaje)) && not self.hayObjetoAdelante(direccion.siguente(personaje))) {
			personaje.position(direccion.siguente(personaje))
		}
	}

	method hayObjetoAdelante(coordenada) {
		return elementos.any({ elemento => elemento.position() == coordenada })
	}

}

