import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../controllers/startProtocolo_controller.dart';
import 'package:getwidget/getwidget.dart';

class CardForm extends StatefulWidget {
   CardForm(
      {Key? key,
      required this.title,
      required this.ops,
      required this.input,
      required this.color,
      required this.indexGlobal,
      this.numCat = ''})
      : super(key: key);

  final String title;
  final String ops;
  final String input;
  final String numCat;
  final int indexGlobal;
   Color color;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  int select = -1;
  int indexRadio = 0;
  List<int> checkSelect = [];
  List<bool> changeLista = [false];
  int num = 3;
  List<Color> listColor = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange
  ];

  @override
  void initState() {
    super.initState();

    context.read<ProtocoloModelo>().listaItensProtocolo.clear();
  }

  @override
  void dispose() {
    checkSelect;
    changeLista;
    super.dispose();
  }

  String? _path;

  //---------------------CAMERA

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 150,
            child: Column(children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Tire a foto com a câmera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolha uma da galeria'),
                onTap: () {
                  Navigator.pop(context);
                  _showPhotoLibrary();
                },
              )
            ]),
          );
        });
  }

  void _showPhotoLibrary() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file == null) return;

      setState(() {
        _path = file.path;
      });
    } catch (e) {
      print('Falha em pegar a imagem: $e');
    }
  }

  void _showCamera() async {
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 480,
        imageQuality: 90,
      );

      if (file == null) return;

      setState(() {
        _path = file.path;
      });
    } catch (e) {
      print('Falha em capturar a imagem: $e');
    }
  }

  _showPhoto(BuildContext context, String input) {
    List<int> imageBytes = io.File(_path!).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    if (input == 'radio') {
      Timer(const Duration(seconds: 1), () async {
        context.read<ProtocoloModelo>().addFormItensProtocolo(
            widget.numCat,
            indexRadio,
            context.read<ProtocoloModelo>().inicioIsFalse ? 'f' : 't',
            base64Image);
      });
    } else {
      Timer(const Duration(seconds: 1), () async {
        context.read<ProtocoloModelo>().addFormItensProtocolo(
            widget.numCat,
            checkSelect,
            context.read<ProtocoloModelo>().inicioIsFalse ? 'f' : 't',
            base64Image);
      });
    }

    return Column(
      children: [
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _path = null;
                if (input == 'radio') {
                  Timer(const Duration(seconds: 1), () async {
                    context.read<ProtocoloModelo>().addFormItensProtocolo(
                        widget.numCat,
                        indexRadio,
                        context.watch<ProtocoloModelo>().inicioIsFalse
                            ? 'f'
                            : 't',
                        '');
                  });
                } else {
                  Timer(const Duration(seconds: 1), () async {
                    context.read<ProtocoloModelo>().addFormItensProtocolo(
                        widget.numCat,
                        checkSelect,
                        context.watch<ProtocoloModelo>().inicioIsFalse
                            ? 'f'
                            : 't',
                        '');
                  });
                }
              });
            },
            icon: const Icon(Icons.delete),
            label: const Text('Excluir Foto')),
        Image.file(
          io.File(_path.toString()),
        ),
      ],
    );
  }

  //-------------------------------EXIBICAO RADIO OU CHECKBOX

  //--------------------RADIOBUTTON
  showRadioOps(List<String> lista) {
    //verificação para limpar quando trocar o numero da placa
    if (context.read<ProtocoloModelo>().selectRadioVerificacao == -1) {
      select = -1;
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 10, 8),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: RadioListTile(
              title: Text(
                lista[index],
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
              activeColor: Theme.of(context).primaryColor,
              value: index,
              groupValue: select,
              onChanged: (value) {
                //debugPrint('Mostrar Primeiro: $value');
                setState(() {
                  select = int.parse(value.toString());
                  context.read<ProtocoloModelo>().selectRadioVerificacao =
                      select;
                  indexRadio = index;
                 
                    context.read<ProtocoloModelo>().listaDeCoresCheck[widget.indexGlobal] = Colors.green;
                    widget.color = Colors.green;
                  
                });
                context.read<ProtocoloModelo>().addFormItensProtocolo(
                    widget.numCat,
                    index,
                    context.read<ProtocoloModelo>().inicioIsFalse ? 'f' : 't',
                    '');
              },
            ),
          );
        });
  }

  //----------------------CHECKBOX
  showCheckOps(List<String> lista) {
    //verificação para limpar quando trocar o numero da placa
    if (!context
        .read<ProtocoloModelo>()
        .changeListaVerificacao
        .contains(true)) {
      changeLista = [false];
      checkSelect.clear();
    }

    //Verifico e excluo do array
    void itemChange(bool val, int index) {
      setState(() {
        changeLista[index] = val;
        context.read<ProtocoloModelo>().changeListaVerificacao[index] = val;
        if (changeLista[index]) {
          checkSelect.add(index);
          context.read<ProtocoloModelo>().listaDeCoresCheck[widget.indexGlobal] = Colors.green;
                    widget.color = Colors.green;
        } else {
          checkSelect.remove(index);
          if(checkSelect.isEmpty){
            context.read<ProtocoloModelo>().listaDeCoresCheck[widget.indexGlobal] = Colors.red;
                    widget.color = Colors.red;
          }
        }
      });
      context.read<ProtocoloModelo>().addFormItensProtocolo(
          widget.numCat,
          checkSelect,
          context.read<ProtocoloModelo>().inicioIsFalse ? 'f' : 't',
          '');
    }

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          changeLista.add(false);
          context.read<ProtocoloModelo>().changeListaVerificacao.add(false);
          return Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lista[index],
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor),
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

  //---------------------CORPO DO CARD
  @override
  Widget build(BuildContext context) {
    //-----------SEPARACAO DO PARAMETRO PARA FICAR LEGIVEL
    var separateString = widget.ops.replaceAll('[', '');
    separateString = separateString.replaceAll(']', '');
    separateString = separateString.replaceAll('"', '');

    var listaParametros = separateString.split(',');

    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 8,
        color: Colors.grey[100],
        shadowColor: Theme.of(context).primaryColor,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: widget.color,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: widget.input == 'radio'
                    ? showRadioOps(listaParametros)
                    : showCheckOps(listaParametros)),
            _path != null ? _showPhoto(context, widget.input) : const Text(''),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: Theme.of(context).primaryColor),
                onPressed: (() {
                  _showOptions(context);
                }),
                child: const Text(
                  'Tire a Foto',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
   
  }
}
