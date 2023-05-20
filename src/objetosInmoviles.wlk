import wollok.game.*
import pantalla.*
import jugador.*

class Caja {

	var property position
	const property atravesable = false

	method image() {
		return "caja.png"
	}

}

class Disparo {

	var property position
	var property danio = null
	var property direccion
	var property colision = false
	const property atravesable = true	
	var alcance = 5
	
	
	method image() {
		return "laser-rojo-" + direccion + ".png"
	}
	
	method trayectoria() {
		if ( pantalla.estaDentro(position) and alcance > 0) {	//1ero calcular a dnd ir, para no usar pantalla.estaDentro(position)
			
			self.position(direccion.next(self))
			alcance -= 1
			
		} else {
				game.removeTickEvent(self.identity().toString())
				game.removeVisual(self)
		}
	}
	
	method esPositionNull(){
		return game.colliders(self).isEmpty()
	}

	method disparar() {
		game.onTick(25, self.identity().toString(), { self.trayectoria()})
		game.onCollideDo(self,{enemigo => enemigo.morirPersonaje()})
	}

	method hayObjetosAtravesables() {
		return game.colliders(self).any({ objeto => not objeto.atravesable() })
	}
	
}

