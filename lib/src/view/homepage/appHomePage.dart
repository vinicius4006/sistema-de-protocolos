import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/finalizacaoProtocolo.dart';
import 'package:provider/provider.dart';

import '../../shared/models/protocolo.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key, required this.deVolta}) : super(key: key);

  String deVolta = 'false';

  @override
  State<HomePage> createState() => _MainHomeState();
}

class _MainHomeState extends State<HomePage> {



  final df = DateFormat('dd-MM-yyyy hh:mm a');
  List<Protocolo> protocoloFiltroLista = [];
  List<Protocolo> listaProtocolo = [];


  FutureOr onGoBack(dynamic value) {
    refreshPage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  refreshPage() {
    debugPrint('Atualizou');
    retornarProtocolos().then((value) {
      setState(() {
        protocoloFiltroLista = value.reversed.toList();
        listaProtocolo = value.reversed.toList();
        widget.deVolta = 'false';
      });
      debugPrint('Refresh');
      debugPrint('$value');
    }).catchError((onError) =>
        debugPrint('Dados do protocolo não vieram, motivo do erro: $onError'));
  }

  Future<List<Protocolo>> retornarProtocolos() async {
    final responseTodosOsProtocolos = await Dio().get('$URLSERVER/protocolos');

    return (responseTodosOsProtocolos.data as List).map((item) {
      return Protocolo.fromJson(item);
    }).toList();
  }

  void _protocoloFilter(String keyword) async {
    List<Protocolo> results;
    if (keyword.isEmpty) {
      results = listaProtocolo.toList();
    } else {
      results = listaProtocolo
          .toList()
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
        //filtroAtivado = true;
      } catch (e) {
        debugPrint('Motivo do erro no filtro: $e');
      }
    });
  }

  void menuProtocolo(String id) async {
    var protocoloCheck =
        listaProtocolo.where((element) => element.id == id).toList();
    debugPrint('${protocoloCheck[0].fim}');
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
          showCancelBtn: true,
          denyButtonText: "Exibir",
          denyButtonColor: Colors.blueGrey,
          cancelButtonText: 'Cancelar',
          confirmButtonText:
              protocoloCheck[0].fim != null ? 'Imprimir' : 'Finalizar',
        ));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton && protocoloCheck[0].fim == null) {
      showDialog(
          context: context,
          builder: (_) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  size: 80,
                  color: Colors.orange,
                  secondRingColor: Colors.green,
                  thirdRingColor: Colors.indigo),
            );
          }).timeout(
        const Duration(seconds: 2),
        onTimeout: () => Navigator.pop(context),
      );

      Timer(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => Finalizacao(
                      id: id,
                    )))
            .then(onGoBack);
        setState(() {
          context.read<ProtocoloModelo>().inicioIsFalse = true;
        });
      });
      return;
    } else if (response.isTapConfirmButton && protocoloCheck[0].fim != null) {
      String nomeColaborador = (context.read<LoginController>().username);
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title:
                  "Imprimindo através da Júpiter I.A!\nNão se preoucupe $nomeColaborador\nEm breve estará na sua mesa"));
      return;
    }

    if (response.isTapDenyButton) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info, title: "Exibição em instantes!"));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.deVolta == 'true' ? refreshPage() : debugPrint(''); 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          IconButton(
              onPressed: () {
                refreshPage();
              },
              icon: const Icon(Icons.refresh_rounded)),
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
              child: protocoloFiltroLista.isNotEmpty
                  ? ListView.builder(
                      itemCount: protocoloFiltroLista.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(protocoloFiltroLista[index].id),
                        color: Colors.lightGreen,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            protocoloFiltroLista[index].id.toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text('Placa: ' +
                              protocoloFiltroLista[index].placa.toString()),
                          subtitle: Text('\n' 'Início: ' +
                              protocoloFiltroLista[index].inicio.toString() +
                              '\n'
                                  '\n'
                                  'Final: ' +
                              (protocoloFiltroLista[index].fim ??
                                      'Ainda não finalizado')
                                  .toString()),
                          onTap: () {
                            menuProtocolo(
                                protocoloFiltroLista[index].id.toString());
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
