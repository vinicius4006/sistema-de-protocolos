import 'package:protocolo_app/src/shared/models/carro.dart';

import 'moto.dart';

class Protocolo {
  int? id;
  String? motorista;
  String? veiculo;
  String? dataInicio;
  String? dataFinal;
  Carro? carro;
  Moto? moto;

  Protocolo(
      {this.id,
      this.motorista,
      this.veiculo,
      this.dataInicio,
      this.dataFinal,
      this.carro,
      this.moto});

      

  Protocolo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    motorista = json['motorista'];
    veiculo = json['veiculo'];
    dataInicio = json['dataInicio'];
    dataFinal = json['dataFinal'];
    carro = json['carro'] != null ? Carro.fromJson(json['carro']) : null;
    moto = json['moto'] != null ? Moto.fromJson(json['moto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['motorista'] = motorista;
    data['veiculo'] = veiculo;
    data['dataInicio'] = dataInicio;
    data['dataFinal'] = dataFinal;
    if (carro != null) {
      data['carro'] = carro!.toJson();
    }

    if (moto != null) {
      data['moto'] = moto!.toJson();
    }
    return data;
  }
}
