

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protocolo_app/src/controllers/getApi_controller.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formMoto.dart';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_formCarro.dart';
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

  // List<Map<String, dynamic>> motoristas = [
  //   {"motoristas": 'FERNANDO LIMA VIEIRA', "id": 1},
  //   {"motoristas": 'CARLOS HENRIQUE MIRANDA LIMA', "id": 2},
  //   {"motoristas": 'MAURO DA SILVA SOUSA', "id": 3},
  //   {"motoristas": 'RONILDO MARTINS DE SOUZA', "id": 4},
  //   {"motoristas": 'JACKSON AMORIM DA COSTA', "id": 5},
  //   {"motoristas": 'LUCIANO INACIO GONÇALVES LIMA', "id": 6}
  // ];

  // final veiculos = <Map<String, dynamic>>[
  //   {"placa": 'CNH1981', "tipo": 1},
  //   {"placa": 'MPM4776', "tipo": 2},
  //   {"placa": 'NAT9582', "tipo": 1},
  //   {"placa": 'NDR1600', "tipo": 2},
  // ];

  loopVeiculo(Future lista) async {
   
    for (var item in await lista) {
      veiculos.add(item['placa'] + ' - ' + item['id']);
    }

   
  }

  loopMotorista(Future lista) async {
   
   for(var item in await lista){
     motoristas.add(item['nome']);
   }

  }

  final motoristaSelecionar = TextEditingController();
  String motoristaSelecionado = '';

  final veiculoSelecionar = TextEditingController();
  String veiculoSelecionado = '';

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    loopMotorista(MotoristaData().loadMotoristas());
    loopVeiculo(VeiculoData().loadPlacas());
    retornarSeMotoOuCarro('400');
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
                CustomDropdown.search(
                  controller: motoristaSelecionar,
                  hintText: 'Selecione o Motorista',
                  excludeSelected: false,
                  onChanged: (value) {
                    setState(() {
                      motoristaSelecionado = value;
                      debugPrint(motoristaSelecionado);
                    });
                  },
                  items: motoristas,
                ),
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
                     
                      //debugPrint(veiculos.toList(growable: false).elementAt(index));
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                (veiculoSelecionado.isNotEmpty)
                    ? (retornarSeMotoOuCarro(veiculoSelecionado.substring(10)) == true)
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CarroForm(),
                          )
                        : const Padding(
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
                        if (int.parse(veiculoSelecionado[3]) <= 5) {
                          context.read<ProtocoloModelo>().addFormCarro(
                              motoristaSelecionado,
                              veiculoSelecionado,
                              dataInicio,
                              "");
                        } else {
                          context.read<ProtocoloModelo>().addFormMoto(
                              motoristaSelecionado,
                              veiculoSelecionado,
                              dataInicio,
                              "");
                        }

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
