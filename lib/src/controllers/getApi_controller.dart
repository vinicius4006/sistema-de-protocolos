import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

// class MotoristaData {
//   Future<List<dynamic>> loadMotoristas() async {
//     final response = await Dio().get('$BASEURL/retornarPessoas');

//     if (response.statusCode == 200) {
//       // final testeJson = jsonDecode(response.toString());
//       // debugPrint('${testeJson[0]}');
//       //Map<String, dynamic> comp = response.data;
//       Map<String, dynamic> mapData = response.data;
//       List<dynamic> data = mapData['results'];
//       return data;
//     } else {
//       throw Exception('Falha ao carregar motorisas');
//     }
//   }

//   String name(dynamic user) {
//     return user['nome'];
//   }
// }

class VeiculoData {
  Future<List<dynamic>> loadPlacas() async {
    final response =
        await Dio().get('$BASEURL/retornarVeiculosNaoProtocolados');

    if (response.statusCode == 200) {
      // final testeJson = jsonDecode(response.toString());
      // debugPrint('${testeJson[0]}');
      //Map<String, dynamic> comp = response.data;
      //Map<String, dynamic> mapData =  response.data;
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

        //debugPrint('${responseTipo.data['results']}');

        return responseTipo.data['results'];
      } else {
        throw Exception('Falha ao verificar dados do veículo');
      }
    } else {
      return [];
    }
  }
}
