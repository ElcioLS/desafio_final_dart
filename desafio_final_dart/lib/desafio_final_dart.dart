import 'dart:developer';

import 'package:desafio_final_dart/database/database.dart';
import 'package:desafio_final_dart/models/estado.dart';
import 'package:desafio_final_dart/repositories/cidade_repository.dart';
import 'package:desafio_final_dart/repositories/estado_repository.dart';

Future<void> main(List<String> args) async {
  var conn = await Database.openConnection();
  var estadoRepository = EstadoRepository(connection: conn);

  log('Buscando estados...');
  List<Estado> estados = await estadoRepository.fetchAll();

  log('Salvando todos estados...');
  try {
    var estadosSave = await estadoRepository.saveAll(estados);
    estadosSave;
  } catch (e) {
    print('ocorreu um erro ao salvar estados');
  }

  log('Buscando cidades...');
  var cidadeRepository = CidadeRepository(connection: conn);
  // List<Cidade> cidade = await cidadeRepository.fetchAll();

  log('Salvando cidades de Roraima');
  final rr = estados.where((estado) => estado.sigla == 'RR').first;
  await cidadeRepository.fetchByIdEstado(rr);
}
