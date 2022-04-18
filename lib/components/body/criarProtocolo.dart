
import 'package:flutter/material.dart';
import 'package:protocolo_app/components/body/formCarro.dart';
import 'package:protocolo_app/components/body/formMoto.dart';
import 'package:protocolo_app/components/models/protocolo_model.dart';
import 'package:dropdownfield2/dropdownfield2.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({Key? key}) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProtocoloModelo protocoloModelo = ProtocoloModelo();

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
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
             // mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  <Widget>[
                const SizedBox(height: 20.0,),
                const Text('Motoristas', 
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0,),
                DropDownField(
                  controller: motoristaSelecionar,
                  hintText: 'Selecione o Motorista',
                  enabled: true,
                  items: motoristas,
                  itemsVisibleInDropdown: 5,
                  
                  onValueChanged: (value){
                    setState(() {
                      motoristaSelecionado = value;
                    });
                  },
                  required: true,
                ),
                const SizedBox(height: 20.0,),
                Text(motoristaSelecionado, style: const TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                const Text('Veículos', 
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0,),
                DropDownField(
                  controller: veiculoSelecionar,
                  hintText: 'Selecione o Veículo',
                  enabled: true,
                  required: true,
                  items: veiculos,
                  itemsVisibleInDropdown: 5,
                  onValueChanged: (value){
                    setState(() {
                      veiculoSelecionado = value;
                    });
                  },
                ),
                const SizedBox(height: 20.0,),

                Text(veiculoSelecionado, style: const TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                
                const SizedBox(height: 20.0,),

           
            (veiculoSelecionado == 'NDR1600')  ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: CarroForm(),
            ) : (veiculoSelecionado == 'CNH1981') ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: MotoForm(),
            ) : const Text(''),


              Padding(padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: const ButtonStyle(),
                onPressed: (){if(_formKey.currentState!.validate()){
                  debugPrint('$motoristaSelecionado $veiculoSelecionado $now');
                }},
                child: const Text('Criar'),
              ),)
        
              ],
            ),
          ),
        ));
  }
  


  // Widget _uiWidget() {
  //   return Form(
  //     key: _formKey,
  //     child: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Column(
  //           children: [
  //             FormHelper.inputFieldWidgetWithLabel(
  //                 context, 
                  
  //                 'motorista', 
  //                 'Motorista', 
  //                 '', 
  //                 (onValidateVal){
  //                   if(onValidateVal.isEmpty){
  //                     return 'Motorista não pode estar vazio';
  //                   }
  //                   return null;
  //                 },
  //                  (onSavedVal){
  //                    protocoloModelo.motorista = onSavedVal;
  //                  },
  //                  initialValue: protocoloModelo.motorista ?? '',
  //                  borderColor: Colors.greenAccent,
  //                  borderFocusColor: Colors.greenAccent,
  //                  borderRadius: 2,
  //                  fontSize: 14,
  //                  labelFontSize: 14,
  //                  paddingLeft: 0,
  //                  paddingRight: 0
                   

  //                  )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}





// TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Motorista',
//               ),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Selecione o Motorista';
//                 }
//                 return null;
//               },
//             ),

// Autocomplete<String>(
//               optionsBuilder: ((textEditingValue) {
//               if (textEditingValue.text == '') {
//           return const Iterable<String>.empty();
//         }
//         return _kOptions.where((String option) {
//           return option.contains(textEditingValue.text.toLowerCase());
//         });
//             } 
//             ),
//             onSelected: (String selection) {
//               debugPrint(selection);
//             },
//             ),


// Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Motorista',
//               ),
//               validator: (String? value){
//                 if (value == null || value.isEmpty){
//                   return 'Selecione o Motorista';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(),
//             TextFormField(),
//             const Text('Formulário do Veículo'),
         
//             Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(onPressed: (){
//               if(_formKey.currentState!.validate()){

//               }
//             }, child: const Text('Criar'),),)
//           ],
//         ))