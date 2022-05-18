import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:provider/provider.dart';

import '../homepage/homePage.dart';

class Entrar extends StatefulWidget {
  const Entrar({Key? key}) : super(key: key);

  @override
  State<Entrar> createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  bool loading = true;

  @override
  void dispose() {
    debugPrint('Dispose Entrar-Button');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('Build Entrar-Button');
    var readContext = context.read<LoginController>();
    var watchContext = context.watch<LoginController>();

    Future entrarProtocolo() async {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      if (watchContext.username.isEmpty || watchContext.password.isEmpty) {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oops...",
                text: "Algum campo não está preenchido"));
      } else {
        watchContext.login().then((value) {
          if (value) {
            showDialog(
                context: context,
                builder: (_) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        size: 80,
                        color: Colors.orange,
                        secondRingColor: Colors.green,
                        thirdRingColor: Colors.indigo),
                  );
                }).timeout(
              const Duration(seconds: 2),
              onTimeout: () => Navigator.pop(context),
            );
            Timer(const Duration(seconds: 2), () {
              PageRouteBuilder route = PageRouteBuilder(
                  transitionDuration: const Duration(seconds: 1),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  pageBuilder: ((context, animation, secondaryAnimation) {
                    return const Home(title: 'Sistema de Protocolos');
                  }));
              Navigator.push(context, route);
            });
          } else {
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "Usuário ou senha incorreta",
                    text: "Se o problema persistir provavelmente o servidor se encontra OFFLINE"));
          }
        });
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: const EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: Colors.white),
        onPressed: (() {
          entrarProtocolo();
        }),
        child: const Text(
          'Entrar',
          style: TextStyle(
              color: Color(0xffffa500),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }
}
