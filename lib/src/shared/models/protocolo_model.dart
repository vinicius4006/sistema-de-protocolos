import 'package:flutter/cupertino.dart';

class ProtocoloModelo extends ChangeNotifier{
  String? motorista;
  String? veiculo;
  List<dynamic>? formCarro;
  List<dynamic>? formMoto;

  ProtocoloModelo({this.motorista, this.veiculo, this.formCarro, this.formMoto});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};


    data['Motorista'] = motorista;
    data['Veículo'] = veiculo;
    data['Carro'] = formCarro;
    data['Moto'] = formMoto;


    return data; 
  }
}