import 'package:flutter/cupertino.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class _HomePage extends ChangeNotifier{
    final ValueNotifier<List<Protocolo>> protocoloFiltro = ValueNotifier([]);
  
protocoloFilter(String keyword, List<Protocolo> listaProtocolo
      ) {
   
    if (keyword.isEmpty) {
      protocoloFiltro.value = listaProtocolo.toList();
    } else {
      protocoloFiltro.value = listaProtocolo
          .toList()
          .where((protocolo) => (protocolo.id.toString() +
                  ' - ' +
                  protocolo.inicio.toString() +
                  ' - ' +
                  protocolo.fim.toString() +
                  ' - ' +
                  protocolo.placa.toString())
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

  }



 
} 
final homePageState = _HomePage();