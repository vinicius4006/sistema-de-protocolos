import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

const BASEURL = 'http://10.1.2.218:3000';

class EndProtocolo {
  final List<Protocolo> listaProtocolo = [];
   List<ItensProtocolo> listaItensProtocolo = [];

  //Só para testar a tela de finalização

  addFormProtocoloEnd(String id, String dataFim, String digitadorFinal, String assinaturaFinal) async { //String assinaturaFinal
  

    //Organizo antes de mandar para o servidor
    listaItensProtocolo.sort(((a, b) => (int.parse(a.itemveiculo.toString()))
        .compareTo(int.parse(b.itemveiculo.toString()))));

    
      

    //listaProtocolo.add(protocolo);

    //MANDANDO PARA O SERVIDOR
    final responseProtocoloFinalizado = await Dio()
        .patch('$BASEURL/protocolos/$id', data: {"digitador_final": digitadorFinal, "fim": dataFim, "assinaturaFinal": assinaturaFinal}) //"assinaturaFinal": assinaturaFinal
        .then((response) => debugPrint('SUCESSO: ${response.data}'))
        .catchError((onError) => debugPrint('Motivo do erro na att: $onError'));

    //O envio dos formularios com att está no start Protocolo

    
  }

 
}
