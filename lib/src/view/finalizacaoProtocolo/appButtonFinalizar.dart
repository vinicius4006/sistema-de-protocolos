import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/protocolo/protocolo_controller.dart';

class ButtonFinalizar extends StatefulWidget {
  ButtonFinalizar({Key? key, required this.tipoVeiculo, required this.id})
      : super(key: key);
  int tipoVeiculo;
  int id;
  @override
  State<ButtonFinalizar> createState() => _ButtonFinalizarState();
}

class _ButtonFinalizarState extends State<ButtonFinalizar> {
  final verificacaoProtocolo = VerificacaoProtocolo();
  final statusProtocolo = StatusProtocolo();
  final finalizacaoProtocolo = FinalizacaoProtocolo();
  showConfirmDialog(BuildContext context) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancelar",
            title: "Tem certeza que deseja finalizar?",
            text: "Se houver dúvidas verifique os dados novamente",
            confirmButtonText: "Sim, quero finalizar",
            type: ArtSweetAlertType.warning));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      bool ok =
          await finalizacaoProtocolo.finalizarProtocolo(context, widget.id);

      statusProtocolo.protocoloExecutado(context, ok, true);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Theme.of(context).colorScheme.primary),
      onPressed: () async {
        bool sucess = await verificacaoProtocolo.verificacaoForm(context);
        if (sucess) {
          showConfirmDialog(context);
        }
      },
      child: const Text(
        'Finalizar',
        style: TextStyle(
            color: Color.fromARGB(255, 249, 249, 249),
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}
