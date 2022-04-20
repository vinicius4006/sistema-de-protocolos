import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/carro.dart';
import 'dart:math';

import 'package:protocolo_app/src/shared/models/protocolo.dart';

class ProtocoloModelo with ChangeNotifier {
  final List<Protocolo> _listaProtocolo = [];

  Carro _carro = Carro();

  List<Protocolo> get listaProtocolo => _listaProtocolo;




  addForm(
      String motorista, String veiculo, String dataInicio, String dataFinal) {
    final protocolo = Protocolo(
        id: Random().nextInt(100),
        motorista: motorista,
        veiculo: veiculo,
        dataInicio: dataInicio,
        dataFinal: dataFinal,
        carro: _carro);

    _listaProtocolo.add(protocolo);

    _carro = Carro();

    notifyListeners();
  }

  addFormItens(int numCat, List<String> itens, String img) {
    switch (numCat) {
      case 0:
        {
          _carro.buzinaStatus = itens;
          _carro.buzinaStatus?.add(img);
        }
        break;
      case 1:
        {
          _carro.cintoSegurancaStatus = itens;
        }
        break;
      case 2:
        {
          _carro.quebraSol = itens;
        }
        break;
    }

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
