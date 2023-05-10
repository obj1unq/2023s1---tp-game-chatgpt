import pantalla.*

// CLASE ABSTRACTA
mixin Direction {

	method mover(personaje) {
		pantalla.mover(personaje, self)
	}

	method siguente(personaje) {
		return "NO POSEE IMPLENTACIÓN."
	}

}

object arriba inherits Direction {

	override method siguente(personaje) {
		return personaje.position().up(1)
	}

}

object abajo inherits Direction {

	override method siguente(personaje) {
		return personaje.position().down(1)
	}

}

object derecha inherits Direction {

	override method siguente(personaje) {
		return personaje.position().right(1)
	}

}

object izquierda inherits Direction {

	override method siguente(personaje) {
		return personaje.position().left(1)
	}

}

