
import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/bodyPage.dart';
import 'package:protocolo_app/components/body/criarProtocolo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  void _telaCriarProtocolo(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CriarProtocolo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: (){_telaCriarProtocolo(context);}, 
            icon: const Icon(Icons.add_outlined)
          
            );
        }),
        actions: <Widget>[
           Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.refresh_outlined)
          
            );
        }),
        ],
        centerTitle: true,
        title: Text(title),
      ),
      
      body: const BodyPage(),
    );
  }
}
