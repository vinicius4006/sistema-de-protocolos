import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/conectarApi_controller.dart';
import 'package:protocolo_app/src/shared/models/pessoa_motorista.dart';
import 'package:protocolo_app/src/shared/models/placas.dart';
import 'package:protocolo_app/src/view/criarProtocolo/appPesquisaBar.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({Key? key}) : super(key: key);

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: chamandoApiReqState.retornarPessoaPorMotorista(0, true),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text(''),
                );
              } else {
                List<Pessoa> listaMotoristas = (snapshot.data as List<Pessoa>);
                return PesquisaBar(
                    titulo: 'Selecione o Motorista',
                    lista: listaMotoristas,
                    sePessoa: true);
              }
            }),
        SizedBox(
          height: 40,
        ),
        FutureBuilder(
            future: chamandoApiReqState.loadPlacas(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text(''),
                );
              } else {
                List<Placas> listaPlacas = snapshot.data as List<Placas>;

                return PesquisaBar(
                  titulo: 'Selecione o Veículo',
                  lista: listaPlacas,
                  sePessoa: false,
                );
              }
            })
      ],
    );
  }
}
