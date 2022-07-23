import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/protocolo/protocolo_controller.dart';

class ButtonEnviar extends StatefulWidget {
  const ButtonEnviar({Key? key}) : super(key: key);

  @override
  State<ButtonEnviar> createState() => _ButtonEnviarState();
}

class _ButtonEnviarState extends State<ButtonEnviar> {
  final verificacaoProtocolo = VerificacaoProtocolo();
  final statusProtocolo = StatusProtocolo();
  final criacaoProtocolo = CriacaoProtocolo();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Theme.of(context).colorScheme.primary),
      onPressed: (() async {
        bool sucess = await verificacaoProtocolo.verificacaoForm(context);
        if (sucess) {
          bool ok = await criacaoProtocolo.criarProtocolo(context);
          statusProtocolo.protocoloExecutado(context, ok, false);
        }
      }),
      child: const Text(
        'Salvar',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
