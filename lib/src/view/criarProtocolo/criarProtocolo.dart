import 'package:flutter/material.dart';
import 'package:protocolo_app/src/shared/models/protocolo_model.dart';

import 'package:protocolo_app/src/view/criarProtocolo/app_formMoto.dart';

import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formCarro.dart';
import 'package:provider/provider.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({Key? key}) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<ArtDialogState>? _artDialogKey;
  ProtocoloModelo protocoloModelo = ProtocoloModelo();

  @override
  void initState() {
    _artDialogKey = GlobalKey<ArtDialogState>();
    super.initState();
  }

  List<String> motoristas = [
    'FERNANDO LIMA VIEIRA',
    'CARLOS HENRIQUE MIRANDA LIMA',
    'MAURO DA SILVA SOUSA',
    'RONILDO MARTINS DE SOUZA',
    'JACKSON AMORIM DA COSTA',
    'LUCIANO INACIO GONÇALVES LIMA'
  ];

  List<String> veiculos = [
    'CNH1981',
    'MPM4776',
    'NAT9582',
    'NDR1600',
    'MZZ6330',
    'MTH0655',
    'HYW8452'
  ];

  final motoristaSelecionar = TextEditingController();
  String motoristaSelecionado = '';

  final veiculoSelecionar = TextEditingController();
  String veiculoSelecionado = '';

  DateTime now = DateTime.now();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_outlined));
          }),
          centerTitle: true,
          title: const Text('Criação de Protocolo'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ProtocoloModelo(),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Motoristas',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropDownField(
                    controller: motoristaSelecionar,
                    hintText: 'Selecione o Motorista',
                    enabled: true,
                    items: motoristas,
                    itemsVisibleInDropdown: 5,
                    onValueChanged: (value) {
                      setState(() {
                        motoristaSelecionado = value;
                      });
                    },
                    required: true,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    motoristaSelecionado,
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Veículos',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropDownField(
                    controller: veiculoSelecionar,
                    hintText: 'Selecione o Veículo',
                    enabled: true,
                    required: true,
                    items: veiculos,
                    itemsVisibleInDropdown: 5,
                    onValueChanged: (value) {
                      setState(() {
                        veiculoSelecionado = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    veiculoSelecionado,
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  (veiculoSelecionado == 'NDR1600')
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CarroForm(),
                        )
                      : (veiculoSelecionado == 'CNH1981')
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: MotoForm(),
                            )
                          : const Text(''),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint(
                              '$motoristaSelecionado $veiculoSelecionado $now');
                          Navigator.of(context).pop();
                          ArtSweetAlert.show(
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                type: ArtSweetAlertType.success,
                                title: 'Protocolo Criado',
                              ));
                        } else {
                          ArtSweetAlert.show(
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                type: ArtSweetAlertType.info,
                                title: "Verifique os dados",
                              ));
                        }
                      },
                      child: const Text('Criar'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

}

