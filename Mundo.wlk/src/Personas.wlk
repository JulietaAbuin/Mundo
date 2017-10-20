class Dios {
	var creyentes
	var marias
	
	constructor ( listaCreyentes ) {
		creyentes = listaCreyentes
	}
	
	method pecadores(){ return listaCreyentes }
	method milagro() {
		marias = creyentes.filter( { unHumano => unHumano.sexo() == "mujer" unHumano.estaEnamorado() } )
		marias.forEach( { unHumano => unHumano.tenerUnHijo() } )
	}
}

class Ganesha inherits Dios{
constructor( listaCreyentes ) = super( listaCreyentes ){
	creyentes = listaCreyentes.filter({crey => crey.fe()=="ganesha"})
}

method creyentesDeNacionalidad(nacionalidad){
	return creyentes.count({creyente => creyente.nacionalidad()==nacionalidad})
}

}

class Casstiel inherits Dios {

	constructor( listaCreyentes ) = super( listaCreyentes )
	
	override method milagro() {
		creyentes.forEach( { unHumano => unHumano.satisfecho() unHumano.saciado() } )
	}
	
	override method pecadores() {
		return creyentes.filter( { unHumano => unHumano.edad() < 18 and unHumano.hijos() >= 1 } )
	}
	
	method castigar() {
		var tortura = new Deporte( 900, 100 )
		creyentes.pecadores().forEach( { unPecador => unPecador.entrenar( tortura ) } )
	}
	
	method masJoven() {
		return creyentes.min( { unHumano => unHumano.edad() } )
	}
	
	method masViejo() {
		return creyentes.max( { unHumano => unHumano.edad() } )		
	}
	
	method jugar() {
		self.masJoven().enamorarse( self.masViejo() )
		self.masViejo().enamorarse( self.masJoven() )
	}
}

class Zachariah inherits Dios {
	
	constructor( listaCreyentes ) = super( listaCreyentes ) {
		creyentes = listaCreyentes.filter( { unHumano => unHumano.fe() == "Zachariah" } )
	}
	
	override method pecadores() {
		return listaCreyentes.filter( { unHumano => unHumano.fe() == "Casstiel" } )
	}
	
	method esPadre( unHumano ) {
		return unHumano.hijos().size() >= 1
	}
	
	method pecadoresConHijos() {
		return self.pecadores().filter( { unPecador => unPecador.esPadre() } )
	}
	
	method pecadoresSinHijos() {
		return self.pecadores().filter( { unPecador => ! unPecador.esPadre() } )
	}
	
	method ultimoHijo( unHumano ) {
		return unHumano.hijos().last()
	}
	
    method castigar() {
		self.pecadoresConHijos().forEach( { unPecador => unPecador.matarHijo( self.ultimoHijo( unPecador ) ) } )
		var neneObeso = new Humano( 0, 40, 10, "hombre", 0,"neverland", "Zachariah" )
		self.pecadoresSinHijos().forEach( { unPecador => unPecador.nuevoHijo( neneObeso ) } )
	}
}

class Humano {
	var edad
	var peso
	var altura
	var sexo
	var hijos = []
	var sed =0
	var hambre = 0
	var nacionalidad
	var fe
	var liquidoAcum =0
	var comidaAcum =0
	var cansancio = 0
	var arrugas = 0
	var enamorado = false
	
	constructor( _edad, _altura, _peso, _sexo, _hijos,_nacion,_fe ) {
		edad =_edad
		altura =_altura
		peso =_peso
		sexo = _sexo
		hijos = _hijos
		nacionalidad  = _nacion
		fe=_fe
	}
	method fe(){return fe}
	method nacionalidad(){return nacionalidad}
	method caminar( kilometros ) {
		cansancio += kilometros
		sed += kilometros
		hambre += kilometros / 2	
	}
	
	method correr(distancia){
		cansancio += distancia
		hambre += distancia
		sed += distancia
		if( distancia > 25 )
			arrugas += 1
	}
	
	method tomar( bebida, cantidad ) {
		sed -= bebida.saciedad()
		liquidoAcum += cantidad
		comidaAcum += bebida.calorias()
	}
	
	method comer( unaComida ) {
		hambre -= unaComida.calorias()
		comidaAcum += unaComida.calorias()
	}
	
	method dormir( horas ) {
		cansancio -= horas
	}
	
	method irAlBano() {
		if( comidaAcum == 0 ) { 
			error.throwWithMessage( "No hay comida acumulada" )
			comidaAcum /=2
		}
		liquidoAcum/=2
	}
	
	method entrenar( deporte ) {
		cansancio += deporte.desgaste()
		sed += deporte.liquidoConsumido()
	}
	method enamorarseDe(alguien){
		enamorado = true
	}
	method enamorarse( persona ) {
		cansancio += 50
		persona.enamorarseDe( self )
		enamorado = true
	}
	
	method nuevoHijo(hijo) {
		hijos.add(hijo)
	}
	
	
	method hijos() {
		return hijos.size()
	}
	
	method satisfecho() {
		return hambre == 0
	}
	
	method saciado() {
		return sed == 0
	}
	
	method irAlMedico( medico ) {
		medico.calcularIndice( self )
	}
	
	method cumplirAnios() {
		edad += 1
		arrugas += 1
	}
	
	method sexo() {
		return sexo
	}
	
	method edad() {
		return edad
	}
	
	method estaEnamorado() {
		return enamorado
	}
	
	method estaEnBuenEstado() {
		return 	cansancio < 10 and sed < 15 and hambre < 10
	}
	
	method esBuenPadre() {
		return hijos.all( { unHijo => unHijo.estaEnBuenEstado() } )
	}
	
	method esAbuelo() {
		return hijos.any( { unHijo => unHijo.hijos() >= 1 } )
	}
}

class Mujer inherits Humano {
	var variable = 1
	constructor( _edad, _altura, _peso, _sexo, _hijos,_nacionalidad, _fe ) = super( _edad, _altura, _peso, _sexo, _hijos,_nacionalidad, _fe )
	
	method tenerUnHijo() {
		if ( variable == 1 ){ 
			var hijo = new Humano( 0, 40, 4, "mujer", 0,nacionalidad, fe )
			variable = 0
		} else {
			var hijo = new Humano( 0, 40, 4, "hombre", 0,nacionalidad, fe )
			variable = 1
		}
		self.nuevoHijo( hijo )	
	}

}

class Comida {
	var calorias
	constructor( _calorias ) {
		calorias = _calorias
	}
	
	method calorias() {
		return calorias
	}
}

class Bebida inherits Comida {
	var saciedad
	
	constructor( _calorias, _saciedad) = super( _calorias ) {
		saciedad = _saciedad
	}
	
	method saciedad() {
		return saciedad
	}
}

class Deporte {
	var liq
	var desgaste
	
	constructor( _liq, _desgaste ) {
		liq = _liq
		desgaste= _desgaste
	}
	
	method desgaste() {
		return desgaste
	}
	
	method liquidoConsumido() {
		return liq
	}
}

object medico {
	method calcularIndice( paciente ) {
		return paciente.peso() / ( paciente.altura() )**2
	}
}