import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/lista_itens_protocolo.dart';
import 'dart:math';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:signature/signature.dart';

const BASEURL = 'http://10.1.2.218:3000';
class ProtocoloModelo with ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final List<GlobalKey> listaKey = [];




  final SignatureController controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.grey);
      

  final List<Protocolo> listaProtocolo = [];
  final List<ItensProtocolo> listaItensProtocolo = [];
  int selectRadioVerificacao = -1;
  List<bool> changeListaVerificacao = [false];
  bool inicioIsFalse = false;

  var id = Random().nextInt(10000).toString();
  String idFinalProtocolo = '';



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
      String? digitadorFinal,
      String? assinaturaInicial,
      String? assinaturaFinal

      ) async {
    var protocolo = Protocolo(
        id: id, veiculo: idVeiculo, placa: placaVeiculo, inicio: dataInicio, digitador:digitadorInicio, assinaturaInicial: assinaturaInicial); 
     
     //Organizo antes de mandar para o servidor
     listaItensProtocolo.sort(((a, b) => (int.parse(a.itemveiculo.toString())).compareTo(int.parse(b.itemveiculo.toString()))));
  
    var listaItensProtocoloJson = ListaItensProtocolo(itensProtocolo: listaItensProtocolo).toJson();

   

  //MANDANDO PARA O SERVIDOR
    final responseProtocolo = await Dio().post('$BASEURL/protocolos', 
    data: protocolo.toJson())
    .then((response) => debugPrint('SUCESSO: ${response.data}'))
    .catchError((onError) => debugPrint('Motivo do erro: $onError'));
    
    final responseItensProtocolo = await Dio().post('$BASEURL/itens_protocolos', data: listaItensProtocolo)
    .then((response) => debugPrint('SUCESSO: ${response.data}'))
    .catchError((onError) => debugPrint('Motivo do erro: $onError'));
   
    
  
 




    id = Random().nextInt(10000).toString();

    notifyListeners();
  }



  addFormItensProtocolo(String idItemVeiculo, dynamic opcaoSelecionada,
      String inicio, String? img64) async {
    bool _listaChecagem = false;

    final itensProtocolo = ItensProtocolo(
      protocolo: inicioIsFalse ? idFinalProtocolo : id,
      itemveiculo: idItemVeiculo,
      valor: opcaoSelecionada.toString(),
      inicio: inicio,
      imagem: img64,
    );

   

   
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


      

    notifyListeners();
  }


  //Ficou mais fácil só apontar para cá
  endFormItensProtocolo() async {
     final responseItensProtocolo = await Dio().post('$BASEURL/itens_protocolos', data: listaItensProtocolo)
    .then((response) => debugPrint('SUCESSO: ${response.data}'))
    .catchError((onError) => debugPrint('Motivo do erro: $onError'));



    notifyListeners();
  }

  
}
