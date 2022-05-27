import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';

class PesquisaBar extends StatefulWidget {
  PesquisaBar(
      {Key? key,
      required this.titulo,
      required this.lista,
      required this.sePessoa})
      : super(key: key);

  List<dynamic> lista;
  String titulo;
  bool sePessoa;
  @override
  State<PesquisaBar> createState() => _PesquisaBarState();
}

class _PesquisaBarState extends State<PesquisaBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 10))
          ]),
      child: CustomDropdown.search(
        controller: widget.sePessoa
            ? criarProtocoloState.motoristaSelecionar
            : criarProtocoloState.veiculoSelecionar,
        hintText: '${widget.titulo}',
        excludeSelected: false,
        items: widget.lista.map((e) {
          return widget.sePessoa ? e.nome.toString() : e.placa.toString();
        }).toList(),
        onChanged: (value) {
          widget.sePessoa
              ? widget.lista.forEach((element) {
                  if (element.nome == value) {
                    criarProtocoloState.changeMotoristaSelecionado(
                        int.parse(element.id.toString()));
                  }
                })
              : widget.lista.forEach((element) {
                  if (element.placa == value) {
                    criarProtocoloState.changeVeiculoSelecionado(element.id);
                  }
                });
        },
      ),
    );
  }
}
