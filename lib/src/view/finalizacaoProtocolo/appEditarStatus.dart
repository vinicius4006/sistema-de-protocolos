import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';

class EditarStatus extends StatefulWidget {
  EditarStatus(
      {Key? key,
      required this.listaItensVeiculos,
      required this.listaItens,
      required this.index})
      : super(key: key);
  List<ItensVeiculos> listaItensVeiculos;
  List<String> listaItens;
  int index;
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
    if (!widget.listaItens[widget.index].contains('[')) {
      // debugPrint('RADIOBUTTON: $index');
      // debugPrint(
      //     'Formato exibido RadioButton : ${listaItens[index].runtimeType}');
      return Text('Status: ' +
          widget.listaItensVeiculos[widget.index].parametros
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('"', '')
              .split(',')[int.parse(widget.listaItens[widget.index].toString())]
              .toString());
    } else {
      //checkbox
      //debugPrint('Formato exibido CheckBox : ${listaItens[index].runtimeType}');
      List<String> valorFinalEditadoExibir = [];
      List<String> valorEditadoParaExibir = widget
          .listaItensVeiculos[widget.index].parametros
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',');
      // debugPrint('ValorEditadoParaExibir: $valorEditadoParaExibir - $index');
      var listaItensCopia = (widget.listaItens[widget.index].substring(1))
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
      return Text('Status: ' +
          valorFinalEditadoExibir
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''));
    }
  }
}
