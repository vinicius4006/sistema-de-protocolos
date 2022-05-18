import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appInfoItensProtocolo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appInfoProtocolo.dart';

class Finalizacao extends StatefulWidget {
  Finalizacao({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  State<Finalizacao> createState() => _FinalizacaoState();
}

class _FinalizacaoState extends State<Finalizacao> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Dispose Finalizacao');
    criarProtocoloState.scrollController = ScrollController();
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
      floatingActionButton: Column(
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
