import StarWarsObject.*
import PosicionMutable.*
import wollok.game.*

class Inamovible inherits StarWarsObject {

	override method esColisionable() = false

}

class Caja inherits Inamovible {

	override method image() = "caja.png"

	override method colision(objeto) {
		objeto.colisionasteConCaja(self)
	}

	override method colisionasteConLaser(objeto) {
		objeto.desaparecer()
	}

}

class Bomba inherits StarWarsObject {

	var property estado = colocada
	var property tiempoDeDetonacion = 5

	override method esColisionable() = true

	override method image() = estado.image()

	method text() {
		return tiempoDeDetonacion.toString()
	}

	method danio() = estado.danio()

	method activar() {
		game.onTick(1000, self.nroSerialBomba(), { self.tick()})
	}

	method tick() {
		tiempoDeDetonacion -= 1
		if (tiempoDeDetonacion < 1) {
			estado = detonada
			game.onCollideDo(self, { objeto => objeto.colision(self)})
		}
		if (tiempoDeDetonacion < -1) {
			game.removeTickEvent(self.nroSerialBomba())
			self.desaparecer()
		}
	}

	method textColor() {
		return if (tiempoDeDetonacion >= 4) "#ffffff" else "#FF0000"
	}

	method nroSerialBomba() {
		return self.identity().toString()
	}

	override method colision(objeto) {
		objeto.colionasteConBomba(self)
	}

	override method colisionasteConMandalorian(objeto) {
		objeto.restarVida(self.danio())
	}

}

object colocada {

	method image() = "bomba.png"

	method danio() = 0

	method expandir() {
	}

}

object detonada {

	method image() = "explosion.png"

	method danio() = 2

	method expandir() {
	}

}

const caja1 = new Caja(position = new PosicionMutable(x = 10, y = 5))

const caja2 = new Caja(position = new PosicionMutable(x = 10, y = 9))

const caja3 = new Caja(position = new PosicionMutable(x = 8, y = 7))

const caja4 = new Caja(position = new PosicionMutable(x = 12, y = 7))

const caja5 = new Caja(position = new PosicionMutable(x = 3, y = 11))

const caja6 = new Caja(position = new PosicionMutable(x = 4, y = 9))

const caja7 = new Caja(position = new PosicionMutable(x = 4, y = 10))

const caja8 = new Caja(position = new PosicionMutable(x = 3, y = 10))

const caja9 = new Caja(position = new PosicionMutable(x = 3, y = 4))

const caja10 = new Caja(position = new PosicionMutable(x = 4, y = 4))

const caja11 = new Caja(position = new PosicionMutable(x = 4, y = 5))

const caja12 = new Caja(position = new PosicionMutable(x = 3, y = 3))

const caja13 = new Caja(position = new PosicionMutable(x = 16, y = 5))

const caja14 = new Caja(position = new PosicionMutable(x = 16, y = 4))

const caja15 = new Caja(position = new PosicionMutable(x = 17, y = 4))

const caja16 = new Caja(position = new PosicionMutable(x = 17, y = 3))

const caja17 = new Caja(position = new PosicionMutable(x = 16, y = 9))

const caja18 = new Caja(position = new PosicionMutable(x = 16, y = 10))

const caja19 = new Caja(position = new PosicionMutable(x = 17, y = 10))

const caja20 = new Caja(position = new PosicionMutable(x = 17, y = 11))

const caja21 = new Caja(position = new PosicionMutable(x = 9, y = 11))

const caja22 = new Caja(position = new PosicionMutable(x = 10, y = 11))

const caja23 = new Caja(position = new PosicionMutable(x = 11, y = 11))

const caja24 = new Caja(position = new PosicionMutable(x = 10, y = 3))

const caja25 = new Caja(position = new PosicionMutable(x = 9, y = 3))

const caja26 = new Caja(position = new PosicionMutable(x = 11, y = 3))

const caja27 = new Caja(position = new PosicionMutable(x = 6, y = 6))

const caja28 = new Caja(position = new PosicionMutable(x = 6, y = 8))

const caja29 = new Caja(position = new PosicionMutable(x = 7, y = 10))

const caja30 = new Caja(position = new PosicionMutable(x = 7, y = 4))

const caja31 = new Caja(position = new PosicionMutable(x = 13, y = 4))

const caja32 = new Caja(position = new PosicionMutable(x = 13, y = 10))

const caja33 = new Caja(position = new PosicionMutable(x = 14, y = 6))

const caja34 = new Caja(position = new PosicionMutable(x = 14, y = 8))

