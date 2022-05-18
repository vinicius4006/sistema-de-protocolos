import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Card.dart';
import 'package:provider/provider.dart';

class VeiculoForm extends StatefulWidget {
  VeiculoForm({Key? key, this.placa}) : super(key: key);

  String? placa;

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  final bool _loading = true;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    criarProtocoloState.listaItensProtocolo.value.clear();
    criarProtocoloState.excluirFoto();
    debugPrint('Dispose VeiculoForm');
  }

  scrollTo(int index) async {
    final listaKeyScroll = context.read<ProtocoloModelo>().listaKey[index].currentContext!;
    await Scrollable.ensureVisible(listaKeyScroll, duration: const Duration(milliseconds: 600),);
  }
 
  //--------------------------A FUNCAO PEDE UM PARAMETRO PARA EXIBIR A LISTA DE CARD
  Widget exibirListaDeCard(List<ItensVeiculos>? data) {
    
    try {
      return Column(children: [
        data![2].tipoVeiculo == '0'
            ? const Text('Carro',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold))
            : const Text('Moto',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20.0,
        ),
       
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
       
            itemBuilder: (context, index) {
             context.read<ProtocoloModelo>().listaKey.add(GlobalKey());
             context.read<ProtocoloModelo>().listaDeCoresCheck.add(Colors.green);
              return CardForm(
               //key: context.read<ProtocoloModelo>().listaKey[index],
               indexGlobal: index,
                title: data[index].descricao.toString(),
                ops: data[index].parametros.toString(),
                input: data[index].input.toString(),
                numCat: data[index].id.toString(),
                color: context.read<ProtocoloModelo>().listaDeCoresCheck[index],
              );
            }),

      ]);
    } catch (e) {
      debugPrint('Motivo do Erro ao fazer lista de cards: $e');
      return const Text('Não é valido',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300));
    }
  }

  Widget showAll() {
    // for(var item in context.read<ProtocoloModelo>().listaKey){
    //   debugPrint('QUANDO CARREGA: ${item.currentContext}');
    // }
    if (widget.placa == null) {
      return const CircularProgressIndicator();
    } else {
      
      return FutureBuilder(
          future: widget.placa!.length > 1
              ? context
                  .read<chamandoApiReq>()
                  .retornarSeMotoOuCarro(int.parse(widget.placa!.substring(10)))
              : context
                  .read<chamandoApiReq>()
                  .retornarSeMotoOuCarroPorBooleano(widget.placa.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ItensVeiculos> data = (snapshot.data as List).map((item) {
                return ItensVeiculos.fromJson(item);
              }).toList();

              return SafeArea(
                  child: Container(
                padding: const EdgeInsets.all(30.0),
                child: exibirListaDeCard(data),
              ));
            } else {
              return Center(
                child: Text('Iniciando...', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),),
              );
            }
          });
    }
  }

  //--------------------------CORPO DO FORM VEICULO
  @override
  Widget build(BuildContext context) {
    debugPrint('Build VeiculoForm');
    return showAll();
  }
}
