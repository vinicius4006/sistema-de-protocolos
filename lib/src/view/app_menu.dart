
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class Menu extends StatelessWidget {
   Menu({ Key? key }) : super(key: key);


String BASEURL = 'http://frota.jupiter.com.br/api/view/JSON';

   Future<List<dynamic>> loadMotoristas() async {
    
    final response = await Dio().get('$BASEURL/retornarPessoas');

       if(response.statusCode == 200) {
      // final testeJson = jsonDecode(response.toString());
      // debugPrint('${testeJson[0]}');
       //Map<String, dynamic> comp = response.data;
       Map<String, dynamic> mapData =  response.data;
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
      appBar: AppBar(title: const Text('Testando Provider'),
      centerTitle: true,),

      body:    Container(
        child: FutureBuilder<List<dynamic>>(
          future: loadMotoristas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
             print(_name(snapshot.data[1]));
             return ListView.builder(
               padding: const EdgeInsets.all(8),
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index){
               return Card(
                 child: Column(
                   children: <Widget>[
                     ListTile(
                       leading: const CircleAvatar(
                         radius: 30,
                         
                       ),
                       title: Text(_name(snapshot.data[index])),
                     )
                   ],
                 ),
               );
             });

            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
          ),
      //   child: Center(child: Column(children:   [
          
      //     for(var i = 0; i < context.read<ProtocoloModelo>().listaProtocolo.length; i++ )
      // Text('${context.watch<ProtocoloModelo>().listaProtocolo[i].toJson()}'),
          
          
         
      //   //  ${context.watch<IncController>().number}
      //   ] ),),
      )
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