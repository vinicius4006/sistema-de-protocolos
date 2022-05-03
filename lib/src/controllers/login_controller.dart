import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  String username = '';
  String password = '';
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String URL =
      'https://api.jupiter.com.br/view/Usuarios/verificarUsuarioSenhaJSON';

  reset() {
    username = '';
    password = '';
  }

  //Para logar no sistema
  Future<bool> verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login() async {
   // LoginModel loginModel = LoginModel(username: username, password: password);
    final dio = Dio();
    Response response;
    FormData formData = FormData.fromMap({"usuario": username, "senha":password});
    response = await dio.post(URL,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType));

    if (response.data['token'] != null) {
      return true;
    } else {
      debugPrint('NAO DEU CERTO');
      return false;
    }
  }
}
