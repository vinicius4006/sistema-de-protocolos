

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
 String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

class MotoristaData {
  
   Future<List<dynamic>> loadMotoristas() async {
    
    final response = await Dio().get('$BASEURL/retornarPessoas');

       if(response.statusCode == 200) {
      // final testeJson = jsonDecode(response.toString());
      // debugPrint('${testeJson[0]}');
       //Map<String, dynamic> comp = response.data;
       Map<String, dynamic> mapData =  response.data;
       List<dynamic> data = mapData['results'];
       return data;

    } else {
      throw Exception('Falha ao carregar motorisas');
    }
  }
  String name(dynamic user) {
    return user['nome'];
  }
}

class VeiculoData{
 Future<List<dynamic>> loadPlacas() async {
    
    final response = await Dio().get('$BASEURL/retornarVeiculosNaoProtocolados');

       if(response.statusCode == 200) {
      // final testeJson = jsonDecode(response.toString());
      // debugPrint('${testeJson[0]}');
       //Map<String, dynamic> comp = response.data;
       //Map<String, dynamic> mapData =  response.data;
       List<dynamic> data = response.data;
       return data;

    } else {
      throw Exception('Falha ao carregar motorisas');
    }
  }
}


 Future<bool> retornarSeMotoOuCarro(String id) async {
   final response = await Dio().get('$BASEURL/retornarVeiculoPorId?id=$id');
   
   //debugPrint(id);
  if(response.statusCode == 200){
    Map<String,dynamic> data = response.data;
  debugPrint(data['tipo']);
      if(data['tipo'] == 0){
        return true;
      } else {
        return false;
      }
    
    

  } else {
    throw Exception('Falha ao verificar dados do veículo');
  }

}






