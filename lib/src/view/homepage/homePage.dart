import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/view/criarProtocolo/criarProtocolo.dart';

import 'package:protocolo_app/src/view/homepage/appHomePage.dart';
import 'package:protocolo_app/src/view/login/login.dart';

import '../../controllers/login_controller.dart';
import '../../shared/models/protocolo.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    loginControllerState.token = '';

    debugPrint('Dispose Home');
    super.dispose();
  }

  void _telaCriarProtocolo(BuildContext context) async {
    Route route = MaterialPageRoute(builder: (context) => CriarProtocolo());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Home');
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
                      loginControllerState.reset();
                      loginControllerState.controllerUsername.value.clear();
                      loginControllerState.controllerPassword.value.clear();
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
        body: ValueListenableBuilder(
            valueListenable: criarProtocoloState.protocolo,
            builder: (context, Protocolo protocolo, _) => HomePage()));
  }
}
