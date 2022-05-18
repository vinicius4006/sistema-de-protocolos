import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';
String URLSERVER = 'http://10.1.2.218:3000';

class chamandoApiReq extends ChangeNotifier {
  final ValueNotifier<TextEditingController> veiculoSelecionar =
      ValueNotifier(TextEditingController());
  final List<String> veiculos = [];

  loadPlacas() async {
    final response =
        await Dio().get('$BASEURL/retornarVeiculosNaoProtocolados');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      for (var item in await data) {
        veiculos.add(item['placa'] + ' - ' + item['id']);
      }
      return veiculos;
    } else {
      throw Exception('Falha ao carregar as placas');
    }
  }

  Future<List<dynamic>> retornarSeMotoOuCarro(int id) async {
    if (id != -1) {
      final response = await Dio().get('$BASEURL/retornarVeiculoPorId?id=$id');

      if (response.statusCode == 200) {
        var tipo = response.data['tipo'];

        final responseTipo =
            await Dio().get('$BASEURL/retornarItensVeiculo?tipo=$tipo');

        return responseTipo.data['results'];
      } else {
        throw Exception('Falha ao verificar dados do veículo');
      }
    } else {
      return [];
    }
  }

  Future<List<dynamic>> retornarSeMotoOuCarroPorBooleano(String change) async {
    try {
      final responseTipo =
          await Dio().get('$BASEURL/retornarItensVeiculo?tipo=$change');
      return responseTipo.data['results'];
    } catch (e) {
      debugPrint('Motivo de não retornarSeMotoOuCarroPorBooleano: $e');
      return [];
    }
  }

  Future<List<Protocolo>> retornarProtocolos() async {
    final responseTodosOsProtocolos = await Dio().get('$URLSERVER/protocolos');

    return (responseTodosOsProtocolos.data as List).map((item) {
      return Protocolo.fromJson(item);
    }).toList();
  }

  Future<Protocolo> retornarProtocolosPorId(String id) async {
    final responseProtocoloPorId = await Dio().get('$URLSERVER/protocolos/$id');

    return Protocolo.fromJson(responseProtocoloPorId.data);
  }

  Future<List<dynamic>> retornarItensProtocoloId(String id) async {
    debugPrint('ID: ${id}');
    final responseItensProtocolosPorId =
        await Dio().get('$URLSERVER/itens_protocolos');

    List<dynamic> listaItensProtocolo =
        (responseItensProtocolosPorId.data as List).map((element) {
      return element;
    }).toList();

    List<dynamic> filtroSomenteItensProtocoloPedido = listaItensProtocolo
        .where((element) => element['itensProtocolo'][0]['protocolo'] == id)
        .toList();

    var listaConvertida =
        (filtroSomenteItensProtocoloPedido[0]['itensProtocolo']).map((element) {
      return ItensProtocolo.fromJson(element);
    }).toList();

    listaConvertida.sort(((a, b) => (int.parse(a.itemveiculo.toString()))
        .compareTo(int.parse(b.itemveiculo.toString()))));

    return listaConvertida;
  }
}

final chamandoApiReqState = chamandoApiReq();
