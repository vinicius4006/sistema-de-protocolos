import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:provider/provider.dart';

import '../homepage/homePage.dart';


class Entrar extends StatefulWidget {
  const Entrar({Key? key}) : super(key: key);

  @override
  State<Entrar> createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  @override
  Widget build(BuildContext context) {

    var readContext = context.read<LoginController>();
    var watchContext = context.watch<LoginController>();
    
    Future entrarProtocolo() async {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if(!currentFocus.hasPrimaryFocus){
        currentFocus.unfocus();
      }
      if(watchContext.username.isEmpty || watchContext.password.isEmpty){
        ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Oops...",
                  text: "Algum campo não está preenchido"));
      } else {
        //readContext.login();
          readContext.login().then((value) {
        if (value) {
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
        } else {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Oops...",
                  text: "Usuário ou senha incorreta"));
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
        }
        ),
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
