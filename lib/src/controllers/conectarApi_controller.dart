import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

class VeiculoData {
  Future<List<dynamic>> loadPlacas() async {
    final response =
        await Dio().get('$BASEURL/retornarVeiculosNaoProtocolados');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data;
    } else {
      throw Exception('Falha ao carregar as placas');
    }
  }
}

class retornarCarroOuMoto with ChangeNotifier {
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
    final responseTipo =
        await Dio().get('$BASEURL/retornarItensVeiculo?tipo=$change');
    return responseTipo.data['results'];
  }
}
