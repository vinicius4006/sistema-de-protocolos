import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:protocolo_app/components/body/Card.dart';

class CarroForm extends StatefulWidget {
  const CarroForm({ Key? key }) : super(key: key);

  @override
  State<CarroForm> createState() => _CarroFormState();
}
 Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    const url = 'https://picsum.photos/900/600';
    const image = NetworkImage(url);
    // final config = await image.obtainKey();
    final load = image.resolve(const ImageConfiguration());

    final listener = ImageStreamListener((ImageInfo info, isSync) async {
      print(info.image.width);
      print(info.image.height);

      if (info.image.width == 80 && info.image.height == 160) {
        completer.complete(Container(child: const Text('AZAZA')));
      } else {
        completer.complete(Container(child: const Image(image: image)));
      }
    });

    load.addListener(listener);
    return completer.future;
  }
  List<String> selected = [];
class _CarroFormState extends State<CarroForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: const <Widget>[
            CardForm(
              title: 'Buzina',
              op1: 'Barulho Baixo',
              op2: 'Som estranho',
              op3: 'Som de animal',
              op4: 'Não presta',
            ),
            SizedBox(height: 20.0,),

            CardForm(title: 'Cinto de Segurança', 
            op1: 'Rasgado', 
            op2: 'Fino demais', 
            op3: 'Couro duro', 
            op4: 'Estranho')
            
          ],
        ));
     
    
   
  }
}