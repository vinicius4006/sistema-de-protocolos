class Carro2 {
  String? id;
  String? descricao;
  String? tipoVeiculo;
  String? parametros;
  String? input;

  Carro2(
      {this.id, this.descricao, this.tipoVeiculo, this.parametros, this.input});

  Carro2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tipoVeiculo = json['tipo_veiculo'];
    parametros = json['parametros'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['descricao'] = descricao;
    data['tipo_veiculo'] = tipoVeiculo;
    data['parametros'] = parametros;
    data['input'] = input;
    return data;
  }
}