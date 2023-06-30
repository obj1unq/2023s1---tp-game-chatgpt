import extras.*
import EstadoPersonaje.*
import Personaje.*

class EstadoEnemigo inherits EstadoPersonaje {

	override method teEliminaron(personaje) {
		mandalorian.sumarScore(personaje.puntosQueOtorga())
		mandalorian.nivelDondeSeEncuentra().removerEnemigo(personaje)
		personaje.removerEvento()
	}

}

class EstadoDarthVader inherits EstadoEnemigo {

	override method condicion() = true

	method imagenPara(personaje) = personaje.direccionDondeMira().toString()

	override method puedeMoverse() = true

}

object darthVaderDerrotado inherits EstadoDarthVader {

	override method condicion() = false

	override method puedeMoverse() = false

	override method teEliminaron(personaje) {
		super(personaje)
		gameWin.iniciar()
	}

}

object darthVaderInmune inherits EstadoDarthVader {

	method estadoOpuesto() = darthVaderVivo

	override method imagenPara(personaje) = "inmune-" + personaje.direccionDondeMira().toString()

	method restarVida(vida) = 0

}

object darthVaderVivo inherits EstadoDarthVader {

	method estadoOpuesto() = darthVaderInmune

	method restarVida(vida) = vida

}

class EstadoLordSith inherits EstadoEnemigo {

	override method condicion() = true

	method imagenPara(personaje)

	override method puedeMoverse() = true

}

object lordSithAtacando inherits EstadoLordSith {

	override method imagenPara(personaje) = "rayo"

}

object lordSithDerrotado inherits EstadoLordSith {

	override method condicion() = false

	override method imagenPara(personaje) = ""

	override method puedeMoverse() = false

}

object lordSithVivo inherits EstadoLordSith {

	override method imagenPara(personaje) = personaje.direccionDondeMira().toString()

}

class EstadoTrooper inherits EstadoEnemigo {

}

object trooperDerrotado inherits EstadoTrooper {

	override method condicion() = false

	override method puedeMoverse() = false

}

object trooperVivo inherits EstadoTrooper {

	override method condicion() = true

	override method puedeMoverse() = true

}

