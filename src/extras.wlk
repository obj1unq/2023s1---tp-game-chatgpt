import wollok.game.*
import Background.*
import Nivel.*

object starWarsGame {

	method iniciar() {
		game.title("Star Wars Game")
		game.height(15)
		game.width(22)
		fondoInicio.aparecer()
		keyboard.space().onPressDo({ nivelTres.iniciar()})
		game.start()
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
		game.schedule(4000, { game.stop()})
	}

}

