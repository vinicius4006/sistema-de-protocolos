import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:protocolo_app/src/controllers/protocolo/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/protocolo/pesquisaBarra_controller.dart';
import 'package:protocolo_app/src/shared/models/typesWarnings.dart';

class PesquisaBarra extends StatefulWidget {
  PesquisaBarra({Key? key, required this.boolSearch}) : super(key: key);

  bool boolSearch;

  @override
  State<PesquisaBarra> createState() => _PesquisaBarraState();
}

class _PesquisaBarraState extends State<PesquisaBarra> {
  final typesWarning = TypesWarning();
  final pesquisaBarra = PesquisaBarraController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(32),
        child: TypeAheadField(
            debounceDuration: Duration(milliseconds: 500),
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.boolSearch
                  ? criarProtocoloState.controllerMotorista
                  : criarProtocoloState.controllerPlaca,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: pesquisaBarra.textoSelecionado(widget.boolSearch)),
            ),
            suggestionsCallback: ((pattern) async => await pesquisaBarra
                .suggestionsCallback(pattern, widget.boolSearch)),
            itemBuilder: (context, dynamic sugestao) =>
                pesquisaBarra.itemBuilder(sugestao, widget.boolSearch),
            noItemsFoundBuilder: (context) => Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      'Não encontramos',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
            keepSuggestionsOnSuggestionSelected: false,
            onSuggestionSelected: (dynamic sugestao) =>
                pesquisaBarra.onSuggestionSelected(
                  sugestao,
                  widget.boolSearch,
                  context,
                )));
  }
}
