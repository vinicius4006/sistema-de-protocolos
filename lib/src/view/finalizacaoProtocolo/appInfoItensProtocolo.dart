import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/Api_controller.dart';
import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Assinatura.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';
import 'package:protocolo_app/src/view/finalizacaoProtocolo/appButtonFinalizar.dart';

class InfoItensProtocolo extends StatefulWidget {
  InfoItensProtocolo({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<InfoItensProtocolo> createState() => _InfoItensProtocoloState();
}

class _InfoItensProtocoloState extends State<InfoItensProtocolo> {
  @override
  void dispose() {
    debugPrint('Dispose InfoItensProtocolo');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build InfoItensProtocolo');
    return FutureBuilder(
        future: chamandoApiReqState.retornarItensProtocoloId(widget.id),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Text('...');
          } else {
            List<dynamic> listaItensProtocoloId =
                snapshot.data as List<dynamic>;

            int tipoVeiculo =
                (listaItensProtocoloId[1] as ItensProtocolo).itemveiculo == 2
                    ? 0
                    : 1;

            return Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Status Final',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
                VeiculoForm(
                  veiculo: tipoVeiculo,
                ),
                FutureBuilder(
                    future: Future.delayed(Duration(seconds: 2), () {
                      return true;
                    }),
                    builder: ((context, snapshot) =>
                        !snapshot.hasData ? Text('') : Assinatura())),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      child: ButtonFinalizar(
                        id: widget.id,
                        tipoVeiculo: tipoVeiculo,
                      )),
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
