import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:signature/signature.dart';

class Assinatura extends StatefulWidget {
  Assinatura({Key? key}) : super(key: key);

  @override
  State<Assinatura> createState() => _AssinaturaState();
}

class _AssinaturaState extends State<Assinatura> {
  Color colorAssinatura = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Dispose Assinatura');
    super.dispose();
    criarProtocoloState.colorAssinatura.value = Colors.white;
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
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 21),
                    height: 165,
                    width: 350,
                    color: colorAssinatura,
                  ),
                  GestureDetector(
                    onPanStart: (details) =>
                        criarProtocoloState // simulacao de arrasto
                            .colorAssinatura
                            .value = Colors.white,
                    child: Signature(
                      controller: criarProtocoloState.assinaturaController,
                      height: 150,
                      width: 320,
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
            ],
          );
        },
      ),
    );
  }
}
