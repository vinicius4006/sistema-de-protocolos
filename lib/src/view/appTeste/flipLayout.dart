import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Assinatura.dart';

class TesteWidget extends StatefulWidget {
  const TesteWidget({Key? key}) : super(key: key);

  @override
  State<TesteWidget> createState() => _TesteWidgetState();
}

class _TesteWidgetState extends State<TesteWidget> {
  var dataImg;
  bool hasInternet = false;
  GlobalKey keyImage = GlobalKey();

  Widget buildSwapOrientation() {
    var ori = MediaQuery.of(context).orientation;
    if (ori == Orientation.landscape) {
      debugPrint('landscpae');
    } else {
      debugPrint('portrait');
    }
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;
        setOrientation(newOrientation);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            isPortrait
                ? Icons.screen_lock_portrait
                : Icons.screen_lock_landscape,
            size: 40,
          ),
          Text(
            'Toque para mudar',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
  }

  capture() async {
    if (keyImage == null) {}
    RenderRepaintBoundary boundary =
        keyImage.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  mandarImg(dataImg) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 320,
          height: 150,
          color: Color(0x00000000),
        ),
        RepaintBoundary(
          key: keyImage,
          child: Image.memory(
            dataImg!,
            width: 320,
            height: 150,
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TesteWidget')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    hasInternet =
                        await InternetConnectionChecker().hasConnection;
                    debugPrint('Tem: ${hasInternet}');
                    // var exportedPoints =
                    //     criarProtocoloState.assinaturaController.points;

                    // final SignatureController exportAssinatura =
                    //     SignatureController(points: exportedPoints);

                    // final Uint8List? data = await exportAssinatura.toPngBytes();

                    // setState(() {
                    //   dataImg = data;
                    // });
                    // Timer(Duration(seconds: 1), () async {
                    //   var bytes = await capture();
                    //   String base64 = base64Encode(bytes);
                    // });
                  },
                  child: Text('Testando')),
              Assinatura(),
              buildSwapOrientation(),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: dataImg == null ? Container() : mandarImg(dataImg))
            ],
          ),
        ),
      ),
    );
  }
}
