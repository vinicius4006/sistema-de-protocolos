import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class CardForm extends StatefulWidget {
  const CardForm({ Key? key, required this.title }) : super(key: key);

  final String title;

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
                  const ListTile(
                   
                    title: Text('title'),
                    subtitle: Text('Status'),

                  ),
                  Container(
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selected = x;
                        });
                      },
                      options: const ['Funcionando', 'Faltando elasticidade', 'Couro duro', 'Rasgado'],
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