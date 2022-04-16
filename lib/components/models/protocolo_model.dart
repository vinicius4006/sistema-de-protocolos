class ProtocoloModelo {
  String? motorista;
  String? veiculo;
  String? observacao;

  ProtocoloModelo({this.motorista, this.veiculo, this.observacao});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();


    data['Motorista'] = motorista;
    data['Veículo'] = veiculo;
    data['Observações'] = observacao;


    return data; 
  }
}