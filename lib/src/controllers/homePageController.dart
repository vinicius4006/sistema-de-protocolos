import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class _HomePage extends ChangeNotifier {
  final ValueNotifier<List<Protocolo>> listProtocolo = ValueNotifier([]);
  final ValueNotifier<List<String>> listaPlacaVeiculo = ValueNotifier([]);

  int x = 0;
  bool maisDados = true;
  int intScroll = 2;
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

    //homePageState.protocoloFilter('', response);
  }

  protocoloFilter(String keyword) async {
    listProtocolo.value.clear();
    listaPlacaVeiculo.value.clear();
    intScroll = 2;
    if (keyword.isEmpty) {
      x = 0;
      maisDados = true;
      loadData(100);
      refresh.value = false;
    } else {
      maisDados = false;
      final List<Protocolo> response =
          await chamandoApiReqState.retornarProtocolos(true, 1000, 0);

      listProtocolo.value = response
          .where((protocolo) => (protocolo.id.toString() +
                  ' - ' +
                  DateFormat('dd/MM/yyyy - kk:mm').format(protocolo.inicio!) +
                  ' - ' +
                  placaPorVeiculo(protocolo.veiculo.toString()))
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
      await Future.delayed(Duration(seconds: 1));
    }
    refresh.value = false;
  }

  String placaPorVeiculo(String numVeiculo) {
    String placa = '';
    chamandoApiReqState.listaPlacas.forEach((element) {
      if (element.veiculoId == numVeiculo) {
        placa = element.placa.toString();
        if (!listaPlacaVeiculo.value.contains(placa)) {
          listaPlacaVeiculo.value.add(placa);
        }
      }
    });

    return placa;
  }
}

final homePageState = _HomePage();
