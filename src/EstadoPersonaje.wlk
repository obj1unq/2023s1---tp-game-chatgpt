class EstadoPersonaje {

	method accion(personaje, colorLaser) {
	}

	method mover(personaje, direccion) {
	}

	method condicionPara(personaje)

}

object vivo inherits EstadoPersonaje {

	override method accion(personaje, colorLaser) {
		personaje.dispararCon(colorLaser)
	}

	override method mover(personaje, direccion) {
		personaje.direccionDondeMira(direccion)
		direccion.mover(personaje)
	}

	override method condicionPara(personaje) = personaje.direccionDondeMira().toString()

}

object muerto inherits EstadoPersonaje {

	override method condicionPara(personaje) = "tumba"

}

