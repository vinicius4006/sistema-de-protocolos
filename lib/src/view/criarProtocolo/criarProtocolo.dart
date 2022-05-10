import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';
import 'package:provider/provider.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({Key? key}) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
  // List<String> motoristas = [''];
  List<String> veiculos = [''];

  final dataInicio = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
  bool _loading = true;
  GlobalKey<ArtDialogState>? _artDialogKey;
  ProtocoloModelo protocoloModelo = ProtocoloModelo();

  @override
  void initState() {
    _artDialogKey = GlobalKey<ArtDialogState>();
    loopVeiculo(VeiculoData().loadPlacas());

    super.initState();
  }

  @override
  void dispose() {
    veiculoSelecionar.dispose();

    super.dispose();
    debugPrint('SAI DAQUI PQ DESFEZ');
  }

  scrollTo(int index) async {
    final listaKeyScroll =
        context.read<ProtocoloModelo>().listaKey[index].currentContext!;
    await Scrollable.ensureVisible(
      listaKeyScroll,
      duration: const Duration(milliseconds: 600),
    );
  }

  loopVeiculo(Future lista) async {
    for (var item in await lista) {
      veiculos.add(item['placa'] + ' - ' + item['id']);
    }
  }

  void loading() {
    setState(() {
      _loading = true;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  Future<List<Protocolo>> retornarProtocolos() async {
    final responseTodosOsProtocolos = await Dio().get('$URLSERVER/protocolos');
    return responseTodosOsProtocolos.data;
  }

  final veiculoSelecionar = TextEditingController();
  String veiculoSelecionado = '';

  var data;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // loopMotorista(MotoristaData().loadMotoristas());

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_outlined));
          }),
          centerTitle: true,
          title: const Text('Criação de Protocolo'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollTo(0);
          },
          child: const Icon(Icons.arrow_upward),
        ),
        body: Form(
          key: context.read<ProtocoloModelo>().formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              //controller: _scrollController,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                // const Text(
                //   'Motoristas',
                //   style: TextStyle(fontSize: 20.0),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // CustomDropdown.search(
                //   controller: motoristaSelecionar,
                //   hintText: 'Selecione o Motorista',
                //   excludeSelected: false,
                //   onChanged: (value) {
                //     setState(() {
                //       motoristaSelecionado = value;
                //       debugPrint(motoristaSelecionado);
                //     });
                //   },
                //   items: motoristas.reversed.toList(),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Veículos',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomDropdown.search(
                  controller: veiculoSelecionar,
                  hintText: 'Selecione o Veículo',
                  excludeSelected: false,
                  items: veiculos,
                  onChanged: (value) {
                    loading();
                    setState(() {
                      veiculoSelecionado = value;

                      context
                          .read<ProtocoloModelo>()
                          .listaItensProtocolo
                          .clear();
                      context.read<ProtocoloModelo>().controller.clear();

                      context.read<ProtocoloModelo>().selectRadioVerificacao =
                          -1;
                      context.read<ProtocoloModelo>().changeListaVerificacao = [
                        false
                      ];

                      data = context
                          .read<chamandoApiReq>()
                          .retornarSeMotoOuCarro(
                              int.parse(veiculoSelecionado.substring(10)));
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),

                Visibility(
                    visible: veiculoSelecionado.isNotEmpty,
                    child: Column(
                      children: [
                        !_loading
                            ? VeiculoForm(
                                placa: veiculoSelecionado,
                              )
                            : Center(
                                child: LoadingAnimationWidget.twistingDots(
                                  leftDotColor: Colors.orange,
                                  rightDotColor: Colors.green,
                                  size: 70,
                                ),
                              ),
                      ],
                    )),

                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            primary: Theme.of(context).primaryColor),
                        onPressed: (() async {
                          try {
                            var tamanhoVeiculo = await context
                                .read<chamandoApiReq>()
                                .retornarSeMotoOuCarro(int.parse(
                                    veiculoSelecionado.substring(10)));
                            var listaItensDoVeiculo = context
                                .read<ProtocoloModelo>()
                                .listaItensProtocolo;
                            if (context
                                    .read<ProtocoloModelo>()
                                    .formKey
                                    .currentState!
                                    .validate() &&
                                listaItensDoVeiculo.length ==
                                    tamanhoVeiculo.length &&
                                context
                                    .read<ProtocoloModelo>()
                                    .controller
                                    .isNotEmpty) {
                              String assinaturaInicial = await context
                                  .read<ProtocoloModelo>()
                                  .controller
                                  .toPngBytes()
                                  .then((value) {
                                final Uint8List data = value!;
                                String base64Image = base64Encode(data);
                                return base64Image;
                              });

                              context.read<ProtocoloModelo>().addFormProtocolo(
                                  dataInicio,
                                  "",
                                  veiculoSelecionado.substring(10),
                                  veiculoSelecionado.substring(0, 7),
                                  "",
                                  "",
                                  "",
                                  "",
                                  context.read<LoginController>().username,
                                  "",
                                  assinaturaInicial,
                                  "");

                              Navigator.of(context).pop();
                              ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                    type: ArtSweetAlertType.success,
                                    title: 'Protocolo Criado',
                                  ));
                            } else {
                            //   List<ItensProtocolo> listaOrganizada = context
                            //       .read<ProtocoloModelo>()
                            //       .listaItensProtocolo;
                            //   listaOrganizada.sort(((a, b) => (int.parse(
                            //           a.itemveiculo.toString()))
                            //       .compareTo(
                            //           int.parse(b.itemveiculo.toString()))));
                            //   for (var item in listaOrganizada) {
                            //     debugPrint('INDO: ${item.toJson()}');
                            //    if (item.toJson().isEmpty) {
                            //      debugPrint('FOI');
                            //       scrollTo(listaOrganizada.indexOf(item));
                            //     }
                            //  }
                              // ArtSweetAlert.show(
                              //     context: context,
                              //     artDialogArgs: ArtDialogArgs(
                              //       type: ArtSweetAlertType.info,
                              //       title: "Verifique os dados",
                              //     ));
                            }
                          } catch (e) {
                            ArtSweetAlert.show(
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                  type: ArtSweetAlertType.info,
                                  title: "Verifique os dados",
                                ));
                          }
                        }),
                        child: const Text(
                          'Criar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
