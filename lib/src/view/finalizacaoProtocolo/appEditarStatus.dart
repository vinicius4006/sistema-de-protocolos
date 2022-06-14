import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class EditarStatus extends StatefulWidget {
  EditarStatus({
    Key? key,
    required this.itensVeiculos,
    required this.itensProtocolo,
    required this.indexGlobal,
  }) : super(key: key);
  ItensVeiculos itensVeiculos;
  List<ItensProtocolo> itensProtocolo;
  int indexGlobal;

  @override
  State<EditarStatus> createState() => _EditarStatusState();
}

class _EditarStatusState extends State<EditarStatus> {
  final List<int> listaCheck = [];
  late int opRadio;
  @override
  void dispose() {
    debugPrint('Dispose EditarStatus');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build EditarStatus');

    if (criarProtocoloState.listaInput[widget.indexGlobal] == 'radio') {
      widget.itensProtocolo.forEach((element) {
        if (element.itemveiculo == widget.itensVeiculos.id) {
          opRadio = element.valor;
        }
      });
      return Text('Status anterior: \n' +
          widget.itensVeiculos.parametros
              .toString()
              .replaceAll('{', '')
              .replaceAll('}', '')
              .replaceAll('"', '')
              .split(',')[opRadio]
              .toString());
    } else {
      widget.itensProtocolo.forEach((element) {
        if (element.itemveiculo == widget.itensVeiculos.id) {
          listaCheck.add(element.valor);
        }
      });

      //checkbox
      List<String> valorFinalEditado = [];

      List<String> valorEditadoParaExibir = widget.itensVeiculos.parametros
          .toString()
          .replaceAll('{', '')
          .replaceAll('}', '')
          .replaceAll('"', '')
          .split(',');

      List<int> listaItensCheck = listaCheck;

      listaItensCheck.forEach(
          (element) => valorFinalEditado.add(valorEditadoParaExibir[element]));

      return Text('Status anterior: \n' +
          valorFinalEditado.toString().replaceAll('[', '').replaceAll(']', ''));
    }
  }
}
