import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:provider/provider.dart';


class Menu extends StatelessWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testando Provider'),
      centerTitle: true,),

      body:    Center(child: Column(children:   [
        
    for(var i = 0; i < context.read<ProtocoloModelo>().listaProtocolo.length; i++ )
Text('${context.watch<ProtocoloModelo>().listaProtocolo[i].toJson()}'),
        
        
       
      //  ${context.watch<IncController>().number}
      ] ),)
      ,
      
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