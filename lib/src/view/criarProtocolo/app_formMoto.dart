import 'package:flutter/material.dart';
import 'package:protocolo_app/src/controllers/protocolo_controllerl.dart';
import 'package:protocolo_app/src/view/criarProtocolo/app_Card.dart';
import 'package:provider/provider.dart';

class MotoForm extends StatefulWidget {
  const MotoForm({Key? key}) : super(key: key);

  @override
  State<MotoForm> createState() => _MotoFormState();
}



class _MotoFormState extends State<MotoForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children:  <Widget>[
              const Text(
                'Formulário de Moto',
                style: TextStyle(height: 1, fontSize: 30),
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Buzina',
                op1: 'Barulho Baixo',
                op2: 'Som estranho',
                op3: 'Som de animal',
                op4: 'Não presta',
                numCat: 0,
                classificacao: context.read<ProtocoloModelo>().titleMoto,
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Retrovisor - Direito/Esquerdo',
                op1: 'Rasgado',
                op2: 'Fino demais',
                op3: 'Couro duro',
                op4: 'Estranho',
                numCat: 4,
                classificacao: context.read<ProtocoloModelo>().titleMoto,
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Farol Baixo',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 7,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Farol Alto',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 8,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Luz De Freio',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 10,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Luzes Do Painel',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 13,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Setas Dianteiras',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 14,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Setas Traseiras',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 15,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Velocímetro / Tacógrafo',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 18,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Freios',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 19,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Pneus (Estado)',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 28,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Pneus (Calibragem)',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 30,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
               CardForm(
                title: 'Nível combustível',
                op1: 'op1',
                op2: 'op2',
                op3: 'op3',
                op4: 'op4',
                numCat: 35,
                classificacao: context.read<ProtocoloModelo>().titleMoto
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          )),
    );
  }
}
