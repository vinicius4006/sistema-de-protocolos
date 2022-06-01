import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/homePageApi_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Card.dart';

class VeiculoForm extends StatefulWidget {
  VeiculoForm({Key? key, this.veiculo}) : super(key: key);

  int? veiculo;

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
    criarProtocoloState.listaItensProtocolo.value.clear();
    criarProtocoloState.excluirFoto();
    criarProtocoloState.changeButton.value.clear();
    criarProtocoloState.assinaturaController.dispose;
    criarProtocoloState.listaCoresCard.value.clear();
    criarProtocoloState.listaKey.clear();
    debugPrint('Dispose VeiculoForm');
  }

  //--------------------------A FUNCAO PEDE UM PARAMETRO PARA EXIBIR A LISTA DE CARD
  Widget exibirListaDeCard(List<ItensVeiculos>? data) {
    try {
      return Column(children: [
        data![2].tipoVeiculo == 0
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
              criarProtocoloState.listaKey.add(GlobalKey());
              criarProtocoloState.listaCoresCard.value
                  .add(Theme.of(context).colorScheme.primary);
              return CardForm(
                key: criarProtocoloState.listaKey[index],
                indexGlobal: index,
                title: data[index].descricao.toString(),
                ops: data[index].parametros.toString(),
                input: data[index].input.toString(),
                numCat: data[index].id!,
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
    if (widget.veiculo == null) {
      return const CircularProgressIndicator();
    } else {
      return FutureBuilder(
          future: widget.veiculo! > 1
              ? chamandoApiReqState.retornarSeMotoOuCarro(widget.veiculo!)
              : chamandoApiReqState
                  .retornarSeMotoOuCarroPorBooleano(widget.veiculo!),
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
                child: Text(
                  'Iniciando...',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
                ),
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
