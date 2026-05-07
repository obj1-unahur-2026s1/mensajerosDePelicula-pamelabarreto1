// saber si el paquete puede ser entregado por un mensajero.
//  Un paquete puede entregarse cuando el mensajero puede
//   llegar al destino indicado y además el paquete está pago.

//DESTINOS
object puenteBrooklyn {
  method puedePasar(unMensajero)=
   unMensajero.peso().min(1000) 
  
}
object laMatrix {
  method puedePasar(unMensajero)=
  unMensajero.puedeLlamar()
  
}

//MENSAJEROS
object mensajeros {
  const mensajeros=[roberto,chuck,neo]

method contratarMensajero(unMensajero) =mensajeros.add(unMensajero) 
method despedirMensajero(unMensajero) =mensajeros.remove(unMensajero)
 method laMensajeriaEsGrande() = mensajeros.size()>2
method puedeSerEntregadoPorPrimerMensajero(unPaquete)=
unPaquete.puedeSerEntregadoPor(self.primerMensajero())    

method pesoDelUltimoMensajero() =self.ultimoMensajero().peso() 

method primerMensajero() =mensajeros.first()
method ultimoMensajero()=mensajeros.last() 


}
object paquetes {
  var estaPago=false

  method pagarElPaquete(){estaPago=true}

  method puedeSerEntregadoPor(unMensajero) {self.pagarElPaquete()
  unMensajero.puedePasar(unMensajero)}
}

object roberto {
  var transporte=bici
  var peso=90
method peso() = peso + transporte.peso()
method cambiarTransporte(unTransporte) {
  transporte=unTransporte
}
method cambiarPeso(unPeso) {
  peso=unPeso
}

method puedeLlamar() =false 
method tienePlata() =false 
}
object chuck {
  method peso() =80
  method puedeLlamar() =true

}
object neo {
  var tieneCredito=false
  method peso() =0
  method puedeLlamar()=tieneCredito
  method consumirCredito() {tieneCredito=false}
  method cargarCredito() {tieneCredito=true} 

}
object bici {
  method peso() = 5
}
object camion {
  var acoplado=2
  method peso()= 500 * acoplado
  
  method actualizarAcoplado(unaCantidad) {
    acoplado=unaCantidad
  }
}