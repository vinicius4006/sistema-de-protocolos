import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/pessoa_motorista.dart';
import 'package:protocolo_app/src/shared/models/placas.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

String BASEURL = 'https://api.jupiter.com.br/api/view/ProtocoloFrota';

//'https://api.jupiter.com.br/api/view/ProtocoloFrota';
// 'http://10.1.2.218/api/view/ProtocoloFrota'

class _chamandoApiReq extends ChangeNotifier {
  List<Placas> listaPlacas = []; // exibir no homepage
  String placa = '';
  final ValueNotifier<bool> statusAnterior = ValueNotifier(false);
  List<ItensVeiculos> listaItensVeiculo = [];
  List<ItensProtocolo> listaItensProtocoloId = [];
  final List<ItensProtocolo> listaImagem = [];
  double scrollVeiculo = 7000.00;

  Future<bool> verificarConexao() async {
    return await InternetConnectionChecker().hasConnection;
  }

  Future<List<dynamic>> retornarSeMotoOuCarro(int id) async {
    try {
      if (id != -1 && id != 0) {
        final response = await Dio().get('$BASEURL/retornarVeiculoPorId?id=$id',
            options: Options(receiveTimeout: 3000, sendTimeout: 3000));

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
    } on DioError catch (e) {
      debugPrint('Motivo do erro retornarItens: $e');
      return [];
    }
  }

  Future<List<dynamic>> retornarSeMotoOuCarroPorBooleano(int change) async {
    try {
      final responseTipo = await Dio().get(
          '$BASEURL/retornarItensVeiculo?tipo=$change',
          options: Options(receiveTimeout: 3000, sendTimeout: 3000));

      return responseTipo.data['results'];
    } on DioError catch (e) {
      debugPrint('Motivo de não retornarSeMotoOuCarroPorBooleano: $e');
      return [];
    }
  }

  Future<List<Protocolo>> retornarProtocolos(
      bool filtrado, int limit, int offset,
      [String? keyword, bool? boolVer]) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      String filtroQuery = boolVer != null
          ? boolVer
              ? '&id=${keyword}'
              : '&placa=${keyword}'
          : '';
      final responseTodosOsProtocolos = await Dio().get(
          '$BASEURL/retornarProtocolos?nao_finalizados=${filtrado}&limit=${limit}&offset=${offset}${filtroQuery}',
          options: Options(sendTimeout: 3000, receiveTimeout: 3000));

      listaPlacasPorProtocolo(
          responseTodosOsProtocolos.data['protocolos'] as List);
      return (responseTodosOsProtocolos.data['protocolos'] as List).map((item) {
        return Protocolo.fromJson(item);
      }).toList();
    } on DioError catch (e) {
      debugPrint('erro retornarProtocolos: $e');
      return [];
    }
  }

  Future<void> listaPlacasPorProtocolo(List lista) async {
    var listaPlacasNew = await (lista.map((item) {
      return Placas.fromJson(item);
    })).toList();
    listaPlacas.addAll(listaPlacasNew);
  }

  Future<Protocolo> retornarProtocolosPorId(bool filtrado, int id) async {
    try {
      final responseProtocoloPorId = await Dio().get(
          '$BASEURL/retornarProtocolos?nao_finalizados=${filtrado}&limit=1&offset=0&id=${id}',
          options: Options(receiveTimeout: 2000, sendTimeout: 2000));
      placa = responseProtocoloPorId.data['protocolos'][0]['placa'];
      return Protocolo.fromJson(responseProtocoloPorId.data['protocolos'][0]);
    } on DioError catch (e) {
      debugPrint('Erro retornarProtocolosPorId: $e');
      return Protocolo(digitador: 'problema');
    }
  }

  Future<dynamic> retornarPessoaPorMotorista(int id, bool todos) async {
    late List<Pessoa> listaPessoas;
    try {
      final responsePessoaPorMotoristaId = await Dio().get(
          '$BASEURL/retornarPessoaPorMotorista?pessoa=${todos ? '' : id}',
          options: Options(sendTimeout: 3000, receiveTimeout: 3000));
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
    } on DioError catch (e) {
      debugPrint('motivo erro retornarPessoaPorMotorista: $e');
      return 'Problemas para achar o nome do motorista';
    }
  }

  Future<List<Pessoa>> getPessoa(String query) async {
    try {
      final responsePessoaPorMotorista = await Dio().get(
          '$BASEURL/retornarPessoaPorMotorista?nome=${query}',
          options: Options(receiveTimeout: 3000, sendTimeout: 3000));
      if (responsePessoaPorMotorista.statusCode == 200) {
        return (responsePessoaPorMotorista.data['pessoa'] as List)
            .map((item) => Pessoa.fromJson(item))
            .toList();
      } else {
        throw Exception();
      }
    } on DioError {
      return [Pessoa(nome: 'Houve algum problema')];
    }
  }

  Future<List<Placas>> getPlacas(String query) async {
    try {
      var options = BaseOptions(
          baseUrl:
              '$BASEURL/retornarVeiculosComOuSemProtocolos?nao_iniciados=${query}',
          connectTimeout: 3000,
          receiveTimeout: 3000);
      final response = await Dio(options).get(
          '$BASEURL/retornarVeiculosComOuSemProtocolos?nao_iniciados=${query}');

      if (response.statusCode == 200) {
        return (response.data['results'] as List).map((e) {
          return Placas.fromJson(e);
        }).toList();
      } else {
        throw Exception('Falha ao carregar as placas');
      }
    } on DioError {
      return [Placas(placa: 'Houve algum problema')];
    }
  }

  Future retornarImagensPorProtocolo(id, item) async {
    try {
      if (listaImagem.isEmpty) {
        final responseRetornarImagensPorProtocolo = await Dio().get(
            '$BASEURL/retornarImagensPorProtocolo?id=${id}&item=${item}',
            options: Options(sendTimeout: 3000, receiveTimeout: 3000));
        listaImagem.add(ItensProtocolo(
            itemveiculo: int.parse(responseRetornarImagensPorProtocolo
                .data['imagensProtocolo'][0]['itemveiculo']),
            imagem: responseRetornarImagensPorProtocolo.data['imagensProtocolo']
                [0]['imagem']));
        listaImagem.forEach((element) {
          debugPrint('OLHA: ${element.toJson()}');
        });
        return responseRetornarImagensPorProtocolo.data['imagensProtocolo'][0]
            ['imagem'];
      } else {
        ItensProtocolo passarImagem = listaImagem.firstWhere(
            (element) => element.itemveiculo == item,
            orElse: () => ItensProtocolo(valor: 0));

        if (passarImagem.valor == 0) {
          final responseRetornarImagensPorProtocolo = await Dio().get(
              '$BASEURL/retornarImagensPorProtocolo?id=${id}&item=${item}');
          listaImagem.add(ItensProtocolo(
              itemveiculo: int.parse(responseRetornarImagensPorProtocolo
                  .data['imagensProtocolo'][0]['itemveiculo']),
              imagem: responseRetornarImagensPorProtocolo
                  .data['imagensProtocolo'][0]['imagem']));
          listaImagem.forEach((element) {
            debugPrint('OLHA: ${element.toJson()}');
          });
          return responseRetornarImagensPorProtocolo.data['imagensProtocolo'][0]
              ['imagem'];
        } else {
          return passarImagem.imagem;
        }
      }
    } on DioError catch (e) {
      debugPrint('error imagem: $e');
      return '';
    }
  }

  Future<List<dynamic>> retornarItensProtocoloId(int id) async {
    listaImagem.clear();
    try {
      final responseItensProtocolosPorId = await Dio().get(
          '$BASEURL/retornarItensPorProtocolo?id=${id}',
          options: Options(receiveTimeout: 3000, sendTimeout: 3000));
      responseItensProtocolosPorId.data['itensprotocolo'][1]['itemveiculo'] ==
              '2'
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

      List<String> listaOps = [];
      List<ItensVeiculos> listaSemRepeticao = [];

      listaItensVeiculo = (listaItensProtocolo).map((element) {
        debugPrint('${ItensVeiculos.fromJson(element).toJson()}');
        if (!listaOps.contains(element['id'])) {
          listaSemRepeticao.add(ItensVeiculos.fromJson(element));
          listaOps.add(element['id']);
        }
        return ItensVeiculos.fromJson(element);
      }).toList();

      listaItensVeiculo = listaSemRepeticao;
      // listaItensVeiculo.forEach((element) {
      //   debugPrint('ITENS: ${element.toJson()}');
      // });
      listaItensProtocoloId = listaConvertida;

      statusAnterior.value = true;
      return listaConvertida;
    } on DioError catch (e) {
      debugPrint('motivo do erro retornarItensProtocoloId: $e');
      return [];
    }
  }
}

final chamandoApiReqState = _chamandoApiReq();
