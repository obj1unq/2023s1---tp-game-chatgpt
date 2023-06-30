class Direccion {

	method moverProxima(objeto)

	method proxima(objeto)

	method mover(objeto, direccion) {
		direccion.moverProxima(objeto)
	}

	method opuesto()

}

object arriba inherits Direccion {

	override method proxima(objeto) = objeto.position().up(1)

	override method moverProxima(objeto) {
		objeto.position().up()
	}

	override method opuesto() {
		return abajo
	}

}

object abajo inherits Direccion {

	override method proxima(objeto) = objeto.position().down(1)

	override method moverProxima(objeto) {
		objeto.position().down()
	}

	override method opuesto() {
		return arriba
	}

}

object derecha inherits Direccion {

	override method proxima(objeto) = objeto.position().right(1)

	override method moverProxima(objeto) {
		objeto.position().right()
	}

	override method opuesto() {
		return izquierda
	}

}

object izquierda inherits Direccion {

	override method proxima(objeto) = objeto.position().left(1)

	override method moverProxima(objeto) {
		objeto.position().left()
	}

	override method opuesto() {
		return derecha
	}

}

