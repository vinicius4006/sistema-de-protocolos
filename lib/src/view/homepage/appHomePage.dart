import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/api/Api_controller.dart';
import 'package:protocolo_app/src/controllers/home/homePageController.dart';
import 'package:protocolo_app/src/shared/models/typesWarnings.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/finalizacaoProtocolo.dart';

import '../../shared/models/protocolo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainHomeState();
}

class _MainHomeState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _controllerTextFilter = TextEditingController();
  final typesWarning = TypesWarning();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        homePageState.loadData(_scrollController.position.pixels.toInt());
      }
    });
  }

  @override
  void dispose() {
    debugPrint('Dispose HomePage');
    super.dispose();
    _scrollController.dispose();
    homePageState.x = 0;
    homePageState.listProtocolo.value.clear();
    homePageState.listaPlacaVeiculo.value.clear();
    homePageState.refresh.value = false;
    homePageState.intScroll = 2;
    chamandoApiReqState.listaPlacas.clear();
  }

  void menuProtocolo(int id) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
          showCancelBtn: true,
          //denyButtonText: "Veículo",
          denyButtonColor: Colors.blueGrey,
          cancelButtonText: 'Cancelar',
          confirmButtonText: 'Finalizar',
        ));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                size: 80,
                color: Colors.white,
              ),
            );
          });
      Timer(Duration(seconds: 2), () async {
        if (await chamandoApiReqState.verificarConexao()) {
          Protocolo finalizadoOuNao =
              await chamandoApiReqState.retornarProtocolosPorId(true, id);
          if (finalizadoOuNao.id != null) {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Finalizacao(
                      id: id,
                    )));
          } else {
            Navigator.pop(context);
            typesWarning.showWarning(context, "Houve algum problema!",
                "Atualize a lista e tente novamente");
          }
          return;
        } else {
          Navigator.pop(context);
          typesWarning.showWarning(context, "Sem conexão",
              "Verifique se está devidamente conectado");
        }
      });
    }

    if (response.isTapDenyButton) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build HomePage');

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Ink(
          decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: CircleBorder()),
          child: IconButton(
              color: Colors.white,
              onPressed: () {
                homePageState.refresh.value = true;
                homePageState.protocoloFilter('');
                _controllerTextFilter.clear();
                homePageState.intScroll = 0;
                chamandoApiReqState.listaPlacas.clear();
              },
              icon: const Icon(Icons.refresh_rounded)),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _controllerTextFilter,
          onSubmitted: ((value) {
            homePageState.refresh.value = true;
            homePageState.protocoloFilter(value);
          }),
          decoration: const InputDecoration(
            labelText: 'Pesquisar',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
          valueListenable: homePageState.refresh,
          builder: (context, bool refresh, _) {
            if (refresh) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                    color: Theme.of(context).colorScheme.secondary, size: 30),
              );
            } else {
              return Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: homePageState.listProtocolo,
                      builder: (context, List<Protocolo> listaProtocolo, _) {
                        return ListView.separated(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: listaProtocolo.length + 1,
                          itemBuilder: (context, index) => index <
                                  listaProtocolo.length
                              ? Card(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  key: ValueKey(listaProtocolo[index].id),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  elevation: 4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    leading: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          listaProtocolo[index].id.toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 82, 85, 62),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                    title: ValueListenableBuilder(
                                      valueListenable:
                                          homePageState.listaPlacaVeiculo,
                                      builder:
                                          (context, List<String> placas, _) {
                                        return Text(
                                          'Placa: ' +
                                              '${homePageState.placaPorVeiculo(listaProtocolo[index].veiculo.toString())}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        );
                                      },
                                    ),
                                    subtitle: Text(
                                      '\n' 'Início: ' +
                                          DateFormat('dd/MM/yyyy - kk:mm')
                                              .format(homePageState
                                                  .listProtocolo
                                                  .value[index]
                                                  .inicio!)
                                              .toString() +
                                          '\n'
                                              '\n'
                                              'Final: Ainda não finalizado',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    onTap: () {
                                      menuProtocolo(
                                        listaProtocolo[index].id!,
                                      );
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 26),
                                  child: Center(
                                      child: homePageState.maisDados
                                          ? LoadingAnimationWidget
                                              .discreteCircle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  size: 30)
                                          : Text('Não há mais protocolos')),
                                ),
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                            );
                          },
                        );
                      }));
            }
          },
        ),
      ]),
    ));
  }
}
