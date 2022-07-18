import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';

class ButtonEnviar extends StatefulWidget {
  const ButtonEnviar({Key? key}) : super(key: key);

  @override
  State<ButtonEnviar> createState() => _ButtonEnviarState();
}

class _ButtonEnviarState extends State<ButtonEnviar> {
  verificacaoForm() async {
    var listaItensDoVeiculo = criarProtocoloState.listaItensProtocolo.value;

    if (criarProtocoloState.formKey.currentState!.validate() &&
        criarProtocoloState.motoristaSelecionado != 0) {
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
        if (!listaCheckIdVeiculo.contains(item)) {
          criarProtocoloState.scrollTo(
              listaCheckIdLista.indexOf(item), context);
        }
      }

      if (criarProtocoloState.assinaturaController.value.isEmpty) {
        criarProtocoloState.colorAssinatura.value = Colors.red;
      }

      if (listaItensDoVeiculo.length ==
              criarProtocoloState.tamanhoVeiculo.length &&
          criarProtocoloState.assinaturaController.value.isNotEmpty) {
        if (await chamandoApiReqState.verificarConexao()) {
          bool checkToken =
              await loginControllerState.verificarAssinaturaDaToken();
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

            bool sucess = await criarProtocoloState.novoProtocolo(Protocolo(
                        veiculo: criarProtocoloState.veiculoSelecionado.value,
                        motorista: criarProtocoloState.motoristaSelecionado,
                        digitador: loginControllerState.username,
                        observacao: criarProtocoloState.obsTextController.text,
                        assinaturaInicial: assinaturaBase64)) ==
                    null
                ? false
                : true;
            if (sucess) {
              Timer(Duration(seconds: 2), (() {
                criarProtocoloState.bytesAssinatura.value = '';
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.success,
                        title: 'Protocolo Criado',
                        confirmButtonText: 'OK',
                        onConfirm: () {
                          [1, 2, 3].forEach((element) {
                            Navigator.pop(context);
                          });
                          criarProtocoloState.refreshPage();
                        }));
              }));
            } else {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: 'Algo deu errado!',
                    text:
                        'Não conseguimos salvar seu protocolo, verifique e tente novamente',
                    confirmButtonText: 'OK',
                  ));
            }
          } else {
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "Usuário e senha negados",
                    text: "Parece que há problemas com os seus dados!"));
          }
        } else {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.warning,
                  title: "Sem conexão",
                  text: "Verifique se está devidamente conectado"));
        }
      }
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Motorista não selecionado",
              text: "Escolha um motorista!"));
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
      onPressed: (() async {
        try {
          verificacaoForm();
        } catch (e) {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Ocorreu algum problema...",
              ));
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
