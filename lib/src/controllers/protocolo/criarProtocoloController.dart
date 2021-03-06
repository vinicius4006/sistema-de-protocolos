import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:protocolo_app/src/controllers/api/Api_controller.dart';

import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:signature/signature.dart';

const BASEURL = 'https://api.jupiter.com.br/api/view/ProtocoloFrota';

// 'http://10.1.2.218/api/view/ProtocoloFrota'
// 'https://api.jupiter.com.br/api/view/ProtocoloFrota'
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
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Color(0x00000000),
  );
  final ValueNotifier<List<Color>> listaCoresCard = ValueNotifier([]);
  final ValueNotifier<bool> scrollVisible = ValueNotifier(false);
  final List tamanhoVeiculo = [];
//
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = (GlobalKey<FormState>());
  final List<GlobalKey> listaKey = []; //cada card tem uma key
  final List<String> listaInput = []; //tipo de card
  final ValueNotifier<bool> showLoadingAndButton = ValueNotifier(false);
  TextEditingController controllerMotorista = TextEditingController();
  final ValueNotifier<Color> colorAssinatura = ValueNotifier(Colors.black);
  TextEditingController controllerPlaca = TextEditingController();
  final GlobalKey keyImagem = GlobalKey();
  final ValueNotifier<dynamic> bytesAssinatura = ValueNotifier('');
  bool mostraAssinaturaFeita = false;

  //
  TextEditingController obsTextController = TextEditingController();

  changeVeiculoSelecionado(int veiculoNovo, String obs) {
    tamanhoVeiculo.clear();
    criarProtocoloState.obsTextController.clear();
    veiculoSelecionado.value = 0;
    scrollVisible.value = false;
    showLoadingAndButton.value = true;
    Timer(Duration(seconds: 2), () {
      veiculoSelecionado.value = veiculoNovo;
      criarProtocoloState.obsTextController.text = obs;
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

  Future<bool> novoProtocolo(Protocolo protocoloNovo) async {
    bool sucess = false;
    debugPrint('${protocoloNovo.toJson()}');
    listaItensProtocolo.value.sort(((a, b) =>
        (int.parse(a.itemveiculo.toString()))
            .compareTo(int.parse(b.itemveiculo.toString()))));
    ListaItensProtocolo listaItens =
        ListaItensProtocolo(listaItensProtocolo: listaItensProtocolo.value);
    Map<String, dynamic> protocoloComItens = {
      ...protocoloNovo.toJson(),
      ...listaItens.toJson()
    };
    protocoloComItens.forEach((key, value) {
      debugPrint('Itens: $value');
    });

    try {
      FormData formData = FormData.fromMap(protocoloComItens);
      final responseProtocolo = await Dio()
          .post('$BASEURL/salvarProtocolo',
              data: formData,
              options: Options(
                  contentType: Headers.formUrlEncodedContentType,
                  receiveDataWhenStatusError: true,
                  receiveTimeout: 3 * 1000,
                  sendTimeout: 3 * 1000))
          .then((response) {
        log('ENVIO DE PROTOCOLO: ${response.data}');
        sucess = !(json.decode(response.data) as Map)
            .values
            .first
            .toString()
            .isEmpty;
      }).catchError((onError) {
        debugPrint('Motivo do erro: $onError');
      });
    } on DioError catch (e) {
      debugPrint('Motivo do erro: $e');
    }
    if (sucess) {
      protocolo.value = protocoloNovo;
    }

    return sucess;
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
      debugPrint('Motivo de n??o rolar: $e');
    }
  }

  capture() async {
    RenderRepaintBoundary boundary =
        keyImagem.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    String assinaturaBase64 = base64Encode(pngBytes);
    return assinaturaBase64;
  }
}

final criarProtocoloState = _CriarProtocolo();
