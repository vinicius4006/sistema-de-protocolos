
import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/Card.dart';

class MotoForm extends StatefulWidget {
  const MotoForm({Key? key}) : super(key: key);

  @override
  State<MotoForm> createState() => _MotoFormState();
}



List<String> selected = [];

class _MotoFormState extends State<MotoForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: const <Widget>[
              Text('Formulário de Moto', style: TextStyle(height: 1, fontSize: 30), ),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                title: 'Buzina',
                op1: 'Barulho Baixo',
                op2: 'Som estranho',
                op3: 'Som de animal',
                op4: 'Não presta',
              ),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Retrovisor - Direito/Esquerdo',
                  op1: 'Rasgado',
                  op2: 'Fino demais',
                  op3: 'Couro duro',
                  op4: 'Estranho'),
              SizedBox(
                height: 20.0,
              ),
             
              
              
              CardForm(
                  title: 'Farol Baixo',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Farol Alto',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
             
              CardForm(
                  title: 'Luz De Freio',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
             
             
              CardForm(
                  title: 'Luzes Do Painel',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Setas Dianteiras',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Setas Traseiras',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              
              CardForm(
                  title: 'Velocímetro / Tacógrafo',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Freios',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              
             
              
              CardForm(
                  title: 'Pneus (Estado)',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
            
              CardForm(
                  title: 'Pneus (Calibragem)',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
             
              CardForm(
                  title: 'Nível combustível',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              
            ],
          )),
    );
  }
}
