import Direccion.*
import Nivel.nivelUno
import Personaje.*
import PosicionMutable.*

class EstadoPersonaje {

	method condicion()

	method puedeMoverse()

	method puedeRealizarLaAccion(personaje) = personaje.puedeMoverse(personaje, personaje.direccionDondeMira()) && self.condicion()

}

class EstadoVivo inherits EstadoPersonaje {

	override method condicion() = true

	override method puedeMoverse() = true

}

object mandalorianVivo inherits EstadoVivo {

}

object trooperVivo inherits EstadoVivo {

}

object lordSithVivo inherits EstadoVivo {

	method imagenPara(personaje) = personaje.direccionDondeMira().toString()

}

object darthVaderVivo inherits EstadoVivo {

	method imagenPara(personaje) = personaje.direccionDondeMira().toString()

	method restarVida(vida) {
		return vida
	}

}

class EstadoDerrotado inherits EstadoPersonaje {

	override method condicion() = false

	override method puedeMoverse() = false

	method teEliminaron(personaje) {
		personaje.removerEvento()
		mandalorian.sumarScore(personaje.puntosQueOtorga())
		mandalorian.nivelDondeSeEncuentra().removerEnemigo(personaje)
	}

}

object mandalorianDerrotado inherits EstadoDerrotado {

	override method teEliminaron(personaje) {
		self.reiniciar()
	}

	method reiniciar() {
		mandalorian.position(new PosicionMutable(x = 19, y = 12))
		mandalorian.vida(2)
		mandalorian.score(0)
		mandalorian.direccionDondeMira(abajo)
		mandalorian.estado(mandalorianVivo)
		mandalorian.nivelDondeSeEncuentra(nivelUno)
	}

}

object trooperDerrotado inherits EstadoDerrotado {

}

object lordSithDerrotado inherits EstadoDerrotado {

}

object darthVaderDerrotado inherits EstadoDerrotado {

	// elimina a vader 
	override method teEliminaron(personaje) {
		mandalorian.sumarScore(personaje.puntosQueOtorga())
		mandalorian.nivelDondeSeEncuentra().removerEnemigo(personaje)
		personaje.removerEvento()
	}

	method imagenPara(personaje) = personaje.direccionDondeMira().toString()

}

object mandalorianGanador inherits EstadoPersonaje {

	override method condicion() = true

	override method puedeMoverse() = true

	method reiniciar() {
		mandalorian.position(new PosicionMutable(x = 19, y = 12))
		mandalorian.vida(2)
		mandalorian.score(0)
		mandalorian.direccionDondeMira(abajo)
	}

}

object lordSithAtacando inherits EstadoPersonaje {

	override method condicion() = true

	method imagenPara(personaje) = "rayo"

	override method puedeMoverse() = true

}

object darthVaderInmune inherits EstadoPersonaje {

	override method condicion() = true

	method imagenPara(personaje) = "inmune-" + personaje.direccionDondeMira().toString()

	override method puedeMoverse() = true

	method restarVida(vida) {
		return 0
	}

}

