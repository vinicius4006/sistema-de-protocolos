class Protocolo {
  String? digitador;
  String? digitadorFinal;
  String? fim;
  String? id;
  String? inicio;
  String? motorista;
  String? nomemotorista;
  String? observacao;
  String? observacaoFinal;
  String? placa;
  String? veiculo;

  Protocolo(
      {this.digitador,
      this.digitadorFinal,
      this.fim,
      this.id,
      this.inicio,
      this.motorista,
      this.nomemotorista,
      this.observacao,
      this.observacaoFinal,
      this.placa,
      this.veiculo});

  Protocolo.fromJson(Map<String, dynamic> json) {
    digitador = json['digitador'];
    digitadorFinal = json['digitador_final'];
    fim = json['fim'];
    id = json['id'];
    inicio = json['inicio'];
    motorista = json['motorista'];
    nomemotorista = json['nomemotorista'];
    observacao = json['observacao'];
    observacaoFinal = json['observacao_final'];
    placa = json['placa'];
    veiculo = json['veiculo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['digitador'] = digitador;
    data['digitador_final'] = digitadorFinal;
    data['fim'] = fim;
    data['id'] = id;
    data['inicio'] = inicio;
    data['motorista'] = motorista;
    data['nomemotorista'] = nomemotorista;
    data['observacao'] = observacao;
    data['observacao_final'] = observacaoFinal;
    data['placa'] = placa;
    data['veiculo'] = veiculo;
    return data;
  }
}