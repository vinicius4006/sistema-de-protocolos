import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
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

  List<Map<String, dynamic>> _foundProtocolos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foundProtocolos = _allProtocolos;
  }

  void _protocoloFilter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.isEmpty) {
      results = _allProtocolos;
    } else {
      results = _allProtocolos
          .where((protocolo) => (protocolo['motorista'] +
                  ' - ' +
                  protocolo['id'].toString() +
                  ' - ' +
                  protocolo['dataInicial'].toString() +
                  ' - ' +
                  protocolo['dataFinal'].toString() +
                  ' - ' +
                  protocolo['veiculo'])
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundProtocolos = results;
    });
  }

  void menuProtocolo() async{
    ArtDialogResponse response = await ArtSweetAlert.show(
  barrierDismissible: false,
  context: context,
  artDialogArgs: ArtDialogArgs(
    showCancelBtn: true,
    denyButtonText: "Imprimir",
    denyButtonColor: Colors.blueGrey,
    cancelButtonText: 'Cancelar',
    confirmButtonText: "Finalizar",
  )
);

if(response==null) {
  return;
}

if(response.isTapConfirmButton) {
 Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  Menu()));
  return;
}

if(response.isTapDenyButton) {
  ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
      type: ArtSweetAlertType.info,
      title: "Imprimindo através da Júpiter I.A!"
    )
  );
  return;
}
  }

  @override
  Widget build(BuildContext context) {
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
          context.watch<ProtocoloModelo>().listaProtocolo.isNotEmpty ?
          Expanded(
              child: 
                 ListView.builder(
                      itemCount: context
                          .watch<ProtocoloModelo>()
                          .listaProtocolo
                          .length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(context
                            .watch<ProtocoloModelo>()
                            .listaProtocolo[index].id),
                        color: Colors.lightGreen,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            context
                                .watch<ProtocoloModelo>()
                                .listaProtocolo[index].id
                                .toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(context
                              .watch<ProtocoloModelo>()
                              .listaProtocolo[index].motorista.toString()),
                          subtitle: Text(context
                              .watch<ProtocoloModelo>()
                              .listaProtocolo[index].veiculo.toString()),
                          trailing: Text('Início: ' +
                              context
                              .watch<ProtocoloModelo>()
                              .listaProtocolo[index].dataInicio.toString() +
                              '\n\n' 'Final: ' +
                              context
                              .watch<ProtocoloModelo>()
                              .listaProtocolo[index].dataFinal.toString()),
                          onTap: () {
                            menuProtocolo();
                          },
                        ),
                      ),
                    )
                 )  : const Text(
                      'Protocolo não encontrado',
                      style: TextStyle(fontSize: 24),
                    )
        ]),
      ),
    );
  }
}
