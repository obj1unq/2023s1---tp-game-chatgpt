object vivo {

	method accion(personaje) {
		personaje.disparar()
	}

	method mover(personaje, direccion) {
		personaje.direccionMovimiento(direccion)
		direccion.mover(personaje)
	}

	method desaparecer(personaje) {
	}

}

object muerto {

	method accion(personaje) {
	}

	method desaparecer(personaje) {
		personaje.estado(self)
	}

	method mover(personaje, direccion) {
	}

}