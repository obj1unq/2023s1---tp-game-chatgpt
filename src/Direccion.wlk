import extras.*

class Direccion {

	method mover(objeto) {
		screen.mover(objeto, self)
	}

	method proxima(objeto)

	method estaEnLimite(objeto)

	method moverProxima(objeto) {
	}

}

class DireccionX inherits Direccion {

	override method estaEnLimite(objeto) {
		return screen.estaDentroDeEjeX(objeto.position())
	}

}

class DireccionY inherits Direccion {

	override method estaEnLimite(objeto) {
		return screen.estaDentroDeEjeY(objeto.position())
	}

}

object arriba inherits DireccionY {

	override method moverProxima(objeto) {
		objeto.position().up()
	}

	override method proxima(objeto) = objeto.position().up(1)

}

object abajo inherits DireccionY {

	override method moverProxima(objeto) {
		objeto.position().down()
	}

	override method proxima(objeto) = objeto.position().down(1)

}

object derecha inherits DireccionX {

	override method moverProxima(objeto) {
		objeto.position().right()
	}

	override method proxima(objeto) = objeto.position().right(1)

}

object izquierda inherits DireccionX {

	override method moverProxima(objeto) {
		objeto.position().left()
	}

	override method proxima(objeto) = objeto.position().left(1)

}

