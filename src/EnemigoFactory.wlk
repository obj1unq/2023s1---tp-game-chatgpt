import wollok.game.*
import Direccion.*
import Personaje.*
import Posicion.*

class EnemigoFactory {

	const property personajes = []

	method generar() {
		if (personajes.size() < 6) {
			const nuevoEnemigo = self.nuevoEnemigo()
			personajes.add(nuevoEnemigo)
			nuevoEnemigo.aparecer()
		} else {
		}
	}

	method nuevoEnemigo()

	method eliminar(personaje) {
		personajes.remove(personaje)
	}

}

object trooperFactory inherits EnemigoFactory {

	override method nuevoEnemigo() {
		return new Tropper(position = new Posicion(x = 2.randomUpTo(21), y = 2.randomUpTo(13)), alcanceDisparo = 3, direccionDondeMira = abajo, rango = [ cadete, cadete, cadete, sargento, sargento, general ].anyOne())
	}

}

