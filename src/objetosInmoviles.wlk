import wollok.game.*

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
	
	method image(){
		return "laser-rojo-" + direccion + ".png"
	}
	
	method trayectoria(){
		
		if (not self.hayObjetosAtravesables()){
			self.position(self.direccion().next(self))
		} 
////		else {
////			//colision = true
////			game.removeTickEvent("disparo")
////			game.removeVisual(self)
////		}
	}
	
	method disparar(){
		game.onTick(100, "disparo", {self.trayectoria()})
	}
	
	method hayObjetosAtravesables(){
		const arrayDeObjetosEnCelda = game.getObjectsIn(direccion.next(self)).filter({objeto => objeto!= self})
		return arrayDeObjetosEnCelda.any({ objeto => not objeto.atravesable() })
		
	}
	
}

