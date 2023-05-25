/* 
 * class EstadoPersonaje {

 * 	const property personaje

 * 	method accion() {
 * 	}

 * 	method mover(direccion) {
 * 	}

 * 	method desaparecer()

 * }

 * class Vivo inherits EstadoPersonaje {

 * 	override method accion() {
 * 		personaje.disparar()
 * 	}

 * 	override method mover(direccion) {
 * 		personaje.direccionMovimiento(direccion)
 * 		direccion.mover(personaje)
 * 	}

 * 	override method desaparecer() {
 * 	}

 * }

 * class Muerto inherits EstadoPersonaje {

 * 	override method desaparecer() {
 * 		personaje.estado(self)
 * 	}

 * }
 */

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

