import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appGetImagem.dart';

class InfoProtocolo extends StatefulWidget {
  InfoProtocolo({Key? key, required this.id}) : super(key: key);
  String id;
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
      future: chamandoApiReqState.retornarProtocolosPorId(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('...');
        } else {
          Protocolo protocolo = snapshot.data as Protocolo;
          return Card(
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
                  title: Text('Motorista: \n${protocolo.motorista ?? '...'}',
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
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.assignment_outlined,
                    color: Colors.green[500],
                  ),
                  title: const Text(
                    'Assinatura Inicial',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
                                      imagem64: protocolo.assinaturaInicial
                                          .toString()))
                            ]));
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
