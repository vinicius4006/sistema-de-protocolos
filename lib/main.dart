import 'package:flutter/material.dart';

import 'package:protocolo_app/src/view/login/login.dart';

void main() async {
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
            //brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: Colors.green, secondary: Color(0xff88c100))),
        home:
            const LoginProtocolo() //const Home(title: 'Sistema de Protocolos'),
        );
  }
}
