import extras.*
import Direccion.*
import Enemigo.*
import Nivel.*
import Personaje.*
import PosicionMutable.*

class EstadoPersonaje {

	method condicion()

	method puedeMoverse()

	method puedeRealizarLaAccion(personaje) = personaje.puedeMoverse(personaje, personaje.direccionDondeMira()) && self.condicion()

	method teEliminaron(personaje) {
	}

}

class EstadoMandalorian inherits EstadoPersonaje {

	override method condicion() = true

	override method puedeMoverse() = true

	method reiniciar() {
		mandalorian.position(new PosicionMutable(x = 19, y = 12))
		mandalorian.vida(2)
		mandalorian.score(0)
		mandalorian.direccionDondeMira(abajo)
	}

}

object mandalorianDerrotado inherits EstadoMandalorian {

	override method condicion() = false

	override method puedeMoverse() = false

	override method teEliminaron(personaje) {
		gameOver.reiniciarJuego()
		self.reiniciar()
	}

	override method reiniciar() {
		super()
		mandalorian.estado(mandalorianVivo)
		mandalorian.nivelDondeSeEncuentra(nivelUno)
	}

}

object mandalorianGanador inherits EstadoMandalorian {

}

object mandalorianVivo inherits EstadoMandalorian {

}

