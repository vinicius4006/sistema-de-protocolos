
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/getApi_controller.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Card.dart';
import 'package:provider/provider.dart';

class VeiculoForm extends StatefulWidget {
  VeiculoForm({Key? key, this.placa}) : super(key: key);

  String? placa;

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  

  @override
  void initState() {
    super.initState();
  }

 @override
 void dispose() {
   
   super.dispose();
 }

  exibirListaDeCard(data) {
    
    try {
 return Column(children: [
      data[2]['tipo_veiculo'] == '0' ? const Text('Carro') : const Text('Moto'),
      const SizedBox(
        height: 20.0,
      ),
      SingleChildScrollView(
        
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CardForm(
                title: data[index]['descricao'],
                ops: data[index]['parametros'],
                input: data[index]['input'],
                numCat: int.parse(data[index]['id']),
                classificacao: data[2]['tipo_veiculo'] == '0' ? false : true,
              );
            }),
      ),
    ]);
    } catch (e) {
      return null;
    }
     
   
    //}
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        future: context.read<retornarCarroOuMoto>().retornarSeMotoOuCarro(int.parse(widget.placa!.substring(10))),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            
            return SafeArea(
                child: Container(
              padding: const EdgeInsets.all(30.0),
              child: exibirListaDeCard(data) ?? const Text(''),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
