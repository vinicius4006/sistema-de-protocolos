class ListaItensProtocolo {
  List<ItensProtocolo>? listaItensProtocolo;

  ListaItensProtocolo({this.listaItensProtocolo});

  ListaItensProtocolo.fromJson(Map<String, dynamic> json) {
    if (json['listaItensProtocolo'] != null) {
      listaItensProtocolo = <ItensProtocolo>[];
      json['listaItensProtocolo'].forEach((v) {
        listaItensProtocolo!.add(new ItensProtocolo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listaItensProtocolo != null) {
      data['listaItensProtocolo'] =
          this.listaItensProtocolo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItensProtocolo {
  int? protocolo;
  int? itemveiculo;
  dynamic valor;
  bool? inicio;
  String? imagem;

  ItensProtocolo(
      {this.protocolo, this.itemveiculo, this.valor, this.inicio, this.imagem});

  ItensProtocolo.fromJson(Map<String, dynamic> json) {
    protocolo = int.parse(json['protocolo']);
    itemveiculo = int.parse(json['itemveiculo']);
    valor = int.parse(json['valor']);
    inicio = json['inicio'] == 't' ? true : false;
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
