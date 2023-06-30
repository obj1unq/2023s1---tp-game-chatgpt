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

	method estadoOpuesto() = darthVaderInmune

	method imagenPara(personaje) = personaje.direccionDondeMira().toString()

	method restarVida(vida) = vida

	method accion() {
	}

}

class EstadoDerrotado inherits EstadoPersonaje {

	override method condicion() = false

	override method puedeMoverse() = false

	method teEliminaron(personaje) {
		mandalorian.sumarScore(personaje.puntosQueOtorga())
		mandalorian.nivelDondeSeEncuentra().removerEnemigo(personaje)
		personaje.removerEvento()
	}

}

object mandalorianDerrotado inherits EstadoDerrotado {

	override method teEliminaron(personaje) {
		gameOver.reiniciarJuego()
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

	method imagenPara(personaje) = personaje.direccionDondeMira().toString()

	override method teEliminaron(personaje) {
		super(personaje)
		gameWin.iniciar()
	}

	method accion() {
	}

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

	method estadoOpuesto() = darthVaderVivo

	method imagenPara(personaje) = "inmune-" + personaje.direccionDondeMira().toString()

	override method puedeMoverse() = true

	method restarVida(vida) = 0

	method accion() {
	}

}

