class Posicion {

	var property x = 0
	var property y = 0

	method right(n) = new Posicion(x = x + n, y = y)

	/**
	 * Returns a new Position n steps left from this one.
	 */
	method left(n) = new Posicion(x = x - n, y = y)

	/**
	 * Returns a new Position n steps up from this one.
	 */
	method up(n) = new Posicion(x = x, y = y + n)

	/**
	 * Returns a new Position, n steps down from this one.
	 */
	method down(n) = new Posicion(x = x, y = y - n)

}

