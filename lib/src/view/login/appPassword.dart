import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:provider/provider.dart';

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
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: context.watch<LoginController>().controllerPassword,
            onChanged: (text) =>
                context.read<LoginController>().password = text,
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
      ],
    );
  }
}
