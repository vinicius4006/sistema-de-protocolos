import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'dart:math';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class ProtocoloModelo with ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final List<Protocolo> listaProtocolo = [];
  final List<ItensProtocolo> listaItensProtocolo = [];
  bool zerarFieldIndex = false;

 // bool seMotoOuCarro = false;

  var id = Random().nextInt(100).toString();

  //Só para testar a tela de finalização
  List<ItensProtocolo>  testandoListaItensProtocolo = [];

  addFormProtocolo(
      String dataInicio,
      String? dataFim,
      String idVeiculo,
      String placaVeiculo,
      String? idMotorista,
      String? nomeMotorista,
      String? observacaoInicio,
      String? observacaoFinal,
      String? digitadorInicio,
      String? digitadorFinal) async {
    var protocolo = Protocolo(
        id: id, veiculo: idVeiculo, placa: placaVeiculo, inicio: dataInicio);

    listaProtocolo.add(protocolo);

    debugPrint('$testandoListaItensProtocolo');

    id = Random().nextInt(100).toString();

    notifyListeners();
  }



  addFormItensProtocolo(String idItemVeiculo, dynamic opcaoSelecionada,
      String? inicio, String? img64) async {
    bool _listaChecagem = false;

    final itensProtocolo = ItensProtocolo(
      protocolo: id,
      itemveiculo: idItemVeiculo,
      valor: opcaoSelecionada.toString(),
      inicio: 't',
      imagem: img64,
    );

   

    if (listaItensProtocolo.isEmpty) {
      listaItensProtocolo.add(itensProtocolo);
    } else {
      for (var elemento in listaItensProtocolo) {
        if (elemento.itemveiculo == itensProtocolo.itemveiculo) {
          elemento.valor = itensProtocolo.valor;
          elemento.imagem = itensProtocolo.imagem;
          _listaChecagem = true;
        }
      }
      _listaChecagem
          ? debugPrint('')
          : listaItensProtocolo.add(itensProtocolo);


          //exibição de teste pode ser apagado dps
      _listaChecagem
          ? debugPrint('')
          : testandoListaItensProtocolo.add(itensProtocolo);
    }

    notifyListeners();
  }


  
}
