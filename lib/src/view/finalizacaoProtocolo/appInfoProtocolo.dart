import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/controllers/homePageController.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appGetImagem.dart';

class InfoProtocolo extends StatefulWidget {
  InfoProtocolo({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<InfoProtocolo> createState() => _InfoProtocoloState();
}

class _InfoProtocoloState extends State<InfoProtocolo> {
  @override
  void dispose() {
    debugPrint('Dispose InfoProtocolo');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build InfoProtocolo');
    return FutureBuilder(
      future: chamandoApiReqState.retornarProtocolosPorId(true, widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('...');
        } else {
          Protocolo protocolo = snapshot.data as Protocolo;
          debugPrint('${protocolo.toJson()}');
          return SingleChildScrollView(
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
                      subtitle: Text(
                          'Placa: ${homePageState.placaPorVeiculo(protocolo.veiculo.toString())}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                      leading: Icon(
                        Icons.article,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: FutureBuilder(
                      future: chamandoApiReqState.retornarPessoaPorMotorista(
                          protocolo.motorista!, false),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(
                            'Procurando motorista...',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          );
                        } else {
                          String nome = snapshot.data as String;
                          return Text(
                              'Motorista: \n${nome == '' ? 'Não constado' : nome}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18));
                        }
                      },
                    ),
                    leading: Icon(Icons.people,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                        'Início: ${DateFormat('dd/MM/yyyy - kk:mm').format(DateTime.parse(protocolo.inicio.toString())).toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                    leading: Icon(Icons.calendar_today_outlined,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.assignment_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text(
                      'Assinatura Inicial',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    onTap: () {
                      ArtSweetAlert.show(
                          context: context,
                          artDialogArgs: ArtDialogArgs(
                              title: "Assinatura Inicial",
                              customColumns: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    child: GetImagemBase64(
                                        imagem64: protocolo.assinaturaInicial ??
                                            ''.toString()))
                              ]));
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
