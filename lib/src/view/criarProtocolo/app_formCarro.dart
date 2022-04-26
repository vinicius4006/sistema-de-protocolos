// import 'package:flutter/material.dart';

// import 'package:protocolo_app/src/view/criarProtocolo/app_Card.dart';

// class CarroForm extends StatefulWidget {
//    CarroForm({Key? key, this.tipo}) : super(key: key);

//   int? tipo;
//   @override
//   State<CarroForm> createState() => _CarroFormState();
// }

// List<String> selected = [];



// class _CarroFormState extends State<CarroForm> {

//  @override
//   void initState() {
//     super.initState();
    
//   }



//   @override
//   Widget build(BuildContext context) {
   
//     return SafeArea(
//       child: Container(
//           margin: const EdgeInsets.all(10),
//           child: Form(
//             child: Column(
//               children:  <Widget>[
//                 Text(
//                   widget.tipo.toString(),
//                   style: const TextStyle(height: 1, fontSize: 30),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Buzina',
//                   op1: 'Barulho Baixo',
//                   op2: 'Som estranho',
//                   op3: 'Som de animal',
//                   op4: 'Não presta',
//                   numCat: 0,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Cinto de Segurança',
//                   op1: 'Rasgado',
//                   op2: 'Fino demais',
//                   op3: 'Couro duro',
//                   op4: 'Estranho',
//                   numCat: 1,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Quebra Sol',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 2,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Retrovisor Interno',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 3,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Retrovisor - Direito/Esquerdo',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 4,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Limpador De Pára-Brisa',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 5,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Limpador Pára-Brisa Traseiro',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 6,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Farol Baixo',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 7,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Farol Alto',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 8,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Meia Luz',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 9,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Luz De Freio',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 10,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Luz De Ré',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 11,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Luz Da Placa',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 12,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Luzes Do Painel',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 13,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Setas Dianteiras',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 14,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Setas Traseiras',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 15,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pisca Alerta',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 16,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Luz Interna',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 17,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Velocímetro / Tacógrafo',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 18,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Freios',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 19,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Macaco',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 20,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Chave De Roda',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 21,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Triângulo De Sinalização',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 22,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Extintor De Incêndio',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 23,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Portas - Travas',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 24,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Alarme',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 25,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Fechamento Das Janelas',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 26,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pára-Brisa',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 27,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pneus (Estado)',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 28,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pneu Reserva (Estepe)',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 29,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pneus (Calibragem)',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 30,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Bancos Encosto/Assentos',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 31,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pára-Choque Dianteiro',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 32,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Pára-Choque Traseiro',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 33,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Lataria',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 34,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Nível combustível',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 35,
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 const CardForm(
//                   title: 'Longarina',
//                   op1: 'op1',
//                   op2: 'op2',
//                   op3: 'op3',
//                   op4: 'op4',
//                   numCat: 36,
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
