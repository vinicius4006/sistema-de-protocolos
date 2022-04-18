
import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/Card.dart';

class CarroForm extends StatefulWidget {
   const CarroForm({Key? key}) : super(key: key);



  @override
  State<CarroForm> createState() => _CarroFormState();
}



List<String> selected = [];

class _CarroFormState extends State<CarroForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: const <Widget>[
              Text('Formulário de Carro', style: TextStyle(height: 1, fontSize: 30), ),
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
                  title: 'Cinto de Segurança',
                  op1: 'Rasgado',
                  op2: 'Fino demais',
                  op3: 'Couro duro',
                  op4: 'Estranho'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Quebra Sol',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Retrovisor Interno',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Retrovisor - Direito/Esquerdo',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Limpador De Pára-Brisa',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Limpador Pára-Brisa Traseiro',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
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
                  title: 'Meia Luz',
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
                  title: 'Luz De Ré',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Luz Da Placa',
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
                  title: 'Pisca Alerta',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Luz Interna',
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
                  title: 'Macaco',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Chave De Roda',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Triângulo De Sinalização',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Extintor De Incêndio',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Portas - Travas',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Alarme',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Fechamento Das Janelas',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Pára-Brisa',
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
                  title: 'Pneu Reserva (Estepe)',
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
                  title: 'Bancos Encosto/Assentos',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Pára-Choque Dianteiro',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Pára-Choque Traseiro',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4'),
              SizedBox(
                height: 20.0,
              ),
              CardForm(
                  title: 'Lataria',
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
              CardForm(
                  title: 'Longarina',
                  op1: 'op1',
                  op2: 'op2',
                  op3: 'op3',
                  op4: 'op4')
            ],
          )),
    );
  }
}
