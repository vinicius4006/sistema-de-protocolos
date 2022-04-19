class Protocolo {
  int? id;
  String? motorista;
  String? veiculo;
  String? dataInicio;
  String? dataFinal;

  Protocolo(
      {this.id, this.motorista, this.veiculo, this.dataInicio, this.dataFinal});

  Protocolo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    motorista = json['motorista'];
    veiculo = json['veiculo'];
    dataInicio = json['dataInicio'];
    dataFinal = json['dataFinal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['motorista'] = motorista;
    data['veiculo'] = veiculo;
    data['dataInicio'] = dataInicio;
    data['dataFinal'] = dataFinal;
    return data;
  }
}