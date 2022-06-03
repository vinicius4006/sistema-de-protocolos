import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/pessoa_motorista.dart';
import 'package:protocolo_app/src/shared/models/placas.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

String URL = 'http://10.1.2.218/api/view/ProtocoloFrota/';

class _chamandoApiReq extends ChangeNotifier {
  List<Placas> listaPlacas = []; // exibir no homepage
  String placa = '';
  final ValueNotifier<bool> statusAnterior = ValueNotifier(false);
  List<ItensVeiculos> listaItensVeiculo = [];
  List<ItensProtocolo> listaItensProtocoloId = [];
  double scrollVeiculo = 7000.00;

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

  Future<List<dynamic>> retornarSeMotoOuCarroPorBooleano(int change) async {
    try {
      final responseTipo =
          await Dio().get('$BASEURL/retornarItensVeiculo?tipo=$change');

      return responseTipo.data['results'];
    } catch (e) {
      debugPrint('Motivo de não retornarSeMotoOuCarroPorBooleano: $e');
      return [];
    }
  }

  Future<List<Protocolo>> retornarProtocolos(
      bool filtrado, int limit, int offset) async {
    await Future.delayed(Duration(seconds: 2));
    final responseTodosOsProtocolos = await Dio().get(
        '${URL}retornarProtocolos?nao_finalizados=${filtrado}&limit=${limit}&offset=${offset}');
    listaPlacasPorProtocolo(
        responseTodosOsProtocolos.data['protocolos'] as List);
    return (responseTodosOsProtocolos.data['protocolos'] as List).map((item) {
      return Protocolo.fromJson(item);
    }).toList();
  }

  Future<void> listaPlacasPorProtocolo(List lista) async {
    var listaPlacasNew = await (lista.map((item) {
      return Placas.fromJson(item);
    })).toList().reversed.toList();
    listaPlacas.addAll(listaPlacasNew);
  }

  Future<Protocolo> retornarProtocolosPorId(bool filtrado, int id) async {
    try {
      final responseProtocoloPorId = await Dio()
          .get('${URL}retornarProtocolos?nao_finalizados=${filtrado}&id=${id}');
      placa = responseProtocoloPorId.data['protocolos'][0]['placa'];
      return Protocolo.fromJson(responseProtocoloPorId.data['protocolos'][0]);
    } catch (e) {
      debugPrint('Erro retornarProtocolosPorId: $e');
      return Protocolo();
    }
  }

  Future<dynamic> retornarPessoaPorMotorista(int id, bool todos) async {
    late List<Pessoa> listaPessoas;
    final responsePessoaPorMotoristaId = await Dio()
        .get('${URL}retornarPessoaPorMotorista?pessoa=${todos ? '' : id}');
    if (responsePessoaPorMotoristaId.data['pessoa'].toString() == '[]') {
      return '';
    } else {
      if (todos) {
        listaPessoas =
            await (responsePessoaPorMotoristaId.data['pessoa'] as List)
                .map((pessoa) => Pessoa.fromJson(pessoa))
                .toList()
                .reversed
                .toList();
        return listaPessoas;
      } else {
        Pessoa pessoa =
            Pessoa.fromJson(responsePessoaPorMotoristaId.data['pessoa'][0]);

        return pessoa.nome.toString();
      }
    }
  }

  Future<List<Pessoa>> getPessoa(String query) async {
    final responsePessoaPorMotorista =
        await Dio().get('${URL}retornarPessoaPorMotorista?nome=');
    if (responsePessoaPorMotorista.statusCode == 200) {
      return (responsePessoaPorMotorista.data['pessoa'] as List)
          .map((item) => Pessoa.fromJson(item))
          .where((element) {
        final nomeLower = element.nome!.toLowerCase();
        final queryLower = query.toLowerCase();

        return nomeLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Placas>> getPlacas(String query) async {
    final response = await Dio()
        .get('$BASEURL/retornarVeiculosNaoProtocolados?nao_finalizados=');

    if (response.statusCode == 200) {
      return (response.data as List).map((e) {
        return Placas.fromJson(e);
      }).where((element) {
        final placaLower = element.placa;
        final queryUpper = query.toUpperCase();

        return placaLower!.contains(queryUpper);
      }).toList();
    } else {
      throw Exception('Falha ao carregar as placas');
    }
  }

  Future<List<dynamic>> retornarItensProtocoloId(int id) async {
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
