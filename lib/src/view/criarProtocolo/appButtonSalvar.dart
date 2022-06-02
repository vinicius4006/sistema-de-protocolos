import 'dart:convert';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
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
    var tamanhoVeiculo = await chamandoApiReqState
        .retornarSeMotoOuCarro(criarProtocoloState.veiculoSelecionado.value);

    var listaItensDoVeiculo = criarProtocoloState.listaItensProtocolo.value;

    if (criarProtocoloState.formKey.currentState!.validate()) {
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
        criarProtocoloState.colorAssinatura.value = Colors.red;
      }

      if (listaItensDoVeiculo.length == tamanhoVeiculo.length &&
          criarProtocoloState.assinaturaController.value.isNotEmpty) {
        bool checkToken =
            await loginControllerState.verificarAssinaturaDaToken();
        if (checkToken) {
          String assinaturaInicial = await criarProtocoloState
              .assinaturaController
              .toPngBytes()
              .then((value) {
            final Uint8List data = value!;
            String base64Image = base64Encode(data);
            return base64Image;
          });

          criarProtocoloState.novoProtocolo(Protocolo(
              veiculo: criarProtocoloState.veiculoSelecionado.value,
              motorista: criarProtocoloState.motoristaSelecionado,
              digitador: loginControllerState.username,
              assinaturaInicial: assinaturaInicial));
          Navigator.of(context).pop();

          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: 'Protocolo Criado',
              ));
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
