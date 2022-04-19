import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/inc_controller.dart';

class Menu extends StatelessWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testando Provider'),
      centerTitle: true,),

      body:    Center(child: Column(children:   [
        
        Text('${context.watch<IncController>().cart.values}'),
        Text('${context.watch<IncController>().cart.length}')
      //  ${context.watch<IncController>().number}
      ] ),)
      ,
      floatingActionButton: FloatingActionButton(onPressed: () => context.read<IncController>().addItem('bola', 'que', 'po') 
      //=> context.read<IncController>().incNumber()}
        
      ,
      child: const Icon(Icons.plus_one),),
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