import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';

import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:signature/signature.dart';

const BASEURL = 'http://10.1.2.218/api/view/ProtocoloFrota';
//https://api.jupiter.com.br

class _CriarProtocolo extends ChangeNotifier {
  //

  final ValueNotifier<int> veiculoSelecionado = ValueNotifier(0);
  int motoristaSelecionado = 0;
  //
  final ValueNotifier<Protocolo> protocolo = ValueNotifier(Protocolo());
  final ValueNotifier<List<ItensProtocolo>> listaItensProtocolo =
      ValueNotifier([]); // notificando para quem?
  final ValueNotifier<String> foto =
      ValueNotifier(''); // notificando para quem?
  //
  final ValueNotifier<List<bool>> changeButton = ValueNotifier([]);
  final SignatureController assinaturaController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.grey,
  );
  final ValueNotifier<List<Color>> listaCoresCard = ValueNotifier([]);
  final ValueNotifier<bool> scrollVisible = ValueNotifier(false);
//
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = (GlobalKey<FormState>());
  final List<GlobalKey> listaKey = []; //cada card tem uma key
  final List<String> listaInput = []; //tipo de card
  final ValueNotifier<bool> showLoadingAndButton = ValueNotifier(false);
  TextEditingController controllerMotorista = TextEditingController();
  final ValueNotifier<Color> colorAssinatura = ValueNotifier(Colors.white);
  TextEditingController controllerPlaca = TextEditingController();

  changeVeiculoSelecionado(int veiculoNovo) {
    veiculoSelecionado.value = 0;
    scrollVisible.value = false;
    showLoadingAndButton.value = true;
    Timer(Duration(seconds: 2), () {
      veiculoSelecionado.value = veiculoNovo;
      Timer(Duration(seconds: 2), () => scrollVisible.value = true);
    });
  }

  changeMotoristaSelecionado(int motorista) {
    Timer(Duration(seconds: 2), (() {
      motoristaSelecionado = motorista;
    }));
  }

  resetVeiculoSelecionado() {
    veiculoSelecionado.value = 0;
    motoristaSelecionado = 0;
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

    FormData formData = FormData.fromMap(protocoloComItens);
    final responseProtocolo = await Dio()
        .post('$BASEURL/salvarProtocolo',
            data: formData,
            options: Options(contentType: Headers.formUrlEncodedContentType))
        .then((response) {
      log('SUCESSO: ${response.data}');
    }).catchError((onError) {
      debugPrint('Motivo do erro: $onError');
    });

    protocolo.value = protocoloNovo;
  }

  addFormItensProtocolo(ItensProtocolo itensProtocolo) async {
    bool _listaChecagem = false;

    for (var elemento in listaItensProtocolo.value) {
      if (elemento.itemveiculo == itensProtocolo.itemveiculo) {
        if (itensProtocolo.valor == null) {
          elemento.imagem = itensProtocolo.imagem;
        } else if (itensProtocolo.valor == 111) {
          //checkbox
          elemento.valor = null;
        } else {
          elemento.valor = itensProtocolo.valor;
        }

        _listaChecagem = true;
        debugPrint('${elemento.toJson()}');
      }
    }
    _listaChecagem
        ? debugPrint('')
        : listaItensProtocolo.value.add(itensProtocolo);
  }

  Future dadosDoTipo(int tipo, BuildContext context) async {
    var result =
        await chamandoApiReqState.retornarSeMotoOuCarroPorBooleano(tipo);
    return result;
  } // essa funcao é para verificacao do tamanho do array

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
    if (changeButton.value[index] == false) {
      changeButton.value[index] = troca;
    }
    changeButton.notifyListeners();
  }

  trocarCordCardRed(int index, context) {
    if (listaCoresCard.value[index] == Theme.of(context).colorScheme.primary) {
      listaCoresCard.value[index] = Colors.redAccent;
    }
    listaCoresCard.notifyListeners();
  }

  trocarCorCardInicial(int index, context) {
    if (listaCoresCard.value[index] == Colors.redAccent) {
      listaCoresCard.value[index] = Theme.of(context).colorScheme.primary;
    }
    listaCoresCard.notifyListeners();
  }

  scrollTo(int index, context) async {
    final keyScroll = criarProtocoloState.listaKey[index].currentContext!;

    criarProtocoloState.trocarCordCardRed(index, context);
    await Scrollable.ensureVisible(
      keyScroll,
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
      scrollController.animateTo(chamandoApiReqState.scrollVeiculo,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    } catch (e) {
      debugPrint('Motivo de não rolar: $e');
    }
  }
}

final criarProtocoloState = _CriarProtocolo();
