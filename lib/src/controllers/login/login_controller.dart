import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/api/Api_controller.dart';
import 'package:protocolo_app/src/shared/models/typesWarnings.dart';
import 'package:protocolo_app/src/view/homepage/homePage.dart';

const String URL =
    'https://api.jupiter.com.br/view/Usuarios/verificarUsuarioSenhaJSON';

class _LoginController extends ChangeNotifier {
  String username = '';
  String password = '';
  String token = '';
  final ValueNotifier<TextEditingController> controllerUsername =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> controllerPassword =
      ValueNotifier(TextEditingController());
  TypesWarning typesWarning = TypesWarning();
  reset() {
    username = '';
    password = '';
  }

  final dio = Dio();

  Future<bool> login() async {
    //conection

    Response response;
    FormData formData =
        FormData.fromMap({"usuario": username, "senha": password});
    try {
      response = await dio.post(URL,
          data: formData,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              sendTimeout: 2000,
              receiveTimeout: 2000));
      if (response.data['token'] != null) {
        token = response.data['token'];
        return true;
      } else {
        debugPrint('NAO DEU CERTO');
        return false;
      }
    } catch (e) {
      debugPrint('Motivo da perda de conexao: $e');
      return false;
    }
  }

  Future entrarProtocolo(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (loginControllerState.username.isEmpty ||
        loginControllerState.password.isEmpty) {
      typesWarning.showDanger(
          context, 'Oops...', "Algum campo não está preenchido");
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  size: 80,
                  color: Colors.orange,
                  secondRingColor: Colors.green,
                  thirdRingColor: Colors.indigo),
            );
          });
      if (await chamandoApiReqState.verificarConexao()) {
        Timer(Duration(seconds: 2), () {
          loginControllerState.login().then((value) {
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
              Navigator.pop(context);
              Navigator.push(context, route);
            } else {
              Navigator.pop(context);
              typesWarning.showDanger(context, "Usuário ou senha incorreta",
                  "Se o problema persistir consulte o departamento");
            }
          });
        });
      } else {
        Navigator.pop(context);
        typesWarning.showWarning(context, "Sem conexão",
            "Verifique se você está realmente conectado");
      }
    }
  }
}

final _LoginController loginControllerState = _LoginController();
