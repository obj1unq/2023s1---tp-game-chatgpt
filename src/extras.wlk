import wollok.game.*
import Background.*
import Nivel.*

object starWarsGame {

	method iniciar() {
		self.reproducirMusica()
		game.title("Star Wars Game")
		game.height(15)
		game.width(22)
		fondoInicio.aparecer()
		keyboard.space().onPressDo({ nivelUno.iniciar()})
		game.start()
	}

	method reproducirMusica() {
		game.schedule(1000, { => sonidoInicio.play()})
	}

	method detenerMusica() {
		sonidoInicio.stop()
	}

}

object gameOver {

	method reiniciarJuego() {
		game.clear()
		fondoGameOver.aparecer()
		keyboard.r().onPressDo({ nivelUno.iniciar()})
	}

}

object gameWin {

	method iniciar() {
		game.clear()
		fondoGameWin.aparecer()
		game.schedule(10000, { game.stop()})
	}

}

const sonidoInicio = game.sound("musica-inicio.mp3")

const sonidoNivelUno = game.sound("musica-nivelUno.mp3")

const sonidoNivelDos = game.sound("musica-nivelDos.mp3")

const sonidoNivelTres = game.sound("musica-nivelTres.mp3")

