

import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';
import 'package:protocolo_app/src/view/login/login.dart';
import 'package:provider/provider.dart';

void main() async {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => chamandoApiReq()),
        ChangeNotifierProvider(create: (_) => ProtocoloModelo()),
        ChangeNotifierProvider(create: (_) => LoginController())
      ],
      child: MaterialApp(
        title: 'Bem-vindo ao Sistema de Protocolos',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const LoginProtocolo()//const Home(title: 'Sistema de Protocolos'),
      ),
    );
  }
}
