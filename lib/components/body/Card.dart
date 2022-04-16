import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class CardForm extends StatefulWidget {
   const CardForm({ Key? key, 
   required this.title, 
   required this.op1,
   required this.op2,
   required this.op3,
   required this.op4,  }) : super(key: key);

  final String title;
  final String op1;
  final String op2;
  final String op3;
  final String op4;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {

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
  
  @override
  Widget build(BuildContext context) {
    return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   ListTile(
                   
                    title: Text(widget.title),
                    subtitle: const Text('Status'),

                  ),
                  Container(
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selected = x;
                        });
                      },
                      options:  [widget.op1, widget.op2, widget.op3, widget.op3],
                      selectedValues: selected,
                      whenEmpty: 'Selecione a opção',
                    ),
                  ),
                  
                  
                  Container(
                    alignment: Alignment.center,
                    child: FutureBuilder<Widget>(
                      future: getImage(),
                      builder: (context, snapshot){
                        if(snapshot.hasData) {
                          return Container(child: snapshot.data);
                        } else {
                          return const Text('Carregando...');
                        }
                      },
                    ),
                  ),
                 
                ]),
            );
  }
}