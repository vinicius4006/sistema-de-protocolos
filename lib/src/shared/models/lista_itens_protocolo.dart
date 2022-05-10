import 'package:protocolo_app/src/shared/models/itens_protocolo.dart';

class ListaItensProtocolo {
  List<ItensProtocolo>? itensProtocolo;

  ListaItensProtocolo({this.itensProtocolo});

  ListaItensProtocolo.fromJson(Map<String, dynamic> json) {
    if (json['itensProtocolo'] != null) {
      itensProtocolo = <ItensProtocolo>[];
      json['itensProtocolo'].forEach((v) {
        itensProtocolo!.add(ItensProtocolo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (itensProtocolo != null) {
      data['itensProtocolo'] =
          itensProtocolo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}