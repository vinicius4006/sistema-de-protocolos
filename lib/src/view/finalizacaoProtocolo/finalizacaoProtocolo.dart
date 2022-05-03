import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/protocolo_controller.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class Finalizacao extends StatefulWidget {
  Finalizacao({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  State<Finalizacao> createState() => _FinalizacaoState();
}

class _FinalizacaoState extends State<Finalizacao> {
  List tipo = [];
  List<String> listaImg = [''];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final SignatureController _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.blue);

  getProtocolo(String id, BuildContext context) {
    for (Protocolo item in context.read<ProtocoloModelo>().listaProtocolo) {
      if (item.id == id) {
        return item;
      }
    }
  }

  dynamic getTipoVeiculo(BuildContext context) {
    for (ItensProtocolo item
        in context.read<ProtocoloModelo>().testandoListaItensProtocolo) {
      if (item.protocolo == widget.id) {
        if (item.itemveiculo == '2') {
          return '0';
        } else {
          return '1';
        }
      }
    }
  }

  Future dadosDoTipo(String tipo, BuildContext context) async {
    var result = await context
        .read<retornarCarroOuMoto>()
        .retornarSeMotoOuCarroPorBooleano(tipo);
    return result;
  }

  List<String?> pegarDadosItensStatus(List<ItensProtocolo> lista) {
    List<String?> listaItens = ['0'];

    for (ItensProtocolo item in lista) {
      if (item.protocolo == widget.id) {
        listaItens.add(item.valor);
        listaImg.add(item.imagem.toString());
      }
    }

    //atenção na lista que está add mais imagens que o permitido pois a lista não está reiniciando

    return listaItens;
  }

  showCompleteCampo(BuildContext context) async {
    try {
      ArtDialogResponse response = await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "Preencha os campos",
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
      //Navigator.pop(context);

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

  Widget editarStatusConformeInput(data, List<String?> listaItens, int index) {
    if (listaItens[index]?.length == 1) {
      debugPrint('PASSOU');
      return Text('Status: ' +
          data[index]['parametros']
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('"', '')
              .split(',')[int.parse(listaItens[index].toString())]
              .toString());
    } else {
      //checkbox
      List<String> valorFinalEditadoExibir = [];
      List<String> valorEditadoParaExibir = data[index]['parametros']
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',');
      var listaItensCopia = (listaItens[index]?.substring(1))!
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .replaceAll(',', '');
      var listaModificadaEditada = listaItensCopia.split('');
      //debugPrint('$listaModificadaEditada');
      for (String item in listaModificadaEditada) {
        //debugPrint('Exibindo: $item');
        valorFinalEditadoExibir.add(valorEditadoParaExibir[int.parse(item)]);
      }
      debugPrint('Exibindo: $valorFinalEditadoExibir');
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
    Protocolo protocolo = getProtocolo(widget.id, context);

    String tipoVeiculo = getTipoVeiculo(context);

    List<ItensProtocolo> testeListaItens =
        context.read<ProtocoloModelo>().testandoListaItensProtocolo;
    List<String?> listaItens = pegarDadosItensStatus(testeListaItens);
    //debugPrint('$listaItens');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalização de Protocolo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 250,
              child: Card(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: ListTile(
                        title: Text(
                          'Protocolo: ${protocolo.id}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        ),
                        subtitle: Text('Placa: ${protocolo.placa}',
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
                          'Motorista: \n${protocolo.motorista == null ? 'Oliveira Batista Fonseca' : ''}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      leading: Icon(Icons.people, color: Colors.green[500]),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                          'Início: ${protocolo.inicio} \nFinal: ${protocolo.fim ?? 'Ainda não finalizado'}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      leading: Icon(Icons.calendar_today_outlined,
                          color: Colors.green[500]),
                    )
                  ],
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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
              future: dadosDoTipo(tipoVeiculo, context),
              builder: ((context, snapshot) {
                dynamic data = snapshot.data;

                //debugPrint('Status: $data');
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {
                  return Container();
                }
                try {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: const Icon(Icons.arrow_right),
                            title:
                                Text('Descrição: ' + data[index]['descricao']),
                            subtitle: editarStatusConformeInput(
                                data, listaItens, index),
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
                                                listaImg[index]))
                                      ]));
                            },
                          ),
                        );
                      });
                } catch (e) {
                  debugPrint('Motivo dos status não carregarem: $e');
                  return Container();
                }
              }),
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
            const Divider(),
            Signature(
              controller: _controller,
              height: 100,
              backgroundColor: Colors.grey,
            ),
            IconButton(
              onPressed: (() => setState(() {
                    _controller.clear();
                  })),
              icon: const Icon(Icons.clear),
              color: Colors.redAccent,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  var tamanhoVeiculo = await dadosDoTipo(tipoVeiculo, context);
                  var listaItensDoVeiculo =
                      context.read<ProtocoloModelo>().listaItensProtocolo;
                      //debugPrint("TAMANHO GERAL:${context.read<ProtocoloModelo>().testandoListaItensProtocolo}");
                  //debugPrint('TAMANHO Preenchidos: ${listaItensDoVeiculo.length}');
                  //debugPrint('TAMANHO Veiculo: ${tamanhoVeiculo.length}');
                  if (_controller.isEmpty ||
                      tamanhoVeiculo.length != listaItensDoVeiculo.length) {
                    showCompleteCampo(context);
                    //debugPrint('Tamnho Lista Itens do Veículo: ${listaItensDoVeiculo.length}');
                    //debugPrint('Tamnho Lista Itens Preenchidos: ${tamanhoVeiculo.length}');
                  } else {
                    //debugPrint('Tamnho Lista Itens do Veículo: ${listaItensDoVeiculo.length}');
                    //debugPrint('Tamnho Lista Itens Preenchidos: ${tamanhoVeiculo.length}');
                    final Uint8List? data = await _controller.toPngBytes();
                      debugPrint('$data');
                    showConfirmDialog(context);
                  }
                },
                child: const Text('Finalizar'))
          ]),
        ),
      ),
    );
  }
}
