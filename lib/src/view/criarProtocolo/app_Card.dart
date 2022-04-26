import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../controllers/protocolo_controllerl.dart';

class CardForm extends StatefulWidget {
  const CardForm(
      {Key? key,
      required this.title,
      required this.ops,
      required this.input,
      this.numCat = 0,
      this.classificacao = false})
      : super(key: key);

  final String title;
  final String ops;
  final String input;
  final int numCat;
  final bool classificacao;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  String select = '';
  List<String> checkSelect = [];
  List<bool> changeLista = [false];

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
      debugPrint('$_path');
    } catch (e) {
      print('Falha em capturar a imagem: $e');
    }
  }

  _showPhoto(BuildContext context) {
    List<int> imageBytes = io.File(_path!).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    if (widget.classificacao) {
      Timer(const Duration(seconds: 1), () async {
        context
            .read<ProtocoloModelo>()
            .addFormItens(widget.numCat, [select], base64Image, true);
      });
    } else {
      Timer(
          const Duration(seconds: 1),
          () => context
              .read<ProtocoloModelo>()
              .addFormItens(widget.numCat, [select], base64Image, false));
    }

    return Image.file(
      io.File(_path.toString()),
    );
  }

  //-------------------------------EXIBICAO RADIO OU CHECKBOX

  //--------------------RADIOBUTTON
  showRadioOps(List<String> lista) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(lista[index]),
            value: lista[index],
            groupValue: select,
            onChanged: (value) {
              setState(() {
                debugPrint('$value');
                select = value.toString();
                context.read<ProtocoloModelo>().addFormItens(
                    widget.numCat, [select], '', widget.classificacao);
              });
            },
          );
        });
  }

  //----------------------CHECKBOX
  showCheckOps(List<String> lista) {
    void itemChange(bool val, int index) {
      setState(() {
        changeLista[index] = val;
        if (changeLista[index]) {
          checkSelect.add(lista[index]);
        } else {
          checkSelect.remove(lista[index]);
        }
        context
            .read<ProtocoloModelo>()
            .addFormItens(widget.numCat, checkSelect, '', widget.classificacao);

        debugPrint('$checkSelect');
      });
    }

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          changeLista.add(false);
          return Form(
            child: CheckboxListTile(
              title: Text(lista[index]),
              dense: true,
              value: changeLista[index],
              onChanged: (bool? val) {
                itemChange(val!, index);
              },
            ),
          );
        });
  }

  //---------------------CORPO DO CARD
  @override
  Widget build(BuildContext context) {
    //-----------SEPARACAO DO PARAMETRO PARA FICAR LEGIVEL
    var separateString = widget.ops.replaceAll('[', '');
    separateString = separateString.replaceAll(']', '');
    separateString = separateString.replaceAll('"', '');

    final listaParametros = separateString.split(',');

    return SafeArea(
      child: Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            title: Text(widget.title),
            subtitle: const Text('Status'),
          ),
          Container(
              child: widget.input == 'radio'
                  ? showRadioOps(listaParametros)
                  : showCheckOps(listaParametros)),
          _path != null ? _showPhoto(context) : const Text('Aguardando...'),
          ElevatedButton(
            onPressed: () {
              _showOptions(context);
            },
            child: const Text(
              'Tire a foto',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
