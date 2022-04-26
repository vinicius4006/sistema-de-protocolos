import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

  Future<List<dynamic>> loadMotoristas() async {
    final response = await Dio().get('$BASEURL/retornarPessoas');

    if (response.statusCode == 200) {
      // final testeJson = jsonDecode(response.toString());
      // debugPrint('${testeJson[0]}');
      //Map<String, dynamic> comp = response.data;
      Map<String, dynamic> mapData = response.data;
      List<dynamic> data = mapData['results'];
      return data;
    } else {
      throw Exception('Falha ao carregar motorisas');
    }
  }

  String _name(dynamic user) {
    return user['nome'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testando Provider'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              for (var i = 0;
                  i < context.read<ProtocoloModelo>().listaProtocolo.length;
                  i++)
                Text(
                    '${context.watch<ProtocoloModelo>().listaProtocolo[i].toJson()}'),
          
            
            ]),
          ),
        ),
      ),
    );
  }
}



// Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton.icon(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.panorama_fish_eye,
//               size: 15.0,
//             ),
//             label: const Text("Iniciar"),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.check,
//               size: 15.0,
//             ),
//             label: const Text("Finalizar"),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.local_print_shop,
//               size: 15.0,
//             ),
//             label: const Text("Imprimir Termo"),
//           )
//         ],
//       );