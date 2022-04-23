import 'package:flutter/material.dart';
import 'package:protocolo_app/src/view/app_menu.dart';

import 'package:protocolo_app/src/view/criarProtocolo/criarProtocolo.dart';
import 'package:protocolo_app/src/view/homepage/homePage.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  void _telaCriarProtocolo(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CriarProtocolo()));
  }

  void _telaExtra(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Menu()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                _telaCriarProtocolo(context);
              },
              icon: const Icon(Icons.add_outlined));
        }),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
                onPressed: () {_telaExtra(context);}, icon: const Icon(Icons.refresh_outlined));
          }),
        ],
        centerTitle: true,
        title: Text(title),
      ),
      body: const HomePage(),
    );
  }
}
