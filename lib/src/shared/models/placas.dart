class Placas {
  String? placa;
  String? veiculoId;

  Placas({this.placa, this.veiculoId});

  Placas.fromJson(Map<String, dynamic> json) {
    placa = json['placa'];
    veiculoId = json['veiculo_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placa'] = this.placa;
    data['veiculo_id'] = this.veiculoId;
    return data;
  }
}
