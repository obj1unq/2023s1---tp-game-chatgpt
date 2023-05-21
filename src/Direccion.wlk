import pantalla.*

class Direccion {

	method mover(personaje) {
		pantalla.mover(personaje, self)
	}

	method proxima(personaje)

}

object arriba inherits Direccion {

	override method proxima(personaje) {
		return personaje.position().up(1)
	}

}

object abajo inherits Direccion {

	override method proxima(personaje) {
		return personaje.position().down(1)
	}

}

object derecha inherits Direccion {

	override method proxima(personaje) {
		return personaje.position().right(1)
	}

}

object izquierda inherits Direccion {

	override method proxima(personaje) {
		return personaje.position().left(1)
	}

}

