import 'package:flutter/material.dart';

class CriarProtocolo extends StatefulWidget {
  const CriarProtocolo({ Key? key }) : super(key: key);

  @override
  State<CriarProtocolo> createState() => _CriarProtocoloState();
}

class _CriarProtocoloState extends State<CriarProtocolo> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      static const List<String> _kOptions = <String>[
    'José',
    'João',
    'Mauro',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: (){Navigator.of(context).pop();}, 
            icon: const Icon(Icons.arrow_back_outlined)
          
            );
        }),
        centerTitle: true,
        title: const Text('Criação de Protocolo'),
      ),
      
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Autocomplete<String>(
              optionsBuilder: ((textEditingValue) {
              if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
            } 
            ),
            onSelected: (String selection) {
              debugPrint(selection);
            },
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){

              }
            }, child: const Text('Criar'),),)
          ],
        ))
    );
  }
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