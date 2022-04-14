import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/busca.dart';
import 'package:protocolo_app/components/body/menu.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Column(
        children: const [
          Menu(),
          Busca(),
        ],
      )
    );
  }
}
