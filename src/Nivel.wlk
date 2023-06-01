import wollok.game.*
import Direccion.*
import Personaje.*
import Obstaculo.*

object starsWarsGame {

	method iniciar() {
		nivelUno.iniciar()
	}

}

class Nivel {

	const property personaje
	const property enemigos = []

	method agregarEnemigos()

	method agregarControles() {
		keyboard.up().onPressDo({ personaje.mover(arriba)})
		keyboard.down().onPressDo({ personaje.mover(abajo)})
		keyboard.left().onPressDo({ personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.z().onPressDo({ personaje.accion()})
	}

	method agregarVisualesPersonajes()

	method agregarVisualesEscenario()

	method iniciar()

}

object nivelUno inherits Nivel(personaje = mandalorian) {

	override method iniciar() {
		// background.fondo("nivel1")
		// game.addVisual(background)
		game.boardGround("background-nivel1.png")
		self.agregarVisualesEscenario()
		self.agregarVisualesPersonajes()
		self.agregarControles()
		self.agregarEnemigos()
		game.start()
	}

	override method agregarVisualesPersonajes() {
		tropperCadete.aparecer()
		tropperSargento.aparecer()
		mandalorian.aparecer()
	}

	override method agregarVisualesEscenario() {
		game.addVisual(new Obstaculo(position = game.at(1, 2)))		//esquina inferior izquierda (1, 2)
		game.addVisual(new Obstaculo(position = game.at(16, 2)))		//esquina superior izquierda (16, 2)
		game.addVisual(new Obstaculo(position = game.at(16, 15)))	//esquina superior derecha (16, 15)
		game.addVisual(new Obstaculo(position = game.at(1, 15)))	//esquina inferior derecha (1, 15)
	}

	override method agregarEnemigos() {
		const tropperFactory = new TrooperFactory()
		
		game.onTick(3000, "lala", {tropperFactory.nuevoEnemigo().aparecer()})
		tropperCadete.disparoSecuencial()
		tropperSargento.disparoSecuencial()
	}

}

class EnemigoFactory {
	
	const property coordenadas = [self.coordenadaXFija(2), 
								  self.coordenadaXFija(14), 
								  self.coordenadaYFija(6), 
								  self.coordenadaYFija(15)]

	method numeroAleatorioEntre(n,m){
		return [n..m].anyOne()
	}
	
	method coordenadaXFija(x){
		return [x, self.numeroAleatorioEntre(2,15)]
	}
	
	method coordenadaYFija(y){
		return [self.numeroAleatorioEntre(2,14), y] 
	}
	
	method generar(){
		game.onTick(3000, "Generar Enemigos", {self.nuevoEnemigo().aparecer()})
	}
	
	method nuevoEnemigo()
	
}

class TrooperFactory inherits EnemigoFactory{
	
	var property coordenada =  coordenadas.anyOne()	//coordenadas.anyOne()
	
	override method nuevoEnemigo(){
		
		
		return new Tropper(position = game.at(coordenada.first(), coordenada.head()),	//coordenada.first(), coordenada.head() 	
						   alcanceDisparo = 3, 
						   direccionMovimiento = abajo,
						   rango = "cadete")
	}
	
	method agregarCordenadasACoordenada(listaDeCoordenadas){
		coordenada.add(listaDeCoordenadas)
	}
}

object background {

	var property position = game.at(2, 2)
	var property fondo = null

	method image() {
		return "background-" + fondo + ".png"
	}

}

object gameOver {

	method fondo() {
		background.fondo("yodaGameOver")
		background.position(game.at(0, 0))
		game.addVisual(background)
	}

}

const mandalorian = new Heroe(position = game.at(8, 7), alcanceDisparo = 5, direccionMovimiento = abajo)

const tropperCadete = new Tropper(position = game.at(2, 5), alcanceDisparo = 5, direccionMovimiento = abajo, rango = "cadete")

const tropperSargento = new Tropper(position = game.at(1, 4), alcanceDisparo = 5, direccionMovimiento = abajo, rango = "sargento")

