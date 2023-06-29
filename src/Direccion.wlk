class Direccion {

	method moverProxima(objeto)

	method proxima(objeto)

	method mover(objeto, direccion) {
		direccion.moverProxima(objeto)
	}

}

object arriba inherits Direccion {

	override method proxima(objeto) = objeto.position().up(1)

	override method moverProxima(objeto) {
		objeto.position().up()
	}

}

object abajo inherits Direccion {

	override method proxima(objeto) = objeto.position().down(1)

	override method moverProxima(objeto) {
		objeto.position().down()
	}

}

object derecha inherits Direccion {

	override method proxima(objeto) = objeto.position().right(1)

	override method moverProxima(objeto) {
		objeto.position().right()
	}

}

object izquierda inherits Direccion {

	override method proxima(objeto) = objeto.position().left(1)

	override method moverProxima(objeto) {
		objeto.position().left()
	}

}

