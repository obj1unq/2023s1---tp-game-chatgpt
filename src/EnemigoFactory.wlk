import wollok.game.*
import Direccion.*
import EstadoPersonaje.*
import Personaje.*
import PosicionMutable.*

class EnemigoFactory {

	method nuevoEnemigo()

	method posicionAleatoria()

	method generarPara(nivel) {
		if (nivel.cantidadEnemigosActivos() < nivel.cantMaxEnemigosSoportados()) {
			const nuevoEnemigo = self.nuevoEnemigo()
			nivel.agregarEnemigo(nuevoEnemigo)
			console.println(nivel.personajes())
			console.println(nivel.cantidadEnemigosActivos())
			nuevoEnemigo.aparecer()
		}
	}

}

object trooperCadeteFactory inherits EnemigoFactory {

	override method posicionAleatoria() = [ new PosicionMutable(x = 16, y = 7), new PosicionMutable(x = 4, y = 7) ].anyOne()

	override method nuevoEnemigo() {
		return new TrooperCadete(position = self.posicionAleatoria(), alcanceDisparo = 1.randomUpTo(4), estado = enemigoVivo)
	}

}

object trooperSargentoFactory inherits EnemigoFactory {

	override method posicionAleatoria() = [ new PosicionMutable(x = 12, y = 13), new PosicionMutable(x = 8, y = 1) ].anyOne()

	override method nuevoEnemigo() {
		return new TrooperSargento(position = self.posicionAleatoria(), estado = enemigoVivo)
	}

}

