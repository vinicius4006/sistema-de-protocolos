import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class EditarStatus extends StatefulWidget {
  EditarStatus(
      {Key? key, required this.itensVeiculos, required this.itensProtocolo
      // required this.listaItens,
      // required this.index
      })
      : super(key: key);
  ItensVeiculos itensVeiculos;
  ItensProtocolo itensProtocolo;

  // int index;
  @override
  State<EditarStatus> createState() => _EditarStatusState();
}

class _EditarStatusState extends State<EditarStatus> {
  @override
  void dispose() {
    debugPrint('Dispose EditarStatus');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build EditarStatus');
    if (!widget.itensProtocolo.valor!.contains('[')) {
      // debugPrint('RADIOBUTTON: $index');
      // debugPrint(
      //     'Formato exibido RadioButton : ${listaItens[index].runtimeType}');
      return Text('Status anterior: \n' +
          widget.itensVeiculos.parametros
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('{', '')
              .replaceAll('}', '')
              .replaceAll('"', '')
              .split(',')[int.parse(widget.itensProtocolo.valor.toString())]
              .toString());
    } else {
      //checkbox
      //debugPrint('Formato exibido CheckBox : ${listaItens[index].runtimeType}');
      List<String> valorFinalEditadoExibir = [];
      List<String> valorEditadoParaExibir = widget.itensVeiculos.parametros
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',');
      // debugPrint('ValorEditadoParaExibir: $valorEditadoParaExibir - $index');
      var listaItensCopia = (widget.itensProtocolo.valor!.substring(2))
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .replaceAll(',', '');
      var listaModificadaEditada = listaItensCopia.split('');
      //debugPrint(
      //  'ListaModificadaEditada: $index - $listaModificadaEditada - ${listaModificadaEditada.length}');
      for (String item in listaModificadaEditada) {
        valorFinalEditadoExibir.add(valorEditadoParaExibir[int.parse(item)]);
      }
      //debugPrint('Exibindo: $valorFinalEditadoExibir');
      return Text('Status anterior: \n' +
          valorFinalEditadoExibir
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''));
    }
  }
}
