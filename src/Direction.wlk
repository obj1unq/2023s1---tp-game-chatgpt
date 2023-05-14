import pantalla.*

// CLASE ABSTRACTA
mixin Direction {

	method mover(personaje) {
		pantalla.mover(personaje, self)
	}

	method next(personaje)

}

object arriba inherits Direction {

	override method next(personaje) {
		return personaje.position().up(1)
	}

}

object abajo inherits Direction {

	override method next(personaje) {
		return personaje.position().down(1)
	}

}

object derecha inherits Direction {

	override method next(personaje) {
		return personaje.position().right(1)
	}

}

object izquierda inherits Direction {

	override method next(personaje) {
		return personaje.position().left(1)
	}

}

