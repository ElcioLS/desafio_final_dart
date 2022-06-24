import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Estado {
  int id;
  String sigla;
  String nome;

  Estado({
    required this.id,
    required this.sigla,
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sigla': sigla,
      'nome': nome,
    };
  }

  factory Estado.fromMap(Map<String, dynamic> map) {
    return Estado(
      id: map['id'] as int,
      sigla: map['sigla'] as String,
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Estado.fromJson(String source) => Estado.fromMap(json.decode(source));

  @override
  String toString() => 'Estado(id: $id, sigla: $sigla, nome: $nome)';
}
