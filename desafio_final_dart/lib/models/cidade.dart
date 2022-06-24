import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cidade {
  int? id;
  int idUf;
  String nome;

  Cidade({
    this.id,
    required this.idUf,
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUf': idUf,
      'nome': nome,
    };
  }

  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      // id: map['id'] != null ? map['id'] as int : null,
      id: map['idUf']?.toInt(),
      idUf: map['idUf']?.toOnt() ?? 0,
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cidade.fromJson(String source) =>
      Cidade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '''
  Cidade:
    ID Cidade: $id
    ID UF: $idUf
    Nome: $nome  
  ''';
}
