import 'dart:convert';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class ButtonFinalizar extends StatefulWidget {
  ButtonFinalizar({Key? key, required this.tipoVeiculo, required this.id})
      : super(key: key);
  int tipoVeiculo;
  int id;
  @override
  State<ButtonFinalizar> createState() => _ButtonFinalizarState();
}

class _ButtonFinalizarState extends State<ButtonFinalizar> {
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
      String assinaturaFinal = await criarProtocoloState
          .assinaturaController.value
          .toPngBytes()
          .then((value) {
        final Uint8List data = value!;
        String base64Image = base64Encode(data);
        return base64Image;
      });
      bool checkToken = await loginControllerState.verificarAssinaturaDaToken();
      if (checkToken) {
        criarProtocoloState.novoProtocolo(Protocolo(
            id: widget.id,
            assinaturaFinal: assinaturaFinal,
            digitadorFinal: loginControllerState.username));
        Navigator.pop(context);

        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success, title: "Finalizado!"));
        return;
      } else {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Usuário e senha negados",
                text: "Parece que há problemas com os seus dados!"));
      }
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
        var tamanhoVeiculo =
            await criarProtocoloState.dadosDoTipo(widget.tipoVeiculo, context);
        var listaItensDoVeiculo = criarProtocoloState.listaItensProtocolo.value;
        List<ItensProtocolo> listaOrganizada = listaItensDoVeiculo;
        List<String> listaCheckIdLista = [];
        List<String> listaCheckIdVeiculo = [];
        for (var item in tamanhoVeiculo) {
          listaCheckIdLista.add(item['id']);
        }
        listaOrganizada.forEach((element) {
          if (element.valor != null) {
            listaCheckIdVeiculo.add(element.itemveiculo.toString());
          }
        });

        for (var item in listaCheckIdLista.reversed) {
          if (listaCheckIdVeiculo.contains(item)) {
            debugPrint('True');
          } else {
            criarProtocoloState.scrollTo(
                listaCheckIdLista.indexOf(item), context);
          }
        }

        if (criarProtocoloState.assinaturaController.value.isEmpty) {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Não esqueça sua assinatura",
              ));
        }

        if (listaCheckIdVeiculo.length == listaCheckIdLista.length &&
            criarProtocoloState.assinaturaController.value.isNotEmpty) {
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
