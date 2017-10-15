class Humano{
	var edad
	var peso
	var altura
	var sed
	var hambre
	var liquidoAcum
	var comidaAcum
	var cansancio
	var hijos=[]
	var arrugas=0
	constructor(_edad,_altura,_peso){
		edad=_edad
		altura=_altura
		peso=_peso
	}
	method caminar(kilometros){
		cansancio +=kilometros
		sed += kilometros
		hambre += kilometros/2
		
	}
	method correr(km){
		cansancio+=km
		hambre += km
		sed+=km
		if(km>25){arrugas+=1}
	}
	method tomar(bebida,ml){
		sed -= bebida.saciedad()
		liquidoAcum += ml
		comidaAcum +=bebida.calorias()
	}
	method comer(_comida){
		hambre -= _comida.calorias()
		comidaAcum += _comida.calorias()
	}
	method dormir(horas){
		cansancio -= horas
	}
	method irAlBano(){
		if(comidaAcum==0){throw new Excepcion("No hay comida acumulada")}
		else{
			comidaAcum /=2
		}
		
		liquidoAcum/=2
	}
	method entrenar(deporte){
		cansancio += deporte.desgaste()
		sed += deporte.liquidoConsumido()
	}
	method enamorarse(alguien){
		cansancio+=50
		alguien.enamorarse(self)
	}
	method tenerUnHijo(hijo,alguien){
		hijos.add(hijo)
		alguien.nuevoHijo(hijo)
		
	}
	method nuevoHijo(hijo){
		hijos.add(hijo)
	}
	method satisfecho(){return hambre == 0}
	method saciado(){return sed==0}
	method plantar(planta){
		
	}
	method irAlMedico(medico){
		medico.calcularIndice(self)
	}
	method cumplirAnios(){
		edad+=1
		arrugas +=1
	}
	method peso()=peso
	method altura()=altura
	
}

class Comida{
	var calorias
	constructor(_calorias){
		calorias=_calorias
	}
	method calorias(){return calorias}
}
class Bebida inherits Comida{
	var saciedad
	constructor(_calorias,_saciedad)=super(_calorias){saciedad=_saciedad}
	method saciedad(){return saciedad}
}
class Deporte{
	var liq
	var desgaste
	constructor(_liq,_desgaste){liq=_liq desgaste=_desgaste}
	method desgaste(){
		return desgaste
	}
	method liquidoConsumido(){
		return liq
	}
}
object medico{
	method calcularIndice(paciente){
		return paciente.peso()/(paciente.altura())**2
	}
}
class Excepcion inherits Exception{
	constructor(mensaje){
			console.println(mensaje)
	}
}