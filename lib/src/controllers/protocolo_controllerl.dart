import 'package:flutter/material.dart';
import 'dart:math';

import 'package:protocolo_app/src/shared/models/protocolo.dart';

class ProtocoloModelo with ChangeNotifier {
 

  final List<Protocolo> _listaProtocolo = [];



  List<Protocolo> get listaProtocolo => _listaProtocolo;

  addForm(
      String motorista, String veiculo, String dataInicio, String dataFinal) {
    final protocolo = Protocolo(
        id: Random().nextInt(100),
        motorista: motorista,
        veiculo: veiculo,
        dataInicio: dataInicio,
        dataFinal: dataFinal);

    _listaProtocolo.add(protocolo);

    notifyListeners();
  }

  addFormItens(String title, List<String> itens, String path) {
    
    notifyListeners();
  }

//  addProtocolo(Map<String,dynamic> protocolo){
//    print(protocolo);
//    _listaProtocolo.add(protocolo);
//  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};

  //   data['Motorista'] = motorista;
  //   data['Veículo'] = veiculo;
  //   data['Carro'] = formCarro;
  //   data['Moto'] = formMoto;
  //   data['DataInicio'] = dataInicio;
  //   data['DataFinal'] = dataFinal;

  //   return data;
  // }
}
