import wollok.game.*

object atravesable {

	method eliminar(disparo, objeto) {
		objeto.eliminar()
		disparo.eliminar()
	}

}

object noAtravesable {

	method eliminar(disparo, objeto) {
		disparo.eliminar()
	}

}

object vivo {

// method accionPara(personaje) {
// game.addVisual(personaje)
// }
}

object muerto {

// method accionPara(personaje) {
// game.removeVisual(personaje)
// }
}

