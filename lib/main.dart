import 'package:flutter/material.dart';
import 'package:protocolo_app/src/appHome.dart';
import 'package:protocolo_app/src/controllers/inc_controller.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncController()),
        ChangeNotifierProvider(create: (_) => ProtocoloModelo())
      ],
      child: MaterialApp(
        title: 'Bem-vindo ao Sistema de Protocolos',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Home(title: 'Sistema de Protocolos'),
      ),
    );
  }
}
