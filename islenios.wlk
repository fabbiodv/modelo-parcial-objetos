class Poblador {
	var property energia
	var property vitalidad
	var property fuerza
	var property fechaNacimiento
	var property actividadPrincipal
	
	method realizarActividadDiaria() {
		actividadPrincipal.realizar(self)
	}
	
	method modificarEnergia(cantidad) {
		energia += cantidad
	}
	
	method cantidadProductosDiarios() {
		return actividadPrincipal.cantidadProductos()
	}
	
	method edad() {
		return new Date().year() - fechaNacimiento.year()
	}
	
	method calidadDeVida()
}

class PobladorAutoctono inherits Poblador {
	override method calidadDeVida() {
		return self.edad() * 0.6
	}
}

class PobladorExtranjero inherits Poblador {
	var property aniosEnIsla
	
	override method calidadDeVida() {
		const calidadAutoctono = new PobladorAutoctono(
			energia = energia,
			vitalidad = vitalidad,
			fuerza = fuerza,
			fechaNacimiento = fechaNacimiento,
			actividadPrincipal = actividadPrincipal
		).calidadDeVida()
		
		return (calidadAutoctono / 4) + (aniosEnIsla / 2)
	}
}

class ActividadPrincipal {
	const property productos = []
	
	method realizar(poblador)
	method esOrganico()
	method cantidadProductos() = productos.size()
}

class Agricultor inherits ActividadPrincipal {
	var property usaPlaguicidas
	var property cantidadPlaguicidas
	
	override method realizar(poblador) {
		const energiaGenerada = productos.sum({ producto => 
			if (self.esOrganico()) 
				producto 
			else 
				producto - (cantidadPlaguicidas * 0.9)
		})
		poblador.modificarEnergia(energiaGenerada)
	}
	
	override method esOrganico() = !usaPlaguicidas
}

class Apicultor inherits ActividadPrincipal {
	
	override method realizar(poblador) {
		const energiaGenerada = productos.sum({ producto => 
			if (self.esOrganico()) 
				producto 
			else 
				producto - (producto * 0.9)
		})
		poblador.modificarEnergia(energiaGenerada)
	}
	
	override method esOrganico() = true
}

class Pesquero inherits ActividadPrincipal {
	override method realizar(poblador) {
		const energiaGenerada = productos.sum({ producto => producto })
		poblador.modificarEnergia(energiaGenerada)
	}
	
	override method esOrganico() = true
}
