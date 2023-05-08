import wollok.game.*

object screen {

	method estaDentro(positionObjecto) {
		return self.estaDentroDeEjeX(positionObjecto) && self.estaDentroDeEjeY(positionObjecto)
	}

	method estaDentroDeEjeX(positionObjecto) {
		return positionObjecto.x().between(0, game.width() - 1)
	}

	method estaDentroDeEjeY(positionObjecto) {
		return positionObjecto.y().between(0, game.height() - 2)
	}

	method mover(objeto, positionObjecto) {
		if (self.estaDentro(positionObjecto)) {
			objeto.position(positionObjecto)
		}
	}

}

object arriba {

	method mover(objeto) {
		screen.mover(objeto, objeto.position().up(1))
	// objeto.direccionADondeMira(self)
	}

}

object abajo {

	method mover(objeto) {
		screen.mover(objeto, objeto.position().down(1))
	// objeto.direccionADondeMira(self)
	}

}

object izquierda {

	method mover(objeto) {
		screen.mover(objeto, objeto.position().left(1))
	// objeto.direccionADondeMira(self)
	}

}

object derecha {

	method mover(objeto) {
		screen.mover(objeto, objeto.position().right(1))
	// objeto.direccionADondeMira(self)
	}

}

