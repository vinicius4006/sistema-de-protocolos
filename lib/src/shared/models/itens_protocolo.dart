class ItensProtocolo {
  String? protocolo;
  String? itemveiculo;
  String? valor;
  String? inicio;
  String? imagem;

  ItensProtocolo({this.protocolo, this.itemveiculo, this.valor, this.inicio, this.imagem});

  ItensProtocolo.fromJson(Map<String, dynamic> json) {
    protocolo = json['protocolo'];
    itemveiculo = json['itemveiculo'];
    valor = json['valor'];
    inicio = json['inicio'];
    imagem = json['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['protocolo'] = protocolo;
    data['itemveiculo'] = itemveiculo;
    data['valor'] = valor;
    data['inicio'] = inicio;
    data['imagem'] = imagem;
    return data;
  }
}