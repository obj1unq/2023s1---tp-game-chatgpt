import extras.*
import Nivel.nivelUno
import Personaje.*
import PosicionMutable.*
import Direccion.abajo

class EstadoPersonaje {

	method condicion() = true

	method puedeMoverse() = true

	method puedeRealizarLaAccion(personaje) = not screen.hayObjetoAdelante(personaje.direccionProxima()) && self.condicion()

}

class EstadoMandalorian inherits EstadoPersonaje {

	override method condicion() = true

	method reiniciarPara(personaje) {
		personaje.position(new PosicionMutable(x = 19, y = 12))
		personaje.vida(2)
		personaje.score(0)
		personaje.direccionDondeMira(abajo)
	}

	method teEliminaron(personaje) {
	}

}

object mandalorianDerrotado inherits EstadoMandalorian {

	override method condicion() = false

	override method puedeMoverse() = false

	override method reiniciarPara(personaje) {
		super(personaje)
		personaje.estado(mandalorianVivo)
		personaje.nivelDondeSeEncuentra(nivelUno)
	}

}

object mandalorianGanador inherits EstadoMandalorian {

}

object mandalorianVivo inherits EstadoMandalorian {

	override method reiniciarPara(personaje) {
	}

}

class EstadoEnemigo inherits EstadoPersonaje {

	override method condicion() = true

	method teEliminaron(enemigo) {
	}

}

object enemigoDerrotado inherits EstadoEnemigo {

	override method condicion() = false

	override method puedeMoverse() = false

	override method teEliminaron(enemigo) {
		enemigo.removerEvento()
		mandalorian.sumarScore(enemigo.puntosQueOtorga())
	}

}

object enemigoVivo inherits EstadoEnemigo {

}

