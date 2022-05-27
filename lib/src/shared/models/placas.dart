class Placas {
  String? placa;
  String? veiculoId;
  int? id;

  Placas({this.placa, this.veiculoId, this.id});

  Placas.fromJson(Map<String, dynamic> json) {
    placa = json['placa'];
    veiculoId = json['veiculo_id'];
    id = int.parse(json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placa'] = this.placa;
    data['veiculo_id'] = this.veiculoId;
    data['id'] = this.id;
    return data;
  }
}
