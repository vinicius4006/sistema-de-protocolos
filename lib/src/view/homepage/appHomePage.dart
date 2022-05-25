import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/controllers/homePageController.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/finalizacaoProtocolo.dart';

import '../../shared/models/protocolo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainHomeState();
}

class _MainHomeState extends State<HomePage> {
  final df = DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Dispose HomePage');
    super.dispose();
  }

  void menuProtocolo(int id) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
          showCancelBtn: true,
          denyButtonText: "Exibir",
          denyButtonColor: Colors.blueGrey,
          cancelButtonText: 'Cancelar',
          confirmButtonText: 'Finalizar',
        ));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      showDialog(
          context: context,
          builder: (_) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                size: 80,
                color: Colors.white,
              ),
            );
          }).timeout(
        const Duration(seconds: 2),
        onTimeout: () => Navigator.pop(context),
      );

      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Finalizacao(
                  id: id,
                )));
      });
      return;
    }

    if (response.isTapDenyButton) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Sugestões do que exibir..."));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build HomePage');

    return Scaffold(
        body: FutureBuilder(
      future: chamandoApiReqState.retornarProtocolos(true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.green, size: 150),
          );
        } else {
          List<Protocolo> listaProtocolo = (snapshot.data as List<Protocolo>);
          homePageState.protocoloFilter('', listaProtocolo);
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Ink(
                decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: CircleBorder()),
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      criarProtocoloState.refreshPage();
                    },
                    icon: const Icon(Icons.refresh_rounded)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: ((value) =>
                    homePageState.protocoloFilter(value, listaProtocolo)),
                decoration: const InputDecoration(
                  labelText: 'Pesquisar',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: homePageState.protocoloFiltro,
                builder: (context, List<Protocolo> protocoloFiltro, _) {
                  return protocoloFiltro.isNotEmpty
                      ? ListView.builder(
                          itemCount: protocoloFiltro.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(protocoloFiltro[index].id),
                            color: Colors.lightGreen,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: Text(
                                protocoloFiltro[index].id.toString(),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w900),
                              ),
                              title: Text(
                                'Placa: ' +
                                    homePageState.placaPorVeiculo(
                                        protocoloFiltro[index]
                                            .veiculo
                                            .toString()),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              subtitle: Text(
                                '\n' 'Início: ' +
                                    DateFormat('dd/MM/yyyy - kk:mm')
                                        .format(protocoloFiltro[index].inicio!)
                                        .toString() +
                                    '\n'
                                        '\n'
                                        'Final: Ainda não finalizado',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              onTap: () {
                                menuProtocolo(
                                  protocoloFiltro[index].id!,
                                );
                              },
                            ),
                          ),
                        )
                      : const Text(
                          'Protocolo não encontrado',
                          style: TextStyle(fontSize: 24),
                        );
                },
              ))
            ]),
          );
        }
      },
    ));
  }
}
