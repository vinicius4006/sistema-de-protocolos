class Placas {
  String? placa;
  String? veiculoId;
  int? id;
  String? observacaoFinal;

  Placas({this.placa, this.veiculoId, this.id});

  Placas.fromJson(Map<String, dynamic> json) {
    placa = json['placa'];
    veiculoId = json['veiculo'];
    id = int.parse(json['id']);
    observacaoFinal = json['observacao_final'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placa'] = this.placa;
    data['veiculo'] = this.veiculoId;
    data['id'] = this.id;
    data['observacao_final'] = this.observacaoFinal;
    return data;
  }
}
