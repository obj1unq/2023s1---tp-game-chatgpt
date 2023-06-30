import wollok.game.*
import Direccion.*
import Enemigo.*
import EstadoPersonaje.*
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

	override method nuevoEnemigo() = new TrooperCadete(position = self.posicionAleatoria(), alcanceDisparo = 1.randomUpTo(4), estado = trooperVivo)

	override method posicionAleatoria() = [ new PosicionMutable(x = 16, y = 7), new PosicionMutable(x = 4, y = 7) ].anyOne()

}

object trooperSargentoFactory inherits EnemigoFactory {

	const direcciones = [ abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, abajo, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba, arriba ]

	override method nuevoEnemigo() {
		const positionRandom = self.posicionAleatoria()
		return new TrooperSargento(position = positionRandom, estado = trooperVivo, direccionesAleatoria = self.respawn(positionRandom))
	}

	override method posicionAleatoria() = [ new PosicionMutable(x = 12, y = 13), new PosicionMutable(x = 8, y = 1) ].anyOne()

	method respawn(posicionAleatoria) = if (posicionAleatoria.y() == 13) direcciones else direcciones.reverse()

}

object lordSithFactory inherits EnemigoFactory {

	override method posicionAleatoria() = [ new PosicionMutable(x = 16, y = 7), new PosicionMutable(x = 4, y = 7) ].anyOne()

	override method nuevoEnemigo() = new LordSith(position = self.posicionAleatoria(), estado = lordSithVivo)

}

