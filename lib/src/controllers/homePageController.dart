import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class _HomePage extends ChangeNotifier {
  final ValueNotifier<List<Protocolo>> listProtocolo = ValueNotifier([]);
  final ValueNotifier<List<String>> listaPlacaVeiculo = ValueNotifier([]);
  final controllerFiltro = TextEditingController();

  int x = 0;
  bool maisDados = true;
  final ValueNotifier<bool> refresh = ValueNotifier(false);

  Future loadData() async {
    const limit = 10;

    final List<Protocolo> response =
        await chamandoApiReqState.retornarProtocolos(true, limit, x);

    listProtocolo.value.addAll(response);

    x = x + 10;
    if (response.length < limit) {
      maisDados = false;
    }
    listProtocolo.notifyListeners();
    listaPlacaVeiculo.notifyListeners();

    //homePageState.protocoloFilter('', response);
  }

  protocoloFilter(String keyword) async {
    listProtocolo.value.clear();
    if (keyword.isEmpty) {
      x = 0;
      maisDados = true;
      loadData();
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
    debugPrint('${placa}');
    return placa;
  }
}

final homePageState = _HomePage();
