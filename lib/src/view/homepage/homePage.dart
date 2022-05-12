import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';

import 'package:protocolo_app/src/view/criarProtocolo/criarProtocolo.dart';
import 'package:protocolo_app/src/view/homepage/appHomePage.dart';
import 'package:protocolo_app/src/view/login/login.dart';
import 'package:provider/provider.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/startProtocolo_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

String volta = 'false';


  FutureOr onGoBack(dynamic value) {
    debugPrint('VOLTOU do criar');
    setState(() {
      volta = 'true';
    });
   
  }

  void _telaCriarProtocolo(BuildContext context) {
    Route route =
        MaterialPageRoute(builder: (context) => const CriarProtocolo());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  _telaCriarProtocolo(context);
                  context.read<ProtocoloModelo>().inicioIsFalse = false;
                },
                icon: const Icon(Icons.add_outlined));
          }),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return IconButton(
                  onPressed: () async {
                    ArtDialogResponse response = await ArtSweetAlert.show(
                        barrierDismissible: false,
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            denyButtonText: "Cancelar",
                            title: "Deseja mesmo deslogar?",
                            confirmButtonText: "Sim",
                            type: ArtSweetAlertType.warning));

                    if (response == null) {
                      return;
                    }

                    if (response.isTapConfirmButton) {
                      Route route = MaterialPageRoute(
                          builder: (context) => const LoginProtocolo());
                      context.read<LoginController>().reset();
                      context
                          .read<LoginController>()
                          .controllerUsername
                          .clear();
                      context
                          .read<LoginController>()
                          .controllerPassword
                          .clear();
                      Navigator.pop(context, route);

                      return;
                    }
                  },
                  icon: const Icon(Icons.login_outlined));
            }),
          ],
          centerTitle: true,
          title: Text(widget.title),
        ),
        body:    HomePage(deVolta: volta,));
  }
}
