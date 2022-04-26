import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/getApi_controller.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formVeiculo.dart';
import 'package:provider/provider.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({Key? key}) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
  List<String> motoristas = [''];
  List<String> veiculos = [''];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final dataInicio = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());

  GlobalKey<ArtDialogState>? _artDialogKey;
  ProtocoloModelo protocoloModelo = ProtocoloModelo();

  @override
  void initState() {
    _artDialogKey = GlobalKey<ArtDialogState>();

    super.initState();
  }

  @override
  void dispose() {
    motoristaSelecionar.dispose();
    veiculoSelecionar.dispose();
    super.dispose();
  }

  loopVeiculo(Future lista) async {
    for (var item in await lista) {
      veiculos.add(item['placa'] + ' - ' + item['id']);
    }
  }

  loopMotorista(Future lista) async {
    for (var item in await lista) {
      motoristas.add(item['nome']);
    }
  }

  final motoristaSelecionar = TextEditingController();
  String motoristaSelecionado = '';

  final veiculoSelecionar = TextEditingController();
  String veiculoSelecionado = '';

  var data;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // loopMotorista(MotoristaData().loadMotoristas());
    loopVeiculo(VeiculoData().loadPlacas());

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
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                // const Text(
                //   'Motoristas',
                //   style: TextStyle(fontSize: 20.0),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // CustomDropdown.search(
                //   controller: motoristaSelecionar,
                //   hintText: 'Selecione o Motorista',
                //   excludeSelected: false,
                //   onChanged: (value) {
                //     setState(() {
                //       motoristaSelecionado = value;
                //       debugPrint(motoristaSelecionado);
                //     });
                //   },
                //   items: motoristas.reversed.toList(),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Veículos',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomDropdown.search(
                  controller: veiculoSelecionar,
                  hintText: 'Selecione o Veículo',
                  excludeSelected: false,
                  items: veiculos,
                  onChanged: (value) {
                    setState(() {
                      veiculoSelecionado = value;
                      data = context
                          .read<retornarCarroOuMoto>()
                          .retornarSeMotoOuCarro(
                              int.parse(veiculoSelecionado.substring(10)));
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Visibility(
                  visible: veiculoSelecionado.isNotEmpty,
                  child: VeiculoForm(
                    placa: veiculoSelecionado,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() 
                       ) {
                         
                        data.then((value) => value[2]['tipo_veiculo'] == '0'
                            ? context.read<ProtocoloModelo>().addFormCarro(
                                motoristaSelecionado,
                                veiculoSelecionado,
                                dataInicio,
                                "")
                            : context.read<ProtocoloModelo>().addFormMoto(
                                motoristaSelecionado,
                                veiculoSelecionado,
                                dataInicio,
                                ""));

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
        ));
  }
}
