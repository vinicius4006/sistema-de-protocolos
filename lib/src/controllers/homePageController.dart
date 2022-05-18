import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  Future<List<Protocolo>> retornarProtocolos() async {
    await Future.delayed(Duration(seconds: 2));
    final responseTodosOsProtocolos = await Dio().get('$URLSERVER/protocolos');
    return (responseTodosOsProtocolos.data as List)
        .map((item) {
          return Protocolo.fromJson(item);
        })
        .toList()
        .reversed
        .toList();
  }
}

final homePageState = _HomePage();
