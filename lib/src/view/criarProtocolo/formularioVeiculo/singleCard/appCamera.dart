import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/card/card_controller.dart';

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
  late CameraController cameraController;
  @override
  void dispose() {
    debugPrint('Dispose Camera');
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraController = CameraController(
        indexGlobal: widget.indexGlobal, numCat: widget.numCat);
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
            cameraController.showCamera();
            //_showCamera();
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Escolha uma da galeria'),
          onTap: () {
            cameraController.showPhotoLibrary();
            //_showPhotoLibrary();
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
