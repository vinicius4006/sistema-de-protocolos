import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/protocolo_controller.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/finalizacaoProtocolo.dart';
import 'package:provider/provider.dart';

import '../../shared/models/protocolo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainHomeState();
}

class _MainHomeState extends State<HomePage> {
  final df = DateFormat('dd-MM-yyyy hh:mm a');
  List<Protocolo> protocoloFiltroLista = [];
  bool filtroAtivado = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _protocoloFilter(String keyword) async {
    List<Protocolo> results = context.read<ProtocoloModelo>().listaProtocolo;
    if (keyword.isEmpty) {
      results = context.read<ProtocoloModelo>().listaProtocolo;
    } else {
      results = context
          .read<ProtocoloModelo>()
          .listaProtocolo
          .where((protocolo) => (protocolo.id.toString() +
                  ' - ' +
                  protocolo.inicio.toString() +
                  ' - ' +
                  protocolo.fim.toString() +
                  ' - ' +
                  protocolo.placa.toString())
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      try {
        //debugPrint('${results[0].placa}');
        protocoloFiltroLista = results;
        filtroAtivado = true;
      } catch (e) {
        debugPrint('Motivo do erro no filtro: $e');
      }
    });
  }

  void menuProtocolo(String id) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
          showCancelBtn: true,
          denyButtonText: "Imprimir",
          denyButtonColor: Colors.blueGrey,
          cancelButtonText: 'Cancelar',
          confirmButtonText: "Finalizar",
        ));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Finalizacao(id: id,)));
      return;
    }

    if (response.isTapDenyButton) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Imprimindo através da Júpiter I.A!"));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Protocolo> protocoloLista = filtroAtivado
        ? protocoloFiltroLista.reversed.toList()
        : context.watch<ProtocoloModelo>().listaProtocolo.reversed.toList();

        for(var item in context.read<ProtocoloModelo>().testandoListaItensProtocolo){
          debugPrint('${item.toJson()}');
        }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: ((value) => _protocoloFilter(value)),
            decoration: const InputDecoration(
              labelText: 'Pesquisar',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: protocoloLista.isNotEmpty
                  ? ListView.builder(
                      itemCount: protocoloLista.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(protocoloLista[index].id),
                        color: Colors.lightGreen,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            protocoloLista[index].id.toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text('Placa: ' +
                              protocoloLista[index].placa.toString()),
                          subtitle: Text('\n' 'Início: ' +
                              protocoloLista[index].inicio.toString() +
                              '\n'
                                  '\n'
                                  'Final: ' +
                              (protocoloLista[index].fim ?? 'Ainda não finalizado').toString()),
                          onTap: () {
                            menuProtocolo(protocoloLista[index].id.toString());
                          },
                        ),
                      ),
                    )
                  : const Text(
                      'Protocolo não encontrado',
                      style: TextStyle(fontSize: 24),
                    ))
        ]),
      ),
    );
  }
}
