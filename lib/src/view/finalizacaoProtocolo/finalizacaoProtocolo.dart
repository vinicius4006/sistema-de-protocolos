import 'dart:async';

import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/api/Api_controller.dart';
import 'package:protocolo_app/src/controllers/protocolo/criarProtocoloController.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/infoItensDoFormulario/infoItensProtocolo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/infoGeral/infoProtocolo.dart';

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
    criarProtocoloState.motoristaSelecionado =
        1; //para finalizar o protocolo, assim
    //será aceito no verificador de protocolo
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
    criarProtocoloState.tamanhoVeiculo.clear();
    criarProtocoloState.motoristaSelecionado = 0;
    super.dispose();
  }

  //Corpo da Aplicação
  @override
  Widget build(BuildContext context) {
    debugPrint('Build Finalizacao');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Finalização de Protocolo',
          style: TextStyle(fontSize: 22),
        ),
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
