import wollok.game.*

class PosicionMutable {

	var property x = 0
	var property y = 0

	method right(n) = new PosicionMutable(x = x + n, y = y)

	method left(n) = new PosicionMutable(x = x - n, y = y)

	method up(n) = new PosicionMutable(x = x, y = y + n)

	method down(n) = new PosicionMutable(x = x, y = y - n)

	method right() {
		x += 1
	}

	method left() {
		x -= 1
	}

	method down() {
		y -= 1
	}

	method up() {
		y += 1
	}

	method drawElement(element) {
		game.addVisualIn(element, self)
	}

	method drawCharacter(element) {
		game.addVisualCharacterIn(element, self)
	}

	method say(element, message) {
		game.say(element, message)
	}

	method allElements() = game.getObjectsIn(self)

	method clone() = new Position(x = x, y = y)

	method distance(position) {
		self.checkNotNull(position, "distance")
		const deltaX = x - position.x()
		const deltaY = y - position.y()
		return (deltaX.square() + deltaY.square()).squareRoot()
	}

	method clear() {
		self.allElements().forEach{ it => game.removeVisual(it)}
	}

	override method ==(other) = x == other.x() && y == other.y()

	override method toString() = x.toString() + "@" + y.toString()

}

