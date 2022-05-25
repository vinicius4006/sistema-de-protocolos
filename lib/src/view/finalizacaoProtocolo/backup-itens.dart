import 'dart:convert';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/criarProtocoloController.dart';
import 'package:protocolo_app/src/shared/models/itensVeiculo.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Assinatura.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appGetImagem.dart';

class InfoItensProtocoloBackup extends StatefulWidget {
  InfoItensProtocoloBackup({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<InfoItensProtocoloBackup> createState() =>
      _InfoItensProtocoloBackupState();
}

class _InfoItensProtocoloBackupState extends State<InfoItensProtocoloBackup> {
  @override
  void dispose() {
    debugPrint('Dispose InfoItensProtocoloBackup');
    super.dispose();
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
      String assinaturaFinal = await criarProtocoloState
          .assinaturaController.value
          .toPngBytes()
          .then((value) {
        final Uint8List data = value!;
        String base64Image = base64Encode(data);
        return base64Image;
      });
      // criarProtocoloState.addFormProtocoloEnd(
      //     DateTime.now(), loginControllerState.username, assinaturaFinal);

      //FALTAR FINALIZAR OS FORM DE FINALIZACAO
      Navigator.pop(context);

      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success, title: "Finalizado!"));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build InfoItensProtocoloBackup');
    return FutureBuilder(
        future: chamandoApiReqState.retornarItensProtocoloId(widget.id),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Text('...');
          } else {
            List<dynamic> listaItensProtocoloId =
                snapshot.data as List<dynamic>;
            debugPrint('${listaItensProtocoloId}');
            String tipoVeiculo =
                (listaItensProtocoloId[1] as ItensProtocolo).itemveiculo == '2'
                    ? '0'
                    : '1';

            return Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Status Inicial',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
                Text(
                  tipoVeiculo == '0' ? 'Carro' : 'Moto',
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FutureBuilder(
                    future:
                        criarProtocoloState.dadosDoTipo(tipoVeiculo, context),
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
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
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
                                  subtitle: Text('...')
                                  // EditarStatus(
                                  //     listaItensVeiculos: data,
                                  //     listaItens: criarProtocoloState
                                  //         .pegarDadosItensStatus(
                                  //             listaItensProtocoloId, widget.id),
                                  //     index: index)
                                  ,
                                  onTap: () {
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            title: "Foto tirada",
                                            customColumns: [
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 12.0),
                                                  child: GetImagemBase64(
                                                      imagem64: criarProtocoloState
                                                              .pegarImgPorStatus(
                                                                  listaItensProtocoloId,
                                                                  widget.id)
                                                              .isEmpty
                                                          ? ''
                                                          : criarProtocoloState
                                                              .pegarImgPorStatus(
                                                                  listaItensProtocoloId,
                                                                  widget
                                                                      .id)[index]))
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
                Assinatura(),
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
                        var tamanhoVeiculo = await criarProtocoloState
                            .dadosDoTipo(tipoVeiculo, context);
                        var listaItensDoVeiculo =
                            criarProtocoloState.listaItensProtocolo.value;

                        if (criarProtocoloState
                                .assinaturaController.value.isEmpty ||
                            tamanhoVeiculo.length !=
                                listaItensDoVeiculo.length) {
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
                              criarProtocoloState
                                  .scrollTo(listaCheckIdLista.indexOf(item));
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
              ],
            );
          }
        }));
  }
}
