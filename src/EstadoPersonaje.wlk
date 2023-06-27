import wollok.game.*

class EstadoPersonaje {

	method disparar(personaje) {
	}

	method mover(personaje, direccion) {
	}

}

object vivo inherits EstadoPersonaje {

	override method disparar(personaje) {
		personaje.crearDisparo()
	}

	override method mover(personaje, direccion) {
		personaje.direccionDondeMira(direccion)
		direccion.mover(personaje)
	}

}

object muerto inherits EstadoPersonaje {

}

