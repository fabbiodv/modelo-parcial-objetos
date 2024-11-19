class Poblador {
	var property energia
	var property vitalidad
	var property fuerza
	var property fechaNacimiento
	var property actividadPrincipal
	const property actividadesProgramadas = []
	
	method realizarActividadDiaria() {
		actividadPrincipal.realizar(self)
	}
	
	method modificarEnergia(cantidad) {
		energia += cantidad
	}
	
	method cantidadProductosDiarios() = actividadPrincipal.cantidadProductos()
	
	method edad() = new Date().year() - fechaNacimiento.year()
	
	method calidadDeVida()
	
	method realizarActividadesProgramadas() {
		actividadesProgramadas.forEach(
			{ actividad =>
				if (energia <= 0) {
					throw new Exception(
						message = "No hay suficiente energía para continuar con las actividades"
					)
				}
				return actividad.realizar(self)
			}
		)
	}
}

class PobladorAutoctono inherits Poblador {
	override method calidadDeVida() = self.edad() * 0.6
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


class Producto {
	const property cantidadGramos
	const property esOrganico
	
	method energiaQueOtorga(cantidadPlaguicidas) {
		if (esOrganico) {	
			return cantidadGramos 
		} else {
			return cantidadGramos - (cantidadPlaguicidas * 0.9)
		}
	}
}

class ActividadPrincipal {
	const property productos = []
	
	method realizar(poblador)
	method cantidadProductos() = productos.size()
}

class Agricultor inherits ActividadPrincipal {
	var property cantidadPlaguicidas
	
	override method realizar(poblador) {
		const energiaGenerada = productos.sum(
			{ producto => producto.energiaQueOtorga(cantidadPlaguicidas) }
		)
		poblador.modificarEnergia(energiaGenerada)
	}
	
}

object apicultor inherits ActividadPrincipal {
	override method realizar(poblador) {
		const energiaGenerada = productos.sum(
			{ producto => producto.energiaQueOtorga() }
		)
		poblador.modificarEnergia(energiaGenerada)
	}
}

object pesquero inherits ActividadPrincipal {
	override method realizar(poblador) {
		const energiaGenerada = productos.sum(
			{ producto => producto.energiaQueOtorga() }
		)
		poblador.modificarEnergia(energiaGenerada)
	}
}

class ActividadProgramada {
	method realizar(poblador)
}

class Correr inherits ActividadProgramada {
	const metros
	
	override method realizar(poblador) {
		poblador.modificarEnergia((-metros) / 2)
		poblador.fuerza(poblador.fuerza() + (metros * 0.2))
	}
}

class Ciclismo inherits ActividadProgramada {
	const velocidad
	
	override method realizar(poblador) {
		poblador.modificarEnergia((-velocidad) / 2)
		poblador.vitalidad(poblador.vitalidad() + (velocidad / 3))
	}
}

class SaltarSoga inherits ActividadProgramada {
	const cantidadSaltos
	
	override method realizar(poblador) {
		poblador.modificarEnergia(-cantidadSaltos)
		poblador.vitalidad(poblador.vitalidad() + (cantidadSaltos / 2))
	}
}

class ConsumirRacion inherits ActividadProgramada {
	const cantidadProductos
	
	override method realizar(poblador) {
		poblador.modificarEnergia(cantidadProductos)
	}
}
