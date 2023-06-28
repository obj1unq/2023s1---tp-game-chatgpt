import extras.*

class Direccion {

	method mover(objeto, direccion) {
		direccion.moverProxima(objeto)
	}

	method proxima(objeto)

	method moverProxima(objeto) {
	}

}

object arriba inherits Direccion {

	override method moverProxima(objeto) {
		objeto.position().up()
	}

	override method proxima(objeto) = objeto.position().up(1)

}

object abajo inherits Direccion {

	override method moverProxima(objeto) {
		objeto.position().down()
	}

	override method proxima(objeto) = objeto.position().down(1)

}

object derecha inherits Direccion {

	override method moverProxima(objeto) {
		objeto.position().right()
	}

	override method proxima(objeto) = objeto.position().right(1)

}

object izquierda inherits Direccion {

	override method moverProxima(objeto) {
		objeto.position().left()
	}

	override method proxima(objeto) = objeto.position().left(1)

}

