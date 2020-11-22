import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.nome,
    this.email,
    this.aniversario,
    this.senha,
    this.imagem,
  });

  final String id;
  final String nome;
  final String email;
  final String aniversario;
  final String senha;
  final String imagem;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"] == null ? null : json["_id"],
        nome: json["nome"] == null ? null : json["nome"],
        email: json["email"] == null ? null : json["email"],
        aniversario: json["aniversario"] == null ? null : json["aniversario"],
        senha: json["senha"] == null ? null : json["senha"],
        imagem: json["imagem"] == null ? null : json["imagem"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "nome": nome == null ? null : nome,
        "email": email == null ? null : email,
        "aniversario": aniversario == null ? null : aniversario,
        "senha": senha == null ? null : senha,
        "imagem": imagem == null ? null : imagem,
      };

  Map<String, dynamic> toJsonWithoutPass() => {
        "nome": nome == null ? null : nome,
        "email": email == null ? null : email,
        "aniversario": aniversario == null ? null : aniversario,
        "senha": senha == null ? null : senha,
        "imagem": imagem == null ? null : imagem,
      };
  Map<String, dynamic> toJsonWithoutId() => {
        "nome": nome == null ? null : nome,
        "email": email == null ? null : email,
        "aniversario": aniversario == null ? null : aniversario,
        "senha": senha == null ? null : senha,
        "imagem": imagem == null ? null : imagem,
      };

  static List<UserModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map<UserModel>((item) => UserModel.fromJson(item)).toList();
  }
}
