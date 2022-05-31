import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/pessoa_motorista.dart';
import 'package:protocolo_app/src/shared/models/placas.dart';

class PesquisaBarra extends StatefulWidget {
  PesquisaBarra({Key? key, required this.boolSearch}) : super(key: key);

  bool boolSearch;

  @override
  State<PesquisaBarra> createState() => _PesquisaBarraState();
}

class _PesquisaBarraState extends State<PesquisaBarra> {
  String textoSelecionado(bool boolSearch) {
    return boolSearch ? 'Digite o motorista' : 'Digite a placa';
  }

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
                border: OutlineInputBorder(),
                hintText: textoSelecionado(widget.boolSearch)),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.length > 2) {
              await Future.delayed(Duration(milliseconds: 200));
              if (widget.boolSearch) {
                return await chamandoApiReqState.getPessoa(pattern);
              } else {
                return await chamandoApiReqState.getPlacas(pattern);
              }
            } else {
              return [];
            }
          },
          itemBuilder: (context, dynamic sugestao) {
            if (widget.boolSearch) {
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
          },
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
          onSuggestionSelected: (dynamic sugestao) {
            if (widget.boolSearch) {
              final pessoa = sugestao as Pessoa;
              criarProtocoloState.controllerMotorista.text = pessoa.nome!;
              criarProtocoloState
                  .changeMotoristaSelecionado(int.parse(pessoa.id!));
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text('Motorista selecionado: ${pessoa.nome}')));
            } else {
              final placa = sugestao as Placas;
              criarProtocoloState.controllerPlaca.text = placa.placa!;
              criarProtocoloState.changeVeiculoSelecionado(placa.id!);

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text('Placa selecionadaa: ${placa.placa}')));
            }
          }),
    );
  }
}
