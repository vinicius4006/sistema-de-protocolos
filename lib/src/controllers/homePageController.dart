import 'package:flutter/cupertino.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class _HomePage extends ChangeNotifier {
  final ValueNotifier<List<Protocolo>> listProtocolo = ValueNotifier([]);
  final ValueNotifier<List<String>> listaPlacaVeiculo = ValueNotifier([]);

  int x = 0;
  bool maisDados = true;
  int intScroll = 2;
  late List<Protocolo> protocolosSeparados;

  final ValueNotifier<bool> refresh = ValueNotifier(false);

  Future loadData(int scrollInt) async {
    if (maisDados && intScroll != scrollInt) {
      intScroll = scrollInt;
      // para que o loadData nao carregue no mesmo scroll
      const limit = 10;

      final List<Protocolo> response =
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
      maisDados = false;
      final bool boolVer = verificarSeIdOuPlaca(keyword);

      final List<Protocolo> response =
          await chamandoApiReqState.retornarProtocolos(true, 1000, 0);
      if (boolVer) {
        protocolosSeparados = listProtocolo.value = response
            .where((protocolo) =>
                (protocolo.id.toString()).toLowerCase().contains(keyword))
            .toList();
      } else {
        final List<Protocolo> protocoloPorPlaca = await chamandoApiReqState
            .getPlacasProtocoladas(keyword.toUpperCase());

        listProtocolo.value = protocoloPorPlaca;
      }

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
