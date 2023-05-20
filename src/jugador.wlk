import Direction.*
import wollok.game.*
import objetosInmoviles.*

object personaje {

	var property position = game.center()
	var property direccionDondeMira = abajo
	const property atravesable = true
	var property estatus = vivo
	var cooldown = false

	method image() = "heroe-" + direccionDondeMira.toString() + ".png"

	method mover(direccion) {
		direccionDondeMira = direccion
		direccion.mover(self)
	}

	method disparar() {
		
		if (not cooldown){
			const disparo = new Disparo(position = direccionDondeMira.next(self), direccion = direccionDondeMira)
			game.addVisual(disparo)
			disparo.disparar()
			cooldown = true
			game.schedule(800,{self.cooldownSet()})
		}
	}
	
	method cooldownSet(){
		 cooldown = not cooldown
	}
	
	method morirPersonaje(){
				 
		game.removeVisual(self)
	}
}

object vivo {

	method estado() {
	}

}

object muerto {

	method estado() {
	}

}

object enemigo {

	var property position = game.center()
	var property direccionDondeMira = derecha
	const property atravesable = true
	var property estatus = vivo
	var cooldown = false

	method image() = "villano-" + direccionDondeMira.toString() + ".png"

	method mover(direccion) {
		direccionDondeMira = direccion
		direccion.mover(self)
	}

	method disparar() {
		
		if (not cooldown){
			const disparo = new Disparo(position = direccionDondeMira.next(self), direccion = direccionDondeMira)
			game.addVisual(disparo)
			disparo.disparar()
			cooldown = true
			game.schedule(800,{self.cooldownSet()})
		}
	}
	
	method cooldownSet(){
		 cooldown = not cooldown
	}
	
	method morirPersonaje(){
				 
		game.removeVisual(self)
	}
}