import Direction.*
import wollok.game.*
import objetosInmoviles.*

object personaje {

	var property position = game.center()
	var property direccionDondeMira = abajo
	const property atravesable = true
	

	method image() = "heroe-" + direccionDondeMira.toString() + ".png"

	method mover(direccion) {
		direccionDondeMira = direccion
		direccion.mover(self)
	}
	
	method disparar(){
		var disparo = new Disparo(position = direccionDondeMira.next(self), direccion = direccionDondeMira)
		game.addVisual(disparo)
		disparo.disparar()
	}

}

