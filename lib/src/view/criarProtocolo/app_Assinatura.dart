import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:signature/signature.dart';

class Assinatura extends StatefulWidget {
  Assinatura({Key? key}) : super(key: key);

  @override
  State<Assinatura> createState() => _AssinaturaState();
}

class _AssinaturaState extends State<Assinatura> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Dispose Assinatura');
    super.dispose();
    criarProtocoloState.colorAssinatura.value = Colors.black;
    criarProtocoloState.bytesAssinatura.value = '';
    criarProtocoloState.mostraAssinaturaFeita = false;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Assinatura');

    return Center(
      child: ValueListenableBuilder(
        valueListenable: criarProtocoloState.colorAssinatura,
        builder: (context, Color colorAssinatura, _) {
          return Column(
            children: [
              const Divider(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 155,
                    width: MediaQuery.of(context).size.width * 0.82,
                    color: colorAssinatura,
                  ),
                  GestureDetector(
                    onPanStart: (details) =>
                        criarProtocoloState // simulacao de arrasto
                            .colorAssinatura
                            .value = Colors.black,
                    child: Signature(
                      controller: criarProtocoloState.assinaturaController,
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.8,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: (() =>
                    criarProtocoloState.assinaturaController.clear()),
                icon: const Icon(Icons.clear),
                color: Colors.redAccent,
              ),
              ValueListenableBuilder(
                valueListenable: criarProtocoloState.bytesAssinatura,
                builder: (context, bytesAssinatura, _) {
                  return Visibility(
                    visible: criarProtocoloState.mostraAssinaturaFeita,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 150,
                          color: Color(0x00000000),
                        ),
                        RepaintBoundary(
                            key: criarProtocoloState.keyImagem,
                            child: bytesAssinatura.toString().isNotEmpty
                                ? Image.memory(
                                    bytesAssinatura as Uint8List,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 150,
                                  )
                                : Container()),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
