import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class _HomePage extends ChangeNotifier {
  final ValueNotifier<List<Protocolo>> protocoloFiltro = ValueNotifier([]);

  protocoloFilter(String keyword, List<Protocolo> listaProtocolo) {
    if (keyword.isEmpty) {
      protocoloFiltro.value = listaProtocolo.toList();
    } else {
      protocoloFiltro.value = listaProtocolo
          .toList()
          .where((protocolo) => (protocolo.id.toString() +
                  ' - ' +
                  DateFormat('dd/MM/yyyy - kk:mm')
                      .format(DateTime.parse(protocolo.inicio.toString()))
                      .toString() +
                  ' - ' +
                  homePageState.placaPorVeiculo(protocolo.veiculo.toString()))
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }
  }

  String placaPorVeiculo(String numVeiculo) {
    String placa = '';
    chamandoApiReqState.listaPlacas.value.forEach((element) {
      if (element.veiculoId == numVeiculo) {
        placa = element.placa.toString();
      }
    });
    return placa;
  }
}

final homePageState = _HomePage();
