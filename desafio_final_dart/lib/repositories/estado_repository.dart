import 'dart:convert';
import 'dart:developer';

import 'package:desafio_final_dart/database/database.dart';
import 'package:desafio_final_dart/models/estado.dart';
import 'package:http/http.dart' as http;

class EstadoRepository extends Database {
  EstadoRepository({required super.connection});

  Future<List<Estado>> findAll() async {
    final estadosResponse = await http.get(Uri.parse(urlEstados));
    // await Future.delayed(Duration(seconds: 2));
    final estadosList = jsonDecode(estadosResponse.body);
    return estadosList.map<Estado>((estadoMap) {
      return Estado.fromMap(estadoMap);
    }).toList();
  }

  Future<List<Estado>> fetchAll() async {
    log('Buscando todos os estados...');
    final response = await http.get(Uri.parse(urlEstados));
    final estadosList = jsonDecode(response.body);
    return estadosList.map<Estado>((estadoMap) {
      return Estado.fromMap(estadoMap);
    }).toList();
  }

  Future<void> saveAll(List<Estado> estados) async {
    for (var estado in estados) {
      await _save(estado);
    }
  }

  Future<void> _save(Estado estado) async {
    await conn.transaction((_) async {
      await conn.query(
        'INSERT INTO estado VALUES(?,?,?)',
        [
          estado.id,
          estado.sigla,
          estado.nome,
        ],
      );
    });
  }

  Future<List<int>> pegarIdsEstados() async {
    log('Buscando IDs de todos os estados...');

    var idsEstados = <int>[];

    {
      var resultadoSelect = await conn.query('select id from estado');
      for (var id in resultadoSelect) {
        idsEstados.add(id['id']);
      }
    }

    conn.close();
    return idsEstados;
  }
}
