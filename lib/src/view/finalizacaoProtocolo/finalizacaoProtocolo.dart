import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/endProtocolo_controller.dart';
import 'package:protocolo_app/src/controllers/startProtocolo_controller.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appTelaDePassagem.dart';
import 'package:provider/provider.dart';

import '../../controllers/login_controller.dart';

class Finalizacao extends StatefulWidget {
  Finalizacao({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  State<Finalizacao> createState() => _FinalizacaoState();
}

class _FinalizacaoState extends State<Finalizacao> {
  Protocolo? protocolo;
  List<dynamic>? listaItensProtocoloId;
  String tipoScroll = '';
  final ScrollController _scrollController = ScrollController();
  final dataFinal = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chamandoApiReq().retornarProtocolosPorId(widget.id).then((value) {
      setState(() {
        protocolo = value;
      });
    });
    chamandoApiReq().retornarItensProtocoloId(widget.id).then((value) {
      setState(() {
        listaItensProtocoloId = value;
      });
    });
  }

  scrollTo(int index) async {
    final listaKeyScroll =
        context.read<ProtocoloModelo>().listaKey[index].currentContext!;
    await Scrollable.ensureVisible(
      listaKeyScroll,
      duration: const Duration(milliseconds: 600),
    );
    // setState(() {
    //   context.read<ProtocoloModelo>().listaDeCoresCheck[index] = Colors.red;
    // });
  }

  scrollToTop() async {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  scrollToBottom() async {
    var data = await context
        .read<chamandoApiReq>()
        .retornarSeMotoOuCarroPorBooleano(tipoScroll);
    double time = data[1]['id'] != '2' ? 8000 : 20000;
    _scrollController.animateTo(time,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

 

  Future dadosDoTipo(String tipo, BuildContext context) async {
    var result = await context
        .read<chamandoApiReq>()
        .retornarSeMotoOuCarroPorBooleano(tipo);
    return result;
  }

  List<String> pegarDadosItensStatus(List<dynamic> lista) {
    List<String>? listaItens = [];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == widget.id) {
        listaItens.add(item.valor!);
      }
    }

    return listaItens;

    //atenção na lista que está add mais imagens que o permitido pois a lista não está reiniciando
  }

  List<String> pegarImgPorStatus(List<dynamic> lista) {
    List<String>? listaImg = [];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == widget.id) {
        listaImg.add(item.imagem.toString());
      }
    }

    return listaImg;

    //atenção na lista que está add mais imagens que o permitido pois a lista não está reiniciando
  }

