import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';

class CampoTexto extends StatelessWidget {
  const CampoTexto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build CampoTexto');
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => FocusScope.of(context).unfocus(),
          child: Text('Clique AQUI para sair do campo de observação'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.lightGreen)),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: criarProtocoloState.obsTextController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Observação",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.green)),
              ),
            )),
      ],
    );
  }
}
