// saber si el paquete puede ser entregado por un mensajero.
//  Un paquete puede entregarse cuando el mensajero puede
//   llegar al destino indicado y además el paquete está pago.

//DESTINOS
object puenteBrooklyn {
  method puedePasar(unMensajero)=
   unMensajero.peso()<= 1000
  
}
object laMatrix {
  method puedePasar(unMensajero)=
  unMensajero.puedeLlamar()
  
}

//MENSAJEROS
object empresa {
  const mensajeros=[roberto,chuck,neo]
     const enviados = []
   const pendientes = []

method contratarMensajero(unMensajero) =mensajeros.add(unMensajero) 
method despedirMensajero(unMensajero) =mensajeros.remove(unMensajero)
method despedirAtodosMensajeros() = mensajeros.clear()
 method laMensajeriaEsGrande() = mensajeros.size()>2
method puedeSerEntregadoPorPrimerMensajero(unPaquete)=
unPaquete.puedeSerEntregadoPor(self.primerMensajero())    

method pesoDelUltimoMensajero() =self.ultimoMensajero().peso() 

method primerMensajero() =mensajeros.first()
method ultimoMensajero()=mensajeros.last() 

method puedeEntregar(unPaquete)= mensajeros.any({m=>unPaquete.puedeSerEntregadoPor(m)})
method todosLosMensajerosQuePueden(unPaquete) = mensajeros.filter({m=>unPaquete.puedeSerEntregadoPor(m)})
method mensajeriaTieneSobrePeso() = self.pesoTotal() / self.cantidadMensajeros() > 500
method pesoTotal() = mensajeros.sum({m=>m.peso()}) 
method cantidadMensajeros()=mensajeros.size()


  method enviar(unPaquete) {
     if(self.puedeEntregar(unPaquete))
        enviados.add(unPaquete)
     else
        pendientes.add(unPaquete)
  }
  method facturacion() = enviados.sum{p=>p.precio()}

  method enviarTodos(paquetesAEnviar){
    paquetesAEnviar.forEach{p=>self.enviar(p)}
  }
  method reenviarPendienteCaro() {
    const caro = self.pendienteCaro()
    pendientes.remove(caro)
    self.enviar(caro)
  }
  method pendienteCaro() = pendientes.max{p=>p.precio()}

}
object paquete {
  var estaPago=true
  var destino=puenteBrooklyn

  method estaPago()=estaPago
  method puedeSerEntregadoPor(unMensajero) = self.estaPago() and 
  destino.puedePasar(unMensajero)

  method cambiarDestino(unDestino) {
    destino=unDestino}
method precio() = 50
  
}
object paquetito {
  method estaPago()=true
  method puedeSerEntregadoPor(unMensajero) =true
method precio() = 0
  
}
object paquetonViajero {
  const destinos=[puenteBrooklyn,laMatrix]
 var pagado = 0
 method puedeSerEntregadoPor(alguien) = self.estaPago() and self.pasaPorTodos(alguien)

 method pasaPorTodos(mensajero) = destinos.all({d=> d.puedePasar(mensajero)})
 method estaPago() = pagado >= self.precio()

 method precio() = destinos.size() * 100
 method pagar(importe) {
  pagado = pagado + importe
 }

}

object roberto {
  var transporte=bici
  var peso=90
method peso() = peso + transporte.peso()
method viajaEn(unTransporte) {
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
  
  method agregarAcoplado() {
    acoplado=acoplado+1
  }
}