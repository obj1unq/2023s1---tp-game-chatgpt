import wollok.game.*
import StarWarsObject.*
import Visor.*

class Caja inherits StarWarsObject {

	override method image() = "caja.png"

	override method esColisionable() = false

	override method colision(objeto) {
	}

	method interactuarCon(objeto) {
	}

	override method aparecer() {
		super()
		game.onCollideDo(self, { objeto => console.println("CAJA:" + objeto)})
		game.onCollideDo(self, { objeto => objeto.colision(self)})
	}

	method impactarConLaserAzul(laser) {
	}

	method impactarConLaserRojo(laser) {
	}

}

class Bomba inherits StarWarsObject {

	var property estado = colocada
	var property tiempoDeDetonacion = 5

	override method image() = estado.image()

	override method colision(personaje) {
	}

	override method aparecer() {
		game.addVisual(self)
		self.activar()
	}

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
			game.removeTickEvent(self.nroSerialBomba())
		}
		if (tiempoDeDetonacion < -3) {
			game.removeVisual(self)
		}
	}

	method textColor() {
		return if (tiempoDeDetonacion >= 4) "#ffffff" else "#FF0000"
	}

	// method colision
	method impactarConLaserAzul(laser) {
	}

	method impactarConLaserRojo(laser) {
	}

	method nroSerialBomba() {
		return self.identity().toString()
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

