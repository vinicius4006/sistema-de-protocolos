import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class Assinatura extends StatefulWidget {
  const Assinatura({ Key? key }) : super(key: key);

  @override
  State<Assinatura> createState() => _AssinaturaState();
}

class _AssinaturaState extends State<Assinatura> {

  @override
  Widget build(BuildContext context) {
    SignatureController controller = context.read<ProtocoloModelo>().controller;
    return Center(
      child: Column(children: [
         const Divider(),
            Signature(
              controller: controller,
              height: 110,
              width: 400,

              backgroundColor: Colors.grey,
            ),
            IconButton(
              onPressed: (() => setState(() {
                    controller.clear();
                  })),
              icon: const Icon(Icons.clear),
              color: Colors.redAccent,
            ),
      ],),
    );
  }
}