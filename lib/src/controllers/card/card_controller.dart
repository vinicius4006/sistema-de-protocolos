import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:protocolo_app/src/controllers/protocolo/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class CameraController {
  int? indexGlobal;
  int? numCat;
  CameraController({this.indexGlobal, this.numCat});

  void showPhotoLibrary() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file == null) return;

      criarProtocoloState.capturarPathFoto(file.path);
      criarProtocoloState.trocarButton(this.indexGlobal!, true);
      List<int> imageBytes =
          io.File(criarProtocoloState.foto.value).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
        imagem: base64Image,
        itemveiculo: this.numCat,
      ));
    } catch (e) {
      print('Falha em pegar a imagem: $e');
    }
  }

  void showCamera() async {
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 480,
        imageQuality: 90,
      );

      if (file == null) return;

      criarProtocoloState.capturarPathFoto(file.path);
      criarProtocoloState.trocarButton(this.indexGlobal!, true);
      List<int> imageBytes =
          io.File(criarProtocoloState.foto.value).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
        imagem: base64Image,
        itemveiculo: this.numCat,
      ));
    } catch (e) {
      print('Falha em capturar a imagem: $e');
    }
  }
}
