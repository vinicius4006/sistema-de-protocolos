import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/login/login_controller.dart';

class Password extends StatelessWidget {
  const Password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Senha',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: ValueListenableBuilder(
            valueListenable: loginControllerState.controllerPassword,
            builder: (context, TextEditingController controllerPassword, _) =>
                TextField(
              key: Key('password'),
              controller: controllerPassword,
              onChanged: (text) => loginControllerState.password = text,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xffffa500),
                  ),
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black26)),
            ),
          ),
        ),
      ],
    );
  }
}
