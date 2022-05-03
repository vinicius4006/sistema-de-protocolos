import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
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

  //--------------------------A FUNCAO PEDE UM PARAMETRO PARA EXIBIR A LISTA DE CARD
  exibirListaDeCard(data) {
    try {
      return Column(children: [
        data[2]['tipo_veiculo'] == '0'
            ? const Text('Carro',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400))
            : const Text('Moto', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
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
                  numCat: data[index]['id'],
                );
              }),
        ),
      ]);
    } catch (e) {
      return null;
    }
  }

  //--------------------------CORPO DO FORM VEICULO
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.placa!.length > 1
            ? context
                .read<retornarCarroOuMoto>()
                .retornarSeMotoOuCarro(int.parse(widget.placa!.substring(10)))
            : context
                .read<retornarCarroOuMoto>()
                .retornarSeMotoOuCarroPorBooleano(widget.placa.toString()),
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
