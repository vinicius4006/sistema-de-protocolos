
import 'package:flutter/material.dart';

class TelaDePassagem extends StatefulWidget {
  const TelaDePassagem({Key? key}) : super(key: key);

  @override
  State<TelaDePassagem> createState() => _TelaDePassagemState();
}

class _TelaDePassagemState extends State<TelaDePassagem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint('Dispose TelaDePassagem');
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('Build TelaDePassagem');
    return const Scaffold(
      body: Center(
        child: Text('Entrando...', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
