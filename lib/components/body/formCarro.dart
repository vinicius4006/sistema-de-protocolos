import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

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
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                   
                    title: Text('Buzina'),
                    subtitle: Text('Status'),

                  ),
                  Container(
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selected = x;
                        });
                      },
                      options: const ['Funcionando', 'Pouco som', 'Nenhum som', 'Barulho de peixe'],
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
            ),
            const SizedBox(height: 20.0,),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                   
                    title: Text('Cinto de Segurança'),
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
            ),
            const SizedBox(height: 20.0,),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                   
                    title: Text('Quebra Sol'),
                    subtitle: Text('Status'),

                  ),
                  Container(
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selected = x;
                        });
                      },
                      options: const ['Funcionando', 'Sem sol', 'Danificado', 'Estragado'],
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
            )
          ],
        ));
     
    
   
  }
}