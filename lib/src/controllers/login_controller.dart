import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  reset() {
    username = '';
    password = '';
  }

  Future<bool> login() async {
    //conection

    final dio = Dio();
    Response response;
    FormData formData =
        FormData.fromMap({"usuario": username, "senha": password});
    try {
      response = await dio.post(URL,
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
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

  Future<bool> verificarAssinaturaDaToken() async {
    final dio = Dio();
    Response response;
    FormData formData = FormData.fromMap({'token': token, 'senha': password});

    response = await dio.post(
        'https://api.jupiter.com.br/api/view/ProtocoloFrota/verificarAssinaturaDaToken',
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType));

    if ((response.data as String).contains('1')) {
      return true;
    } else {
      return false;
    }
  }
}

final _LoginController loginControllerState = _LoginController();
