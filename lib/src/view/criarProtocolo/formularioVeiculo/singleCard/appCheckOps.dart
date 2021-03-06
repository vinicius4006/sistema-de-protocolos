import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:protocolo_app/src/controllers/protocolo/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class CheckOps extends StatefulWidget {
  CheckOps({
    Key? key,
    required this.listaParametros,
    required this.numCat,
    required this.indexGlobal,
  }) : super(key: key);

  String listaParametros;
  int numCat;
  int indexGlobal;

  @override
  State<CheckOps> createState() => _CheckOpsState();
}

class _CheckOpsState extends State<CheckOps> {
  late List<String> listaProntaParamentros;
  List<int> checkSelect = [];
  List<bool> changeLista = [];
  List<Color> listColor = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var separateString =
        widget.listaParametros.replaceAll('[', ''); //Isso aqui pode mudar
    separateString = separateString.replaceAll(']', '');
    separateString = separateString.replaceAll('"', '');
    listaProntaParamentros = separateString.split(',');
  }

  @override
  void dispose() {
    log('Dispose CheckOps');
    super.dispose();
  }

  //Verifico e excluo do array
  void itemChange(bool val, int index) {
    setState(() {
      changeLista[index] = val;

      if (changeLista[index]) {
        checkSelect.add(index);
        criarProtocoloState.trocarCorCardInicial(widget.indexGlobal, context);
      } else {
        checkSelect.remove(index);
        if (checkSelect.isEmpty) {
          criarProtocoloState.trocarCordCardRed(widget.indexGlobal, context);
        }
      }
    });
    checkSelect.sort();
    if (checkSelect.isNotEmpty) {
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
          itemveiculo: widget.numCat, valor: checkSelect.toString()));
      //int.parse(checkSelect.reversed
      // .toString()
      // .replaceAll('(', '')
      // .replaceAll(')', '')
      // .split(',')
      //.join('')
      // .replaceAll(' ', ''))));
    } else {
      criarProtocoloState.addFormItensProtocolo(
          ItensProtocolo(itemveiculo: widget.numCat, valor: 111));
    }
  }

  @override
  Widget build(BuildContext context) {
    log('Build CheckOps');
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listaProntaParamentros.length,
        itemBuilder: (context, index) {
          changeLista.add(false);
          return Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listaProntaParamentros[index],
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GFCheckbox(
                    activeBgColor: listColor[index],
                    onChanged: (val) {
                      setState(() {
                        itemChange(val, index);
                      });
                    },
                    value: changeLista[index],
                    inactiveIcon: null,
                  ),
                ],
              ),
            ),
          );
          // return CheckboxListTile(
          //   title: Text(lista[index]),
          //   dense: true,
          //   value: changeLista[index],
          //   onChanged: (bool? val) {
          //     itemChange(val!, index);

          //     context
          //         .read<ProtocoloModelo>()
          //         .addFormItensProtocolo(widget.numCat, checkSelect, '', '');
          //   },
          // );
        });
  }
}
