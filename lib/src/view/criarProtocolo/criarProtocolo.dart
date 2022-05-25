import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/login_controller.dart';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Assinatura.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({Key? key}) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
  // List<String> motoristas = [''];
  GlobalKey<ArtDialogState>? _artDialogKey;

  @override
  void initState() {
    _artDialogKey = GlobalKey<ArtDialogState>();
    super.initState();
  }

  @override
  void dispose() {
    chamandoApiReqState.veiculoSelecionar.value.clear();
    criarProtocoloState.resetVeiculoSelecionado();
    criarProtocoloState.scrollController = ScrollController();
    criarProtocoloState.assinaturaController.value.clear();
    criarProtocoloState.scrollVisible.value = false;
    criarProtocoloState.listaInput.clear();
    super.dispose();
    debugPrint('Dispose CriarProtocolo');
  }

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // loopMotorista(MotoristaData().loadMotoristas());
    debugPrint('Build CriarProtocolo');
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
        floatingActionButton: ValueListenableBuilder(
          valueListenable: criarProtocoloState.scrollVisible,
          builder: (context, bool scrollVisible, _) => scrollVisible
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      onPressed: (() => criarProtocoloState.scrollToTop()),
                      child: const Icon(Icons.arrow_upward),
                      heroTag: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.small(
                      heroTag: null,
                      onPressed: (() => criarProtocoloState.scrollToBottom()),
                      child: const Icon(Icons.arrow_downward),
                    ),
                  ],
                )
              : Text(''),
        ),
        body: Form(
          key: criarProtocoloState.formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              controller: criarProtocoloState.scrollController,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
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
                FutureBuilder(
                    future: chamandoApiReqState.loadPlacas(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text(''),
                        );
                      } else {
                        return ValueListenableBuilder(
                          valueListenable:
                              chamandoApiReqState.veiculoSelecionar,
                          builder: (context,
                                  TextEditingController veiculoSelecionar, _) =>
                              CustomDropdown.search(
                            controller: veiculoSelecionar,
                            hintText: 'Selecione o Veículo',
                            excludeSelected: false,
                            items: snapshot.data as List<String>,
                            onChanged: (value) {
                              criarProtocoloState
                                  .changeVeiculoSelecionado(value);
                            },
                          ),
                        );
                      }
                    }),
                const SizedBox(
                  height: 20.0,
                ),
                ValueListenableBuilder(
                  valueListenable: criarProtocoloState.veiculoSelecionado,
                  builder: (context, String veiculoSelecionado, _) =>
                      veiculoSelecionado != ''
                          ? Column(
                              children: [
                                VeiculoForm(
                                  placa: veiculoSelecionado,
                                ),
                                FutureBuilder(
                                    future: Future.delayed(Duration(seconds: 1),
                                        () {
                                      return true;
                                    }),
                                    builder: ((context, snapshot) =>
                                        !snapshot.hasData
                                            ? Text('')
                                            : Assinatura())),
                              ],
                            )
                          : Center(
                              child: LoadingAnimationWidget.waveDots(
                                color: Colors.green,
                                size: 100,
                              ),
                            ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            primary: Theme.of(context).primaryColor),
                        onPressed: (() async {
                          try {
                            var tamanhoVeiculo = await chamandoApiReqState
                                .retornarSeMotoOuCarro(int.parse(
                                    criarProtocoloState.veiculoSelecionado.value
                                        .substring(10)));

                            var listaItensDoVeiculo =
                                criarProtocoloState.listaItensProtocolo.value;
                            if (criarProtocoloState.formKey.currentState!
                                    .validate() &&
                                listaItensDoVeiculo.length ==
                                    tamanhoVeiculo.length &&
                                criarProtocoloState
                                    .assinaturaController.value.isNotEmpty) {
                              bool checkToken = await loginControllerState
                                  .verificarAssinaturaDaToken();
                              if (checkToken) {
                                String assinaturaInicial =
                                    await criarProtocoloState
                                        .assinaturaController.value
                                        .toPngBytes()
                                        .then((value) {
                                  final Uint8List data = value!;
                                  String base64Image = base64Encode(data);
                                  return base64Image;
                                });

                                criarProtocoloState.novoProtocolo(Protocolo(
                                    veiculo: int.parse(criarProtocoloState
                                        .veiculoSelecionado.value
                                        .substring(10)),
                                    digitador: loginControllerState.username,
                                    assinaturaInicial: assinaturaInicial));
                                Navigator.of(context).pop();

                                ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                      type: ArtSweetAlertType.success,
                                      title: 'Protocolo Criado',
                                    ));
                              } else {
                                ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.danger,
                                        title: "Usuário e senha negados",
                                        text:
                                            "Parece que há problema com os seus dados!"));
                              }
                            } else {
                              List<ItensProtocolo> listaOrganizada =
                                  listaItensDoVeiculo;
                              List<String> listaCheckIdLista = [];
                              List<String> listaCheckIdVeiculo = [];
                              for (var item in tamanhoVeiculo) {
                                listaCheckIdLista.add(item['id']);
                              }
                              for (var item in listaOrganizada) {
                                listaCheckIdVeiculo
                                    .add(item.itemveiculo.toString());
                              }

                              for (var item in listaCheckIdLista.reversed) {
                                if (listaCheckIdVeiculo.contains(item)) {
                                  debugPrint('True');
                                } else {
                                  criarProtocoloState.scrollTo(
                                      listaCheckIdLista.indexOf(item));
                                }
                              }

                              if (listaCheckIdVeiculo.length ==
                                  listaCheckIdLista.length) {
                                ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                      type: ArtSweetAlertType.info,
                                      title: "Verifique sua assinatura",
                                    ));
                              }
                            }
                          } catch (e) {
                            ArtSweetAlert.show(
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                  type: ArtSweetAlertType.info,
                                  title: "Ocorreu algum problema...",
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
