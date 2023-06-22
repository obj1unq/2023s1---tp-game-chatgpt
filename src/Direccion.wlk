import extras.*

class Direccion {

	method mover(objeto) {
		pantalla.mover(objeto, self)
	}

	method proxima(objeto)

}

object arriba inherits Direccion {

	override method proxima(objeto) {
		return objeto.position().up(1)
	}

}

object abajo inherits Direccion {

	override method proxima(objeto) {
		return objeto.position().down(1)
	}

}

object derecha inherits Direccion {

	override method proxima(objeto) {
		return objeto.position().right(1)
	}

}

object izquierda inherits Direccion {

	override method proxima(objeto) {
		return objeto.position().left(1)
	}

}

