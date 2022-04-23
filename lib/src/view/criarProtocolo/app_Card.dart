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
      required this.op1,
      required this.op2,
      required this.op3,
      required this.op4,
      this.numCat = 0,
      this.classificacao = ''})
      : super(key: key);

  final String title;
  final String op1;
  final String op2;
  final String op3;
  final String op4;
  final int numCat;
  final String classificacao;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  List<String> selected = [];
  bool selectedChange = false;
  int rangeRemove = 0;

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
    //  developer.log(
    //    'log me',
    //    name: 'my.app.photo',
    //    error: jsonEncode(base64Image),
    //  );
    if (widget.classificacao == context.read<ProtocoloModelo>().titleMoto) {
      Timer(const Duration(seconds: 1), () async {
        context
            .read<ProtocoloModelo>()
            .addFormItens(widget.numCat, selected, base64Image, true);
      });
    } else {
      Timer(
          const Duration(seconds: 1),
          () => context
              .read<ProtocoloModelo>()
              .addFormItens(widget.numCat, selected, base64Image, false));
    }

    return Image.file(
      io.File(_path.toString()),
    );
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

          )

          // child: DropDownMultiSelect(
          //   onChanged: (List<String> x) {
          //     setState(() {
          //       selected = x;
          //     });
          //     //final boolChange = selected.remove(base64Encode(io.File(_path.toString()).readAsBytesSync()));
          //   },
          //   options: [widget.op1, widget.op2, widget.op3, widget.op4],
          //   selectedValues: selected,
          //   whenEmpty: 'Selecione a opção',
          // ),
          ,
          _path != null ? _showPhoto(context) : const Text('Aguardando...'),
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
