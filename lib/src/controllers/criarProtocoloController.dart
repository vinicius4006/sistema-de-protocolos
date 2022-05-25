import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';

import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:signature/signature.dart';

const BASEURL = 'http://10.1.2.218/api/view/ProtocoloFrota';

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
  final ValueNotifier<bool> scrollVisible = ValueNotifier(false);

  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = (GlobalKey<FormState>());
  final List<GlobalKey> listaKey = [];
  final List<String> listaInput = [];

  changeVeiculoSelecionado(String veiculoNovo) {
    veiculoSelecionado.value = '';
    scrollVisible.value = false;
    Timer(Duration(seconds: 2), () {
      veiculoSelecionado.value = veiculoNovo;
      Timer(Duration(seconds: 2), () => scrollVisible.value = true);
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
    ListaItensProtocolo listaItens =
        ListaItensProtocolo(listaItensProtocolo: listaItensProtocolo.value);
    Map<String, dynamic> protocoloComItens = {
      ...protocoloNovo.toJson(),
      ...listaItens.toJson()
    };
    log('$protocoloComItens');
    FormData formData = FormData.fromMap(protocoloComItens);
    final responseProtocolo = await Dio()
        .post('$BASEURL/salvarProtocolo',
            data: formData,
            options: Options(contentType: Headers.formUrlEncodedContentType))
        .then((response) {
      log('SUCESSO: ${response.data}');
      return response.data;
    }).catchError((onError) {
      debugPrint('Motivo do erro: $onError');
      return false;
    });

    protocolo.value = protocoloNovo;
  }

  addFormItensProtocolo(ItensProtocolo itensProtocolo) async {
    bool _listaChecagem = false;

    for (var elemento in listaItensProtocolo.value) {
      if (elemento.itemveiculo == itensProtocolo.itemveiculo) {
        itensProtocolo.valor == null
            ? elemento.imagem = itensProtocolo.imagem
            : elemento.valor = itensProtocolo.valor;
        _listaChecagem = true;
        debugPrint('${elemento.toJson()}');
      }
    }
    _listaChecagem
        ? debugPrint('')
        : listaItensProtocolo.value.add(itensProtocolo);
  }

  // addFormProtocoloEnd(
  //     DateTime dataFim, String digitadorFinal, String assinaturaFinal) async {
  //   //Organizo antes de mandar para o servidor
  //   listaItensProtocolo.value.sort(((a, b) =>
  //       (int.parse(a.itemveiculo.toString()))
  //           .compareTo(int.parse(b.itemveiculo.toString()))));

  //   //listaProtocolo.add(protocolo);

  //   //MANDANDO PARA O SERVIDOR
  //   final responseProtocoloFinalizado = await Dio()
  //       .patch('$BASEURL/protocolos/', data: {
  //         "digitador_final": digitadorFinal,
  //         "fim": dataFim,
  //         "assinaturaFinal": assinaturaFinal
  //       }) //"assinaturaFinal": assinaturaFinal
  //       .then((response) => debugPrint('SUCESSO: ${response.data}'))
  //       .catchError((onError) => debugPrint('Motivo do erro na att: $onError'));

  //   var listaItensProtocoloJson =
  //       ListaItensProtocolo(itensProtocolo: listaItensProtocolo.value).toJson();
  //   final responseItensProtocolo = await Dio()
  //       .post('$BASEURL/itens_protocolos', data: listaItensProtocoloJson)
  //       .then((response) => debugPrint('SUCESSO: ${response.data}'))
  //       .catchError((onError) => debugPrint('Motivo do erro: $onError'));
  //   protocolo.notifyListeners();
  //   //O envio dos formularios com att está no start Protocolo
  // }

  Future dadosDoTipo(String tipo, BuildContext context) async {
    var result =
        await chamandoApiReqState.retornarSeMotoOuCarroPorBooleano(tipo);
    return result;
  } // essa funcao é para verificacao do tamanho do array

  List<int> pegarDadosItensStatus(List<dynamic> lista, String id) {
    List<int>? listaItens = [];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == id) {
        listaItens.add(item.valor!);
      }
    }

    return listaItens;

    //atenção na lista que está add mais imagens que o permitido pois a lista não está reiniciando
  }

  List<String> pegarImgPorStatus(List<dynamic> lista, int id) {
    List<String>? listaImg = [];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == id && item.imagem != null) {
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

  exibirFotoTemporaria(int numCat, BuildContext context, int index) {
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

  trocarCorCardGreen(int index) {
    if (listaCoresCard.value[index] == Colors.redAccent) {
      listaCoresCard.value[index] = Colors.green;
    }
    listaCoresCard.notifyListeners();
  }

  scrollTo(int index) async {
    final keyScroll = criarProtocoloState.listaKey[index].currentContext!;
    //final keyColor = criarProtocoloState.listaKey[index].currentWidget!;
    criarProtocoloState.trocarCordCardRed(index);
    await Scrollable.ensureVisible(
      keyScroll,
      duration: const Duration(milliseconds: 600),
    );
  }

  scrollToTop() async {
    // debugPrint('${loginControllerState.token}');
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  scrollToBottom() async {
    try {
      // final keyScroll = await key.currentContext!;

      // await Scrollable.ensureVisible(
      //   keyScroll,
      //   duration: const Duration(milliseconds: 600),
      // );
      debugPrint('SCROLL: ${chamandoApiReqState.scrollVeiculo}');
      scrollController.animateTo(chamandoApiReqState.scrollVeiculo,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    } catch (e) {
      debugPrint('Motivo de não rolar: $e');
    }
  }
}

final criarProtocoloState = _CriarProtocolo();
