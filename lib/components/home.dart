import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/exibicaoProtocolo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: const BodyPage(),
    );
  }
}
