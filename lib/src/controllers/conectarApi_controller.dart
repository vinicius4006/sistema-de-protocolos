import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/pessoa_motorista.dart';
import 'package:protocolo_app/src/shared/models/placas.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

String URL = 'http://10.1.2.218/api/view/ProtocoloFrota/';

//MOCK
String URLSERVER = 'http://10.1.2.218:3000';

class _chamandoApiReq extends ChangeNotifier {
  final ValueNotifier<TextEditingController> veiculoSelecionar =
      ValueNotifier(TextEditingController());
  final List<String> veiculos = [];
  final ValueNotifier<List<Placas>> listaPlacas =
      ValueNotifier([]); //precisa ser notificado?
  final ValueNotifier<bool> statusAnterior = ValueNotifier(false);
  List<ItensVeiculos> listaItensVeiculo = [];
  List<ItensProtocolo> listaItensProtocoloId = [];
  double scrollVeiculo = 7000.00;

  loadPlacas() async {
    final response = await Dio()
        .get('$BASEURL/retornarVeiculosNaoProtocolados?nao_finalizados=');

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
        responseTipo.data['results'][1]['id'] == '2'
            ? scrollVeiculo = 18400.00
            : scrollVeiculo = 7000.00;

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

  Future<List<Protocolo>> retornarProtocolos(bool filtrado) async {
    await Future.delayed(Duration(seconds: 2));
    final responseTodosOsProtocolos =
        await Dio().get('${URL}retornarProtocolos?nao_finalizados=${filtrado}');
    listaPlacasPorProtocolo(
        responseTodosOsProtocolos.data['protocolos'] as List);
    return (responseTodosOsProtocolos.data['protocolos'] as List)
        .map((item) {
          return Protocolo.fromJson(item);
        })
        .toList()
        .reversed
        .toList();
  }

  Future<void> listaPlacasPorProtocolo(List lista) async {
    listaPlacas.value = await (lista.map((item) {
      return Placas.fromJson(item);
    })).toList().reversed.toList();
  }

  Future<Protocolo> retornarProtocolosPorId(bool filtrado, String id) async {
    final responseProtocoloPorId = await Dio()
        .get('${URL}retornarProtocolos?nao_finalizados=${filtrado}&id=${id}');
    return Protocolo.fromJson(responseProtocoloPorId.data['protocolos'][0]);
  }

  Future<String> retornarPessoaPorMotorista(String id) async {
    final responsePessoaPorMotoristaId =
        await Dio().get('${URL}retornarPessoaPorMotorista?motorista=${id}');
    Pessoa pessoa =
        Pessoa.fromJson(responsePessoaPorMotoristaId.data['pessoa'][0]);
    return pessoa.nome.toString();
  }

  Future<List<dynamic>> retornarItensProtocoloId(String id) async {
    final responseItensProtocolosPorId =
        await Dio().get('${URL}retornarItensPorProtocolo?id=${id}');
    responseItensProtocolosPorId.data['itensprotocolo'][1]['itemveiculo'] == '2'
        ? scrollVeiculo = 20000.00
        : scrollVeiculo = 7000.00;

    List<dynamic> listaItensProtocolo =
        (responseItensProtocolosPorId.data['itensprotocolo'] as List)
            .map((element) {
      return element;
    }).toList();

    var listaConvertida = (listaItensProtocolo).map((element) {
      return ItensProtocolo.fromJson(element);
    }).toList();

    listaItensVeiculo = (listaItensProtocolo).map((element) {
      return ItensVeiculos.fromJson(element);
    }).toList();

    listaItensProtocoloId = listaConvertida;

    statusAnterior.value = true;
    return listaConvertida;
  }
}

final chamandoApiReqState = _chamandoApiReq();
