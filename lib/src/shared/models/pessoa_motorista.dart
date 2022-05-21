class Pessoa {
  String? nome;
  String? id;

  Pessoa({this.nome, this.id});

  Pessoa.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id'] = this.id;
    return data;
  }
}
