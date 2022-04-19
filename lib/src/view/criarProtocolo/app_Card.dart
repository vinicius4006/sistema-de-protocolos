import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:provider/provider.dart';

class CardForm extends StatefulWidget {
  const CardForm({
    Key? key,
    required this.title,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
  }) : super(key: key);

  final String title;
  final String op1;
  final String op2;
  final String op3;
  final String op4;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  List<String> selected = [];
  String? _path;

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
      final file = await ImagePicker().pickImage(source: ImageSource.camera);

      if (file == null) return;

      setState(() {
        _path = file.path;
      });
      debugPrint('$_path');
    } catch (e) {
      print('Falha em capturar a imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            title: Text(widget.title),
            subtitle: const Text('Status'),
          ),
          Container(
            child: DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  selected = x;
                  context.read<ProtocoloModelo>().addFormItens(
                      ((widget.title).toLowerCase() + 'Status')
                          .replaceAll(' ', ''),
                      selected,
                      _path.toString());
                });
              },
              options: [widget.op1, widget.op2, widget.op3, widget.op4],
              selectedValues: selected,
              whenEmpty: 'Selecione a opção',
            ),
          ),
          _path != null
              ? Image.file(
                  io.File(_path.toString()),
                )
              : const Text('Aguardando...'),
          ElevatedButton(
            onPressed: () {
              _showOptions(context);
            },
            child: const Text(
              'Tire a foto',
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
