import wollok.game.*

class EstadoPersonaje {

	method disparar(personaje) {
	}

	method mover(personaje, direccion) {
	}

	method condicionPara(personaje)

}

object vivo inherits EstadoPersonaje {

	override method disparar(personaje) {
		personaje.disparo()
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

const soundDisparo = game.sound("disparo.mp3")

