import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:protocolo_app/src/shared/models/protocolo.dart';
import 'package:protocolo_app/src/view/app_menu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainHomeState();
}

class _MainHomeState extends State<HomePage> {
  final df = DateFormat('dd-MM-yyyy hh:mm a');
  int myvalue = 1558432747;

  static final List<Map<String, dynamic>> _allProtocolos = [];

  List<Protocolo> _foundProtocolos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _protocoloFilter(String keyword) {
    List<Protocolo> results = [];
    if (keyword.isEmpty) {
      results = _foundProtocolos;
    } else {
      results = _foundProtocolos
          .where((protocolo) => (protocolo.motorista! +
                  ' - ' +
                  protocolo.id.toString() +
                  ' - ' +
                  protocolo.dataInicio.toString() +
                  ' - ' +
                  protocolo.dataFinal.toString() +
                  ' - ' +
                  protocolo.veiculo.toString())
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
     
    }

    setState(() {
      _foundProtocolos = results;
      debugPrint('$_foundProtocolos');
    });
  }

  void menuProtocolo() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
          showCancelBtn: true,
          denyButtonText: "Imprimir",
          denyButtonColor: Colors.blueGrey,
          cancelButtonText: 'Cancelar',
          confirmButtonText: "Finalizar",
        ));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Menu()));
      return;
    }

    if (response.isTapDenyButton) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Imprimindo através da Júpiter I.A!"));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).unfocus();
    setState(() {
      _foundProtocolos = context.read<ProtocoloModelo>().listaProtocolo;
    });
    

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: ((value) => _protocoloFilter(value)),
            decoration: const InputDecoration(
              labelText: 'Pesquisar',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _foundProtocolos.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                  itemCount: _foundProtocolos.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_foundProtocolos[index].id),
                    color: Colors.lightGreen,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Text(
                        _foundProtocolos[index].id.toString(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(_foundProtocolos[index].veiculo.toString()),
                      subtitle: Text('\n' 'Início: ' +
                          _foundProtocolos[index].dataInicio.toString() +
                          '\n'
                              '\n'
                              'Final: ' +
                          _foundProtocolos[index].dataFinal.toString()),
                      onTap: () {
                        menuProtocolo();
                      },
                    ),
                  ),
                ))
              : const Text(
                  'Protocolo não encontrado',
                  style: TextStyle(fontSize: 24),
                )
        ]),
      ),
    );
  }
}
