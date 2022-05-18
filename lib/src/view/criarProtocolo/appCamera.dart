import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class Camera extends StatefulWidget {
  Camera({Key? key, required this.input, required this.numCat})
      : super(key: key);

  String input;
  String numCat;
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
      List<int> imageBytes =
          io.File(criarProtocoloState.foto.value).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
          imagem: base64Image,
          inicio: 't',
          itemveiculo: widget.numCat,
          valor: ''));
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
      List<int> imageBytes =
          io.File(criarProtocoloState.foto.value).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      criarProtocoloState.addFormItensProtocolo(ItensProtocolo(
          imagem: base64Image,
          inicio: 't',
          itemveiculo: widget.numCat,
          valor: ''));
    } catch (e) {
      print('Falha em capturar a imagem: $e');
    }
  }

  _showPhoto() {
    return ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(title: "Foto tirada", customColumns: [
          Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Image.file(
              io.File(criarProtocoloState.foto.value.toString()),
            ),
          )
        ]));
    // return showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return Column(
    //         children: [
    //           ElevatedButton.icon(
    //               onPressed: () {
    //                 setState(() {
    //                   //_path = null;
    //                   // if (input == 'radio') {
    //                   //   Timer(const Duration(seconds: 1), () async {
    //                   //     context.read<ProtocoloModelo>().addFormItensProtocolo(
    //                   //         widget.numCat,
    //                   //         indexRadio,
    //                   //         context.watch<ProtocoloModelo>().inicioIsFalse
    //                   //             ? 'f'
    //                   //             : 't',
    //                   //         '');
    //                   //   });
    //                   // } else {
    //                   //   Timer(const Duration(seconds: 1), () async {
    //                   //     context.read<ProtocoloModelo>().addFormItensProtocolo(
    //                   //         widget.numCat,
    //                   //         checkSelect,
    //                   //         context.watch<ProtocoloModelo>().inicioIsFalse
    //                   //             ? 'f'
    //                   //             : 't',
    //                   //         '');
    //                   //   });
    //                   // }
    //                 });
    //               },
    //               icon: const Icon(Icons.delete),
    //               label: const Text('Excluir Foto')),
    //           Image.file(
    //             io.File(criarProtocoloState.foto.value.toString()),
    //           ),
    //         ],
    //       );
    //     });
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
