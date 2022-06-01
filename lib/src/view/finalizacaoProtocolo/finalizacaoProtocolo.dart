import 'dart:async';

import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/homePageApi_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appInfoItensProtocolo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appInfoProtocolo.dart';

class Finalizacao extends StatefulWidget {
  Finalizacao({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  State<Finalizacao> createState() => _FinalizacaoState();
}

class _FinalizacaoState extends State<Finalizacao> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('${chamandoApiReqState.listaPlacas}');
    Timer(Duration(seconds: 2),
        () => criarProtocoloState.scrollVisible.value = true);
  }

  @override
  void dispose() {
    debugPrint('Dispose Finalizacao');
    criarProtocoloState.scrollController = ScrollController();
    criarProtocoloState.scrollVisible.value = false;
    chamandoApiReqState.statusAnterior.value = false;
    criarProtocoloState.listaInput.clear();
    criarProtocoloState.assinaturaController.value.clear();

    super.dispose();
  }

  //Corpo da Aplicação
  @override
  Widget build(BuildContext context) {
    debugPrint('Build Finalizacao');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalização de Protocolo'),
        centerTitle: true,
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
      body: SingleChildScrollView(
        controller: criarProtocoloState.scrollController,
        child: Column(children: [
          SizedBox(
            height: 350,
            child: Container(
                padding: const EdgeInsets.all(20),
                child: InfoProtocolo(id: widget.id)),
          ),
          InfoItensProtocolo(id: widget.id)
        ]),
      ),
    );
  }
  //}
}
