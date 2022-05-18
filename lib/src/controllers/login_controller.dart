import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String URL =
    'https://api.jupiter.com.br/view/Usuarios/verificarUsuarioSenhaJSON';

class _LoginController extends ChangeNotifier {
  String username = '';
  String password = '';
  final ValueNotifier<TextEditingController> controllerUsername =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> controllerPassword =
      ValueNotifier(TextEditingController());

  reset() {
    username = '';
    password = '';
  }

  Future<bool> login() async {
    // LoginModel loginModel = LoginModel(username: username, password: password);
    final dio = Dio();
    Response response;
    FormData formData =
        FormData.fromMap({"usuario": username, "senha": password});
    try {
      response = await dio.post(URL,
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.data['token'] != null) {
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
}

final _LoginController loginControllerState = _LoginController();
