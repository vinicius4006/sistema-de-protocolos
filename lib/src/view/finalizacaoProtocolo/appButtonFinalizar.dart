import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';
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
      bool checkToken = await loginControllerState.verificarAssinaturaDaToken();
      if (checkToken) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                    size: 80,
                    color: Colors.orange,
                    secondRingColor: Colors.green,
                    thirdRingColor: Colors.indigo),
              );
            });
        criarProtocoloState.mostraAssinaturaFeita = true;
        criarProtocoloState.bytesAssinatura.value =
            await criarProtocoloState.assinaturaController.toPngBytes();
        await Future.delayed(Duration(milliseconds: 500));
        String assinaturaBase64 = await criarProtocoloState.capture();
        criarProtocoloState.novoProtocolo(Protocolo(
            id: widget.id,
            assinaturaFinal: assinaturaBase64,
            digitadorFinal: loginControllerState.username,
            observacaoFinal: criarProtocoloState.obsTextController.text));

        Timer(Duration(seconds: 2), (() {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.success,
                  title: 'Finalizado!',
                  confirmButtonText: 'OK',
                  onConfirm: () {
                    [1, 2, 3].forEach((element) {
                      Navigator.pop(context);
                    });
                    criarProtocoloState.refreshPage();
                  }));
        }));

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
        var listaItensDoVeiculo = criarProtocoloState.listaItensProtocolo.value;
        List<ItensProtocolo> listaOrganizada = listaItensDoVeiculo;
        List<String> listaCheckIdLista = [];
        List<String> listaCheckIdVeiculo = [];
        for (var item in criarProtocoloState.tamanhoVeiculo) {
          listaCheckIdLista.add(item.toString());
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
          criarProtocoloState.colorAssinatura.value = Colors.red;
        }

        if (listaCheckIdVeiculo.length == listaCheckIdLista.length &&
            criarProtocoloState.assinaturaController.value.isNotEmpty) {
          if (await chamandoApiReqState.verificarConexao()) {
            showConfirmDialog(context);
          } else {
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.warning,
                    title: "Sem conexão",
                    text: "Verifique se está devidamente conectado"));
          }
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
