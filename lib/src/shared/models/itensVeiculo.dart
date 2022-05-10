class ItensVeiculos {
  String? id;
  String? descricao;
  String? tipoVeiculo;
  String? parametros;
  String? input;

  ItensVeiculos(
      {this.id, this.descricao, this.tipoVeiculo, this.parametros, this.input});

  ItensVeiculos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tipoVeiculo = json['tipo_veiculo'];
    parametros = json['parametros'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['tipo_veiculo'] = tipoVeiculo;
    data['parametros'] = parametros;
    data['input'] = input;
    return data;
  }
}