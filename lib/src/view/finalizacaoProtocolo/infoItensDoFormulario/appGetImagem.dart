import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GetImagemBase64 extends StatefulWidget {
  GetImagemBase64({Key? key, required this.imagem64}) : super(key: key);
  String imagem64;

  @override
  State<GetImagemBase64> createState() => _GetImagemBase64State();
}

class _GetImagemBase64State extends State<GetImagemBase64> {
  @override
  void dispose() {
    debugPrint('Dispose GetImagemBase64');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build GetImagemBase64');
    if (widget.imagem64.isEmpty || widget.imagem64 == '') {
      return Text('Não há imagem');
    } else if (widget.imagem64 == 'wait') {
      return LoadingAnimationWidget.waveDots(color: Colors.green, size: 30);
    } else {
      const Base64Codec base64 = Base64Codec();
      var bytes = base64.decode(widget.imagem64);
      return Image.memory(
        bytes,
        width: 500,
        fit: BoxFit.fitWidth,
      );
    }
  }
}
