import 'package:flutter/material.dart';
import 'package:protocolo_app/src/appHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bem-vindo ao Sistema de Protocolos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Home(title: 'Sistema de Protocolos'),
    );
  }
}
