import 'dart:convert';
import 'dart:developer';

import 'package:desafio_final_dart/database/database.dart';
import 'package:desafio_final_dart/models/cidade.dart';
import 'package:desafio_final_dart/models/estado.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';

class CidadeRepository extends Database {
  CidadeRepository({required super.connection});

  fetchByIdEstado(Estado estado) async {
    try {
      final response =
          await http.get(Uri.parse('$urlEstados/${estado.id}/distritos'));

      if (response.statusCode == 200) {
        List<Cidade> cidades = jsonDecode(response.body)
            .map<Cidade>((cidade) => Cidade(
                  idUf: estado.id,
                  nome: cidade['nome'],
                ))
            .toList();

        log('Salvar as cidades do estado selecionado ${estado.nome}');
        await saveAll(cidades);
      } else {
        throw Exception('Erro ao buscar cidades');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  Future<void> saveAll(List<Cidade> cidades) async {
    try {
      for (var cidade in cidades) {
        log('Salva cidade: ${cidade.nome}');
        await _save(cidade);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _save(Cidade cidade) async {
    try {
      await conn.transaction((_) async {
        await conn.query(
          'INSERT INTO cidade (id_uf, nome) VALUES(?,?)',
          [cidade.idUf, cidade.nome],
        );
      });
    } on MySqlConnection catch (e) {
      print('Erro ao inserir as cidades. $e');
      throw Exception('Erro ao inserir uma cidade $e');
    }
  }

  Future<List<Cidade>> findAll() async {
    try {
      var resultados = await conn.query('SELECT * FROM estado');
      return resultados
          .map<Cidade>((model) => Cidade.fromMap(model as Map<String, dynamic>))
          .toList();
    } on MySqlException catch (e) {
      print('Erro ao inserir estados. $e');
      throw Exception('Erro ao inserir estados. $e');
    }
  }
}
