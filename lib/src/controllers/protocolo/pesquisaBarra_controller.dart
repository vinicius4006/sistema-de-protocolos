import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/api/Api_controller.dart';
import 'package:protocolo_app/src/controllers/protocolo/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/protocolo/protocolo_controller.dart';
import 'package:protocolo_app/src/shared/models/pessoa_motorista.dart';
import 'package:protocolo_app/src/shared/models/placas.dart';

class PesquisaBarraController {
  String textoSelecionado(bool boolSearch) {
    return boolSearch ? 'Digite o motorista' : 'Digite a placa';
  }

  suggestionsCallback(String pattern, bool boolSearch) async {
    if (pattern.length > 2) {
      await Future.delayed(Duration(milliseconds: 200));
      bool check = await chamandoApiReqState.verificarConexao();
      if (boolSearch) {
        return check
            ? await chamandoApiReqState.getPessoa(pattern)
            : [Pessoa(nome: 'Sem conexão')];
      } else {
        return check
            ? await chamandoApiReqState.getPlacas(pattern)
            : [Placas(placa: 'Sem conexão')];
      }
    } else {
      return [];
    }
  }

  itemBuilder(sugestao, bool boolSearch) {
    if (boolSearch) {
      final pessoa = sugestao as Pessoa;
      return ListTile(
        title: Text(pessoa.nome!),
      );
    } else {
      final placa = sugestao as Placas;
      return ListTile(
        title: Text(placa.placa!),
      );
    }
  }

  onSuggestionSelected(sugestao, bool boolSearch, BuildContext context) async {
    if (await chamandoApiReqState.verificarConexao()) {
      if (boolSearch) {
        final pessoa = sugestao as Pessoa;
        if (pessoa.nome != 'Houve algum problema') {
          criarProtocoloState.controllerMotorista.text = pessoa.nome!;
          criarProtocoloState.changeMotoristaSelecionado(int.parse(pessoa.id!));
        }
      } else {
        final placa = sugestao as Placas;
        if (placa.placa != 'Houve algum problema') {
          criarProtocoloState.controllerPlaca.text = placa.placa!;
          criarProtocoloState.changeVeiculoSelecionado(
              placa.id!, placa.observacaoFinal.toString());
        }
      }
    } else {
      typesWarning.showWarning(
          context, "Sem conexão", "Verifique se está devidamente conectado");
    }
  }
}
