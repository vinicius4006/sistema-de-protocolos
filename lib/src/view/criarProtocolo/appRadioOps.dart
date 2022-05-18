import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class RadioOps extends StatefulWidget {
  RadioOps({Key? key, required this.listaParametros, required this.numCat})
      : super(key: key);

  String listaParametros;
  String numCat;
  @override
  State<RadioOps> createState() => _RadioOpsState();
}

class _RadioOpsState extends State<RadioOps> {
  late List<String> listaProntaParamentros;
  late int select;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var separateString =
        widget.listaParametros.replaceAll('[', ''); //Isso aqui pode mudar
    separateString = separateString.replaceAll(']', '');
    separateString = separateString.replaceAll('"', '');
    listaProntaParamentros = separateString.split(',');
    select = -1;
  }

  @override
  void dispose() {
    log('Dispose RadioOps');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Build RadioOps');
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listaProntaParamentros.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 10, 8),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: RadioListTile(
              title: Text(
                listaProntaParamentros[index],
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
              activeColor: Theme.of(context).primaryColor,
              value: index,
              groupValue: select,
              onChanged: (value) {
                criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
                    imagem: '',
                    inicio: 't',
                    itemveiculo: widget.numCat,
                    valor: (value as int).toString()));
                setState(() {
                  select = value;
                });
              },
            ),
          );
        });
  }
}
