import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appEditarStatus.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appGetImagem.dart';

class StatusAnterior extends StatefulWidget {
  StatusAnterior({Key? key, required this.indexGlobal}) : super(key: key);

  int indexGlobal;
  @override
  State<StatusAnterior> createState() => _StatusAnteriorState();
}

class _StatusAnteriorState extends State<StatusAnterior> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.arrow_right),
        title: EditarStatus(
          itensVeiculos:
              chamandoApiReqState.listaItensVeiculo[widget.indexGlobal],
          itensProtocolo:
              chamandoApiReqState.listaItensProtocoloId[widget.indexGlobal],
        ),
        onTap: () {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs:
                  ArtDialogArgs(title: "Foto tirada", customColumns: [
                Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: GetImagemBase64(imagem64: ''))
              ]));
        },
      ),
    );
  }
}

// criarProtocoloState
//                                 .pegarImgPorStatus(
//                                     listaItensProtocoloId, widget.id)
//                                 .isEmpty
//                             ? ''
//                             : criarProtocoloState.pegarImgPorStatus(
//                                 listaItensProtocoloId, widget.id)[index]