import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/lista_itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

const BASEURL = 'http://10.1.2.218:3000';

class _CriarProtocolo extends ChangeNotifier {
  final ValueNotifier<String> veiculoSelecionado = ValueNotifier('');
  final ValueNotifier<Protocolo> protocolo = ValueNotifier(Protocolo());
  final ValueNotifier<List<ItensProtocolo>> listaItensProtocolo =
      ValueNotifier([]);
  final ValueNotifier<String> foto = ValueNotifier('');

  changeVeiculoSelecionado(String veiculoNovo) {
    veiculoSelecionado.value = '';
    Timer(Duration(seconds: 2), () {
      veiculoSelecionado.value = veiculoNovo;
    });
  }

  resetVeiculoSelecionado() {
    veiculoSelecionado.value = '';
  }

  novoProtocolo(Protocolo protocoloNovo) async {
    listaItensProtocolo.value.sort(((a, b) =>
        (int.parse(a.itemveiculo.toString()))
            .compareTo(int.parse(b.itemveiculo.toString()))));
    listaItensProtocolo.value.forEach((element) {
      element.protocolo = protocoloNovo.id;
    });
    var listaItensProtocoloJson =
        ListaItensProtocolo(itensProtocolo: listaItensProtocolo.value).toJson();

    final responseProtocolo = await Dio()
        .post('$BASEURL/protocolos', data: protocoloNovo.toJson())
        .then((response) => debugPrint('SUCESSO: ${response.data}'))
        .catchError((onError) => debugPrint('Motivo do erro: $onError'));

    protocolo.value = protocoloNovo;

    final responseItensProtocolo = await Dio()
        .post('$BASEURL/itens_protocolos', data: listaItensProtocoloJson)
        .then((response) => debugPrint('SUCESSO: ${response.data}'))
        .catchError((onError) => debugPrint('Motivo do erro: $onError'));
  }

  addFormItensProtocolo(ItensProtocolo itensProtocolo) async {
    bool _listaChecagem = false;
    
    for (var elemento in listaItensProtocolo.value) {
      if (elemento.itemveiculo == itensProtocolo.itemveiculo) {
        itensProtocolo.valor!.isEmpty ? elemento.imagem = itensProtocolo.imagem : elemento.valor = itensProtocolo.valor;
        _listaChecagem = true;
      }
    }
    _listaChecagem
        ? debugPrint('')
        : listaItensProtocolo.value.add(itensProtocolo);
  }

  capturarPathFoto(String path){
      foto.value = path;
  }

  excluirFoto(){
    foto.value = '';
  }



 
}

final criarProtocoloState = _CriarProtocolo();
