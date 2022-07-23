import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/login/login_controller.dart';

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
          loginControllerState.entrarProtocolo(context);
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
