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
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Assinatura');

    return Center(
      child: ValueListenableBuilder(
        valueListenable: criarProtocoloState.assinaturaController,
        builder: (context, SignatureController controller, _) {
          return Column(
            children: [
              const Divider(),
              Signature(
                controller: controller,
                height: 100,
                width: 320,
                backgroundColor: Colors.grey,
              ),
              IconButton(
                onPressed: (() =>
                    criarProtocoloState.assinaturaController.value.clear()),
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
