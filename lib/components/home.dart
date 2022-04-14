
import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/bodyPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  void _exibirDialogo(BuildContext context){
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Testando'),
        content: const Text('Testando'),
        actions: <Widget>[
          ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Fechar"))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(onPressed: (){_exibirDialogo(context);}, icon: const Icon(Icons.add_outlined));
        }),
        centerTitle: true,
        title: Text(title),
      ),
      
      body: const BodyPage(),
    );
  }
}
