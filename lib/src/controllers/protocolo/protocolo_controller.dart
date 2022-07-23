import 'dart:async';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/protocolo/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/login/login_controller.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/shared/models/typesWarnings.dart';

final typesWarning = TypesWarning();

class VerificacaoProtocolo {
  var listaItensDoVeiculo = criarProtocoloState.listaItensProtocolo.value;
  List<String> listaCheckIdLista = [];
  List<String> listaCheckIdVeiculo = [];
  bool sucess = false;

  Future<bool> verificacaoForm(BuildContext context) async {
    debugPrint('${criarProtocoloState.tamanhoVeiculo}');

    if (criarProtocoloState.motoristaSelecionado != 0) {
      List<ItensProtocolo> listaOrganizada = listaItensDoVeiculo;
      listaCheckIdLista.clear();
      listaCheckIdVeiculo.clear();
      for (var item in criarProtocoloState.tamanhoVeiculo) {
        debugPrint('Item tamanho veiculo ${item}');
        listaCheckIdLista.add(item.toString());
      }
      listaOrganizada.forEach((element) {
        if (element.valor != null) {
          listaCheckIdVeiculo.add(element.itemveiculo.toString());
        }
      });

      for (var item in listaCheckIdLista.reversed) {
        debugPrint('item checkidlista: ${item}');
        if (listaCheckIdVeiculo.contains(item)) {
          debugPrint('Tem na lista: ${item}');
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
        sucess = true;
      }
      return sucess;
    } else {
      typesWarning.showDanger(
          context, "Motorista não selecionado", "Escolha um motorista!");
      return sucess;
    }
  }
}

class CriacaoProtocolo {
  Future<bool> criarProtocolo(BuildContext context) async {
    typesWarning.showLoading(context);
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
        assinaturaInicial: assinaturaBase64));
    return sucess;
  }
}

class FinalizacaoProtocolo {
  Future<bool> finalizarProtocolo(BuildContext context, int id) async {
    typesWarning.showLoading(context);
    criarProtocoloState.mostraAssinaturaFeita = true;
    criarProtocoloState.bytesAssinatura.value =
        await criarProtocoloState.assinaturaController.toPngBytes();
    await Future.delayed(Duration(milliseconds: 500));
    String assinaturaBase64 = await criarProtocoloState.capture();
    bool sucess = await criarProtocoloState.novoProtocolo(Protocolo(
        id: id,
        assinaturaFinal: assinaturaBase64,
        digitadorFinal: loginControllerState.username,
        observacaoFinal: criarProtocoloState.obsTextController.text));
    return sucess;
  }
}

class StatusProtocolo {
  protocoloExecutado(BuildContext context, bool sucess, bool criarOuFinalizar) {
    Timer(Duration(seconds: 2), (() {
      if (sucess) {
        criarProtocoloState.bytesAssinatura.value = '';
        ArtSweetAlert.show(
            barrierDismissible: false,
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title:
                    '${criarOuFinalizar ? 'Protocolo finalizado' : 'Protocolo criado'}',
                confirmButtonText: 'OK',
                onConfirm: () {
                  [1, 2, 3].forEach((element) {
                    Navigator.pop(context);
                  });
                  criarProtocoloState.refreshPage();
                }));
      } else {
        ArtSweetAlert.show(
            barrierDismissible: false,
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: 'Algo deu errado',
                text:
                    'Verifique sua conexão e tente novamente, se o erro persistir consulte o departamento',
                confirmButtonText: 'OK',
                onConfirm: () {
                  [1, 2].forEach((element) {
                    Navigator.pop(context);
                  });
                }));
      }
    }));
  }
}
