class Usuario {
  String nome;
  String senha;

  Usuario({this.nome, this.senha});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['senha'] = this.senha;
    return data;
  }
}
