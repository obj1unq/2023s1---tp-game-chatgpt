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

	const direcciones = [ abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba ]

	override method posicionAleatoria() = [ new PosicionMutable(x = 12, y = 13), new PosicionMutable(x = 8, y = 1) ].anyOne()

	method respawn(posicionAleatoria) {
		console.println("position " + posicionAleatoria)
		return if (posicionAleatoria.y() == 13) direcciones else direcciones.reverse()
	}

	override method nuevoEnemigo() {
		const positionRandom = self.posicionAleatoria()
		return new TrooperSargento(position = positionRandom, estado = enemigoVivo, direccionesAleatoria = self.respawn(positionRandom))
	}

}

object lordSithFactory inherits EnemigoFactory {

	override method posicionAleatoria() = [ new PosicionMutable(x = 16, y = 7), new PosicionMutable(x = 4, y = 7) ].anyOne()

	override method nuevoEnemigo() {
		return new LordSith(position = self.posicionAleatoria(), estado = enemigoVivo)
	}

}