  showCompleteCampo(BuildContext context) async {
    try {
      ArtDialogResponse response = await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "Não esqueça da assinatura!",
          ));
    } catch (e) {
      debugPrint('Motivo do erro da mensagem: $e');
      return const Text('');
    }
  }

  showConfirmDialog(BuildContext context) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancelar",
            title: "Tem certeza que deseja finalizar?",
            text: "Se houver dúvidas verifique os dados novamente",
            confirmButtonText: "Sim, quero finalizar",
            type: ArtSweetAlertType.warning));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      String assinaturaFinal = await context
          .read<ProtocoloModelo>()
          .controller
          .toPngBytes()
          .then((value) {
        final Uint8List data = value!;
        String base64Image = base64Encode(data);
        return base64Image;
      });
      EndProtocolo().addFormProtocoloEnd(widget.id, dataFinal,
          context.read<LoginController>().username, assinaturaFinal);

      context.read<ProtocoloModelo>().endFormItensProtocolo();

      //FALTAR FINALIZAR OS FORM DE FINALIZACAO
      Navigator.pop(context);

      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success, title: "Finalizado!"));
      return;
    }
  }

  Widget getImagemBase64(String imagem) {
    String _imageBase64 = imagem;

    if (imagem.isEmpty || imagem == '') {
      return const Text('Não foi tirado foto alguma');
    } else {
      const Base64Codec base64 = Base64Codec();
      var bytes = base64.decode(_imageBase64);
      return Image.memory(
        bytes,
        width: 500,
        fit: BoxFit.fitWidth,
      );
    }
  }

  Widget editarStatusConformeInput(
      List<ItensVeiculos> data, List<String?> listaItens, int index) {
    //debugPrint('ANALISANDO TAMANHO: ${listaItens[index]}');
    // debugPrint('${data[12]['parametros']}');
    if (!listaItens[index]!.contains('[')) {
      // debugPrint('RADIOBUTTON: $index');
      // debugPrint(
      //     'Formato exibido RadioButton : ${listaItens[index].runtimeType}');
      return Text('Status: ' +
          data[index]
              .parametros
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('"', '')
              .split(',')[int.parse(listaItens[index].toString())]
              .toString());
    } else {
      //checkbox
      //debugPrint('Formato exibido CheckBox : ${listaItens[index].runtimeType}');
      List<String> valorFinalEditadoExibir = [];
      List<String> valorEditadoParaExibir = data[index]
          .parametros
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',');
      // debugPrint('ValorEditadoParaExibir: $valorEditadoParaExibir - $index');
      var listaItensCopia = (listaItens[index]?.substring(1))!
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .replaceAll(',', '');
      var listaModificadaEditada = listaItensCopia.split('');
      //debugPrint(
      //  'ListaModificadaEditada: $index - $listaModificadaEditada - ${listaModificadaEditada.length}');
      for (String item in listaModificadaEditada) {
        valorFinalEditadoExibir.add(valorEditadoParaExibir[int.parse(item)]);
      }
      //debugPrint('Exibindo: $valorFinalEditadoExibir');
      return Text('Status: ' +
          valorFinalEditadoExibir
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''));
    }
  }

  //Corpo da Aplicação
  @override
  Widget build(BuildContext context) {
    if (listaItensProtocoloId == null) {
      return const TelaDePassagem();
    } else {
      context.read<ProtocoloModelo>().idFinalProtocolo = widget.id;
      context.read<ProtocoloModelo>().listaItensProtocolo.clear();
      context.read<ProtocoloModelo>().controller.clear();
      context.read<ProtocoloModelo>().listaKey.clear();
      context.read<ProtocoloModelo>().listaDeCoresCheck.clear();

      String tipoVeiculo =
          (listaItensProtocoloId![1] as ItensProtocolo).itemveiculo == '2'
              ? '0'
              : '1';
      setState(() {
        tipoScroll = tipoVeiculo;
      });
      return Scaffold(
        appBar: AppBar(
          title: const Text('Finalização de Protocolo'),
          centerTitle: true,
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              onPressed: (() => scrollToTop()),
              child: const Icon(Icons.arrow_upward),
              heroTag: null,
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.small(
              heroTag: null,
              onPressed: (() => scrollToBottom()),
              child: const Icon(Icons.arrow_downward),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            SizedBox(
              height: 350,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: ListTile(
                          title: Text(
                            'Protocolo: ${protocolo?.id ?? 'Carregando'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 24),
                          ),
                          subtitle: Text(
                              'Placa: ${protocolo?.placa ?? 'Carregando'}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          leading: Icon(
                            Icons.article,
                            color: Colors.green[500],
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                            'Motorista: \n${protocolo?.motorista ?? 'Carregando'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        leading: Icon(Icons.people, color: Colors.green[500]),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                            'Início: ${protocolo?.inicio ?? 'Carregando'} \nFinal: ${protocolo?.fim ?? 'Ainda não finalizado'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        leading: Icon(Icons.calendar_today_outlined,
                            color: Colors.green[500]),
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.assignment_outlined,
                          color: Colors.green[500],
                        ),
                        title: const Text(
                          'Assinatura Inicial',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        onTap: () {
                          ArtSweetAlert.show(
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                  title: "Assinatura Inicial",
                                  customColumns: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: getImagemBase64(protocolo
                                                ?.assinaturaInicial
                                                .toString() ??
                                            ''))
                                  ]));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Status Inicial',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            Text(
              tipoVeiculo == '0' ? 'Carro' : 'Moto',
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: dadosDoTipo(tipoVeiculo, context),
                builder: ((context, snapshot) {
                  //resolver problema nullo

                  List<ItensVeiculos> data =
                      ((snapshot.data ?? []) as List).map((item) {
                    return ItensVeiculos.fromJson(item);
                  }).toList();

                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                      '...',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ));
                  } else {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          //debugPrint('Contando Tamanho: $index');
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.arrow_right),
                              title: Text('Descrição: ' +
                                  data[index].descricao.toString()),
                              subtitle: editarStatusConformeInput(
                                  data,
                                  pegarDadosItensStatus(listaItensProtocoloId!),
                                  index),
                              onTap: () {
                                ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                        title: "Foto tirada",
                                        customColumns: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 12.0),
                                              child: getImagemBase64(
                                                  pegarImgPorStatus(
                                                          listaItensProtocoloId!)[
                                                      index]))
                                        ]));
                              },
                            ),
                          );
                        });
                  }
                }),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Status Final',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            VeiculoForm(
              placa: tipoVeiculo,
            ),
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
                      primary: Colors.green),
                  onPressed: () async {
                    var tamanhoVeiculo =
                        await dadosDoTipo(tipoVeiculo, context);
                    var listaItensDoVeiculo =
                        context.read<ProtocoloModelo>().listaItensProtocolo;

                    if (context.read<ProtocoloModelo>().controller.isEmpty ||
                        tamanhoVeiculo.length != listaItensDoVeiculo.length) {
                      List<ItensProtocolo> listaOrganizada =
                          context.read<ProtocoloModelo>().listaItensProtocolo;
                      List<String> listaCheckIdLista = [];
                      List<String> listaCheckIdVeiculo = [];
                      for (var item in tamanhoVeiculo) {
                        listaCheckIdLista.add(item['id']);
                      }
                      for (var item in listaOrganizada) {
                        listaCheckIdVeiculo.add(item.itemveiculo.toString());
                      }

                      for (var item in listaCheckIdLista.reversed) {
                        if (listaCheckIdVeiculo.contains(item)) {
                          debugPrint('True');
                        } else {
                          scrollTo(listaCheckIdLista.indexOf(item));
                        }
                      }
                      if (listaCheckIdVeiculo.length ==
                          listaCheckIdLista.length) {
                        showCompleteCampo(context);
                      }
                    } else {
                      showConfirmDialog(context);
                    }
                  },
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 249, 249, 249),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ]),
        ),
      );
    }
  }
}
