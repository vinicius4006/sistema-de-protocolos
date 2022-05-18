import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';
import 'package:provider/provider.dart';
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

    SignatureController controller =
        context.watch<ProtocoloModelo>().controller;

    return Center(
      child: Column(
        children: [
          const Divider(),
          Signature(
            controller: controller,
            height: 100,
            width: 320,
            backgroundColor: Colors.grey,
          ),
          IconButton(
            onPressed: (() => setState(() {
                  controller.clear();
                })),
            icon: const Icon(Icons.clear),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
