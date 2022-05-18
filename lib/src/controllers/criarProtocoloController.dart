import 'dart:async';
import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';

import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/lista_itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:signature/signature.dart';

const BASEURL = 'http://10.1.2.218:3000';

class _CriarProtocolo extends ChangeNotifier {
  final ValueNotifier<String> veiculoSelecionado = ValueNotifier('');
  final ValueNotifier<Protocolo> protocolo = ValueNotifier(Protocolo());
  final ValueNotifier<List<ItensProtocolo>> listaItensProtocolo =
      ValueNotifier([]); // notificando para quem?
  final ValueNotifier<String> foto =
      ValueNotifier(''); // notificando para quem?
  final ValueNotifier<List<bool>> changeButton = ValueNotifier([]);
  final ValueNotifier<SignatureController> assinaturaController = ValueNotifier(
      SignatureController(
          penStrokeWidth: 3,
          penColor: Colors.black,
          exportBackgroundColor: Colors.grey));
  final ValueNotifier<List<Color>> listaCoresCard = ValueNotifier([]);

  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = (GlobalKey<FormState>());
  final List<GlobalKey> listaKey = [];

  changeVeiculoSelecionado(String veiculoNovo) {
    veiculoSelecionado.value = '';
    Timer(Duration(seconds: 2), () {
      veiculoSelecionado.value = veiculoNovo;
    });
  }

  resetVeiculoSelecionado() {
    veiculoSelecionado.value = '';
  }

  refreshPage() {
    protocolo.notifyListeners();
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
        itensProtocolo.valor!.isEmpty
            ? elemento.imagem = itensProtocolo.imagem
            : elemento.valor = itensProtocolo.valor;
        _listaChecagem = true;
      }
    }
    _listaChecagem
        ? debugPrint('')
        : listaItensProtocolo.value.add(itensProtocolo);
  }

  addFormProtocoloEnd(String id, String dataFim, String digitadorFinal,
      String assinaturaFinal) async {
    //String assinaturaFinal

    //Organizo antes de mandar para o servidor
    listaItensProtocolo.value.sort(((a, b) =>
        (int.parse(a.itemveiculo.toString()))
            .compareTo(int.parse(b.itemveiculo.toString()))));

    //listaProtocolo.add(protocolo);

    //MANDANDO PARA O SERVIDOR
    final responseProtocoloFinalizado = await Dio()
        .patch('$BASEURL/protocolos/$id', data: {
          "digitador_final": digitadorFinal,
          "fim": dataFim,
          "assinaturaFinal": assinaturaFinal
        }) //"assinaturaFinal": assinaturaFinal
        .then((response) => debugPrint('SUCESSO: ${response.data}'))
        .catchError((onError) => debugPrint('Motivo do erro na att: $onError'));
    listaItensProtocolo.value.forEach((element) {
      if (element.inicio == 't' && element.protocolo == null) {
        element.inicio = 'f';
        element.protocolo = id;
      }
      ;
    });
    var listaItensProtocoloJson =
        ListaItensProtocolo(itensProtocolo: listaItensProtocolo.value).toJson();
    final responseItensProtocolo = await Dio()
        .post('$BASEURL/itens_protocolos', data: listaItensProtocoloJson)
        .then((response) => debugPrint('SUCESSO: ${response.data}'))
        .catchError((onError) => debugPrint('Motivo do erro: $onError'));
    protocolo.notifyListeners();
    //O envio dos formularios com att está no start Protocolo
  }

  Future dadosDoTipo(String tipo, BuildContext context) async {
    var result =
        await chamandoApiReqState.retornarSeMotoOuCarroPorBooleano(tipo);
    return result;
  }

  List<String> pegarDadosItensStatus(List<dynamic> lista, String id) {
    List<String>? listaItens = [];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == id) {
        listaItens.add(item.valor!);
      }
    }

    return listaItens;

    //atenção na lista que está add mais imagens que o permitido pois a lista não está reiniciando
  }

  List<String> pegarImgPorStatus(List<dynamic> lista, String id) {
    List<String>? listaImg = [];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == id) {
        listaImg.add(item.imagem.toString());
      }
    }

    return listaImg;

    //atenção na lista que está add mais imagens que o permitido pois a lista não está reiniciando
  }

  capturarPathFoto(String path) {
    foto.value = path;
  }

  excluirFoto() {
    foto.value = '';
  }

  exibirFotoTemporaria(String numCat, BuildContext context, int index) {
    List<ItensProtocolo> imagemPorId = listaItensProtocolo.value
        .where((element) => element.itemveiculo == numCat)
        .toList();

    const Base64Codec base64 = Base64Codec();
    var bytes = base64.decode(imagemPorId[0].imagem.toString());
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(title: "Foto tirada", customColumns: [
          Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: Image.memory(
                bytes,
                width: 500,
                fit: BoxFit.fitWidth,
              )),
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                listaItensProtocolo.value.forEach((element) {
                  if (element.imagem == imagemPorId[0].imagem.toString()) {
                    element.imagem = '';
                  }
                });
                changeButton.value[index] = false;
                changeButton.notifyListeners();
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete_forever_rounded),
              label: Text('Excluir')),
          SizedBox(
            height: 20,
          ),
        ]));
  }

  trocarButton(int index, bool troca) {
    debugPrint('Index: ${index} Troca: ${troca}');
    if (changeButton.value[index] == false) {
      changeButton.value[index] = troca;
    }
    changeButton.notifyListeners();
  }

  trocarCordCardRed(int index) {
    if (listaCoresCard.value[index] == Colors.green) {
      listaCoresCard.value[index] = Colors.redAccent;
    }
    listaCoresCard.notifyListeners();
  }

  scrollTo(int index) async {
    final listaKeyScroll = criarProtocoloState.listaKey[index].currentContext!;
    criarProtocoloState.trocarCordCardRed(index);
    await Scrollable.ensureVisible(
      listaKeyScroll,
      duration: const Duration(milliseconds: 600),
    );
  }

  scrollToTop() async {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  scrollToBottom() async {
    try {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    } catch (e) {
      debugPrint('Motivo de não rolar: $e');
    }
  }
}

final criarProtocoloState = _CriarProtocolo();
