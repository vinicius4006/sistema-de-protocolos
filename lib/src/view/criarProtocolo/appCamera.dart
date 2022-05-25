import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class Camera extends StatefulWidget {
  Camera(
      {Key? key,
      required this.input,
      required this.numCat,
      required this.indexGlobal})
      : super(key: key);

  String input;
  int numCat;
  int indexGlobal;
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  void dispose() {
    debugPrint('Dispose Camera');
    super.dispose();
  }

  void _showPhotoLibrary() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file == null) return;

      criarProtocoloState.capturarPathFoto(file.path);
      criarProtocoloState.trocarButton(widget.indexGlobal, true);
      List<int> imageBytes =
          io.File(criarProtocoloState.foto.value).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
        imagem: base64Image,
        itemveiculo: widget.numCat,
      ));
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

      criarProtocoloState.capturarPathFoto(file.path);
      criarProtocoloState.trocarButton(widget.indexGlobal, true);
      List<int> imageBytes =
          io.File(criarProtocoloState.foto.value).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
        imagem: base64Image,
        itemveiculo: widget.numCat,
      ));
    } catch (e) {
      print('Falha em capturar a imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Camera');
    return SizedBox(
      height: 140,
      child: Column(children: <Widget>[
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text('Tire a foto com a câmera'),
          onTap: () {
            _showCamera();
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Escolha uma da galeria'),
          onTap: () {
            _showPhotoLibrary();
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
