import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/view/criarProtocolo/appButtonSalvar.dart';
import 'package:protocolo_app/src/view/criarProtocolo/appSearch.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Assinatura.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({Key? key}) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
  GlobalKey<ArtDialogState>? _artDialogKey;

  @override
  void initState() {
    _artDialogKey = GlobalKey<ArtDialogState>();
    super.initState();
  }

  @override
  void dispose() {
    criarProtocoloState.veiculoSelecionar.clear();
    criarProtocoloState.motoristaSelecionar.clear();
    criarProtocoloState.resetVeiculoSelecionado();
    criarProtocoloState.scrollController = ScrollController();
    criarProtocoloState.assinaturaController.value.clear();
    criarProtocoloState.scrollVisible.value = false;
    criarProtocoloState.listaInput.clear();
    criarProtocoloState.showLoadingAndButton.value = false;

    super.dispose();
    debugPrint('Dispose CriarProtocolo');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build CriarProtocolo');
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_outlined));
          }),
          centerTitle: true,
          title: const Text('Criação de Protocolo'),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: criarProtocoloState.scrollVisible,
          builder: (context, bool scrollVisible, _) => scrollVisible
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      onPressed: (() => criarProtocoloState.scrollToTop()),
                      child: const Icon(Icons.arrow_upward),
                      heroTag: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.small(
                      heroTag: null,
                      onPressed: (() => criarProtocoloState.scrollToBottom()),
                      child: const Icon(Icons.arrow_downward),
                    ),
                  ],
                )
              : Text(''),
        ),
        body: Form(
          key: criarProtocoloState.formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              controller: criarProtocoloState.scrollController,
              children: <Widget>[
                const SizedBox(
                  height: 60.0,
                ),
                Pesquisa(),
                const SizedBox(
                  height: 20.0,
                ),
                ValueListenableBuilder(
                  valueListenable: criarProtocoloState.veiculoSelecionado,
                  builder: (context, int veiculoSelecionado, _) =>
                      veiculoSelecionado != 0
                          ? Column(
                              children: [
                                VeiculoForm(
                                  veiculo: veiculoSelecionado,
                                ),
                                FutureBuilder(
                                    future: Future.delayed(Duration(seconds: 1),
                                        () {
                                      return true;
                                    }),
                                    builder: ((context, snapshot) =>
                                        !snapshot.hasData
                                            ? Text('')
                                            : Assinatura())),
                              ],
                            )
                          : ValueListenableBuilder(
                              valueListenable:
                                  criarProtocoloState.showLoadingAndButton,
                              builder: (context, bool showLoadingAndButton, _) {
                                return Visibility(
                                  visible: showLoadingAndButton,
                                  child: Center(
                                    child: LoadingAnimationWidget.waveDots(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 100,
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
                ValueListenableBuilder(
                    valueListenable: criarProtocoloState.showLoadingAndButton,
                    builder: (context, bool showLoadingAndButton, _) {
                      return Visibility(
                        visible: !showLoadingAndButton,
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Center(
                              child: Stack(children: [
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                            Container(
                              width: 240.0,
                              height: 240.0,
                              margin: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage('assets/img-mobile.png'))),
                            ),
                          ])),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                  valueListenable: criarProtocoloState.showLoadingAndButton,
                  builder: (context, bool showLoadingAndButton, _) {
                    return Visibility(
                      visible: showLoadingAndButton,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ButtonEnviar())),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
