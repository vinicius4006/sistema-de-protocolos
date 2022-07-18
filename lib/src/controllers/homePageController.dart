import 'package:flutter/cupertino.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class _HomePage extends ChangeNotifier {
  final ValueNotifier<List<Protocolo>> listProtocolo = ValueNotifier([]);
  final ValueNotifier<List<String>> listaPlacaVeiculo = ValueNotifier([]);

  int x = 0;
  bool maisDados = true;
  int intScroll = 2;
  String keywordGlobal = '';
  bool boolVerGlobal = true;

  final ValueNotifier<bool> refresh = ValueNotifier(false);

  Future loadData(int scrollInt) async {
    if (maisDados && intScroll != scrollInt) {
      intScroll = scrollInt;
      // para que o loadData nao carregue no mesmo scroll
      const limit = 10;
      late List<Protocolo> response;
      keywordGlobal != ''
          ? response = await chamandoApiReqState.retornarProtocolos(
              true, limit, x + 10, keywordGlobal, boolVerGlobal)
          : response =
              await chamandoApiReqState.retornarProtocolos(true, limit, x);

      listProtocolo.value.addAll(response);

      x = x + 10;

      if (response.length < limit) {
        maisDados = false;
      }
      listProtocolo.notifyListeners();
    }
  }

  protocoloFilter(String keyword) async {
    keywordGlobal = keyword;
    listProtocolo.value.clear();
    listaPlacaVeiculo.value.clear();
    chamandoApiReqState.listaPlacas.clear();
    intScroll = 2;
    if (keyword.isEmpty) {
      x = 0;
      maisDados = true;
      loadData(100);
      refresh.value = false;
    } else {
      maisDados = true;
      final bool boolVer = verificarSeIdOuPlaca(keyword);
      boolVerGlobal = boolVer;
      //bool true -> id// bool false -> placa
      final List<Protocolo> response = await chamandoApiReqState
          .retornarProtocolos(true, 10, 0, keyword, boolVer);

      listProtocolo.value = response;

      await Future.delayed(Duration(seconds: 1));
    }
    refresh.value = false;
  }

  String placaPorVeiculo(String numVeiculo) {
    String placa = chamandoApiReqState.listaPlacas
        .where((element) => element.veiculoId == numVeiculo)
        .first
        .placa
        .toString();

    return placa;
  }

//Por que eu não criei um modelo que pegaria também a placa?
//O modelo já está pronto para criar o protocolo e mandar para o banco, então crio outro ramo para pegar a placa.
  bool verificarSeIdOuPlaca(String keyword) {
    List<bool> found = [];
    for (var i = 0; i < keyword.length; i++) {
      bool tem = keyword[i].contains(RegExp(r'[0-9]'));
      found.add(tem);
    }
    return found.every((element) => element == true);
  }
}

final homePageState = _HomePage();
