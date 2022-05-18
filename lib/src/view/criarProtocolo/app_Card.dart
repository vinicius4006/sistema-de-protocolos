import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:protocolo_app/src/view/criarProtocolo/appCamera.dart';
import 'package:protocolo_app/src/view/criarProtocolo/appCheckOps.dart';
import 'package:protocolo_app/src/view/criarProtocolo/appRadioOps.dart';

class CardForm extends StatefulWidget {
  CardForm(
      {Key? key,
      required this.title,
      required this.ops,
      required this.input,
      required this.color,
      required this.indexGlobal,
      this.numCat = ''})
      : super(key: key);

  final String title;
  final String ops;
  final String input;
  final String numCat;
  final int indexGlobal;
  Color color;

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Dispose CardForm');
    super.dispose();
  }

  Widget getImagemBase64(String imagem) {
    String _imageBase64 = imagem;

    if (imagem.isEmpty || imagem == '') {
      return const Text('Não foi tirado foto alguma');
    } else {
      const Base64Codec base64 = Base64Codec();
      var bytes = base64.decode(_imageBase64);
      return Image.memory(
        bytes,
        width: 500,
        fit: BoxFit.fitWidth,
      );
    }
  }

  //---------------------CORPO DO CARD
  @override
  Widget build(BuildContext context) {
    log('Build CardForm');

    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 8,
        color: Colors.grey[100],
        shadowColor: Theme.of(context).primaryColor,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: widget.color,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: widget.input == 'radio'
                    ? RadioOps(
                        listaParametros: widget.ops, numCat: widget.numCat)
                    : CheckOps(
                        listaParametros: widget.ops,
                        numCat: widget.numCat,
                      )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: Theme.of(context).primaryColor),
                  onPressed: (() {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Camera(
                              input: widget.input, numCat: widget.numCat);
                        });
                  }),
                  child: Text(
                    'Tire a Foto',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
