import extras.*
import Nivel.nivelUno
import Personaje.*
import PosicionMutable.*
import Direccion.abajo

class EstadoPersonaje {

	method condicion()

	method puedeMoverse()

	method puedeRealizarLaAccion(personaje) = screen.puedeRealizarLaAccionPara(personaje, personaje.direccionDondeMira()) && self.condicion()

	method teEliminaron(personaje) {
	}

}

class EstadoHeroe inherits EstadoPersonaje {

	override method condicion() = true

	override method puedeMoverse() = true

	method reiniciarPara(heroe) {
		heroe.position(new PosicionMutable(x = 19, y = 12))
		heroe.vida(2)
		heroe.score(0)
		heroe.direccionDondeMira(abajo)
	}

}

object heroeDerrotado inherits EstadoHeroe {

	override method condicion() = false

	override method puedeMoverse() = false

	override method teEliminaron(personaje) {
		self.reiniciarPara(personaje)
	}

	override method reiniciarPara(heroe) {
		super(heroe)
		heroe.estado(heroeVivo)
		heroe.nivelDondeSeEncuentra(nivelUno)
	}

}

object heroeGanador inherits EstadoHeroe {

}

object heroeVivo inherits EstadoHeroe {

	override method reiniciarPara(heroe) {
	}

}

class EstadoEnemigo inherits EstadoPersonaje {

	override method condicion() = true

	override method puedeMoverse() = true

}

object enemigoDerrotado inherits EstadoEnemigo {

	override method condicion() = false

	override method puedeMoverse() = false

	override method teEliminaron(enemigo) {
		console.println("SE EJECUTO")
		enemigo.removerEvento()
		mandalorian.sumarScore(enemigo.puntosQueOtorga())
		mandalorian.nivelDondeSeEncuentra().removerEnemigo(enemigo)
		console.println(mandalorian.nivelDondeSeEncuentra().personajes())
	}

}

object enemigoVivo inherits EstadoEnemigo {

}

