import wollok.game.*

object atravesable {

	method eliminar(disparo, objeto) {
		objeto.eliminar()
		disparo.eliminar()
	}

}

object noAtravesable {

	method eliminar(disparo, objeto) {
		disparo.eliminar()
	}

}

object vivo {

	method mover(direccion, personaje) {
		personaje.direccionDondeMira(direccion)
		direccion.mover(personaje)
	}

	method accion(personaje) {
		personaje.disparar()
	}

}

object muerto {

	method mover(direccion, personaje) {
	}

	method accion(personaje) {
	}

}

object tumba {

}

