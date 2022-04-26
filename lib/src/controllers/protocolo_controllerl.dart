import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/carro.dart';
import 'package:protocolo_app/src/shared/models/moto.dart';
import 'dart:math';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class ProtocoloModelo with ChangeNotifier {
  final List<Protocolo> _listaProtocolo = [];

  Carro _carro = Carro();
  Carro get verificarCarro => _carro;

  Moto _moto = Moto();

  List<Protocolo> get listaProtocolo => _listaProtocolo;

  String get titleMoto => 'Moto';
  String get titleCarro => 'Carro';

  addFormCarro(String motorista, String veiculo, String dataInicio,
      String dataFinal) async {
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

  addFormMoto(
      String motorista, String veiculo, String dataInicio, String dataFinal) {
    final protocolo = Protocolo(
        id: Random().nextInt(100),
        motorista: motorista,
        veiculo: veiculo,
        dataInicio: dataInicio,
        dataFinal: dataFinal,
        moto: _moto);

    _listaProtocolo.add(protocolo);

    _moto = Moto();

    notifyListeners();
  }

  addFormItens(int numCat, List<String> itens, String img, bool change) {
    switch (numCat) {
      case 1:
        {
          if (change) {
            _moto.buzinaStatus = itens;
            // if ((itens.where((element) => element == img)).isEmpty) {
            //   _moto.buzinaStatus?.add('img');
            // }

            debugPrint(img);
          } else {
            _carro.buzinaStatus = itens;
            // if ((itens.where((element) => element == img)).isEmpty) {
            //   _carro.buzinaStatus?.add('img');
            // }
          }
        }
        break;
      case 2:
        {
          _carro.cintoSegurancaStatus = itens;
          // if ((itens.where((element) => element == img)).isEmpty) {
          //     _carro.cintoSegurancaStatus?.add('img');
          //   }
        }
        break;
      case 3:
        {
          _carro.quebraSol = itens;
          // if ((itens.where((element) => element == img)).isEmpty) {
          //     _carro.quebraSol?.add('img');
          //   }
        }
        break;
      case 32:
        {
          _carro.bancosEncostoStatus = itens;
          // if ((itens.where((element) => element == img)).isEmpty) {
          //     _carro.bancosEncostoStatus?.add('img');
          //   }
        }
    }

    notifyListeners();
  }
}
