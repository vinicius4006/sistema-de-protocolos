import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/api/Api_controller.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/infoItensDoFormulario/appEditarStatus.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/infoItensDoFormulario/appGetImagem.dart';

class StatusAnterior extends StatefulWidget {
  StatusAnterior({Key? key, required this.indexGlobal}) : super(key: key);

  int indexGlobal;
  @override
  State<StatusAnterior> createState() => _StatusAnteriorState();
}

class _StatusAnteriorState extends State<StatusAnterior> {
  @override
  void dispose() {
    debugPrint('Dispose Status Anterior');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'AQUI: ${chamandoApiReqState.listaItensVeiculo[widget.indexGlobal].toJson()}');
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.arrow_right),
        title: EditarStatus(
          indexGlobal: widget.indexGlobal,
          itensVeiculos:
              chamandoApiReqState.listaItensVeiculo[widget.indexGlobal],
          itensProtocolo: chamandoApiReqState.listaItensProtocoloId,
        ),
        onTap: () {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs:
                  ArtDialogArgs(title: "Foto tirada", customColumns: [
                Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: FutureBuilder(
                      future: chamandoApiReqState.retornarImagensPorProtocolo(
                          chamandoApiReqState
                              .listaItensProtocoloId[0].protocolo,
                          chamandoApiReqState
                              .listaItensVeiculo[widget.indexGlobal].id),
                      initialData: 'wait',
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GetImagemBase64(
                            imagem64: snapshot.data as String,
                          );
                        } else {
                          return GetImagemBase64(
                            imagem64: 'wait',
                          );
                        }
                      },
                    ))
              ]));
        },
      ),
    );
  }
}
