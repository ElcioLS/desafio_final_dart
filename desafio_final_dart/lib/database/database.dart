import 'package:mysql1/mysql1.dart';

class Database {
  final urlEstados =
      'http://servicodados.ibge.gov.br/api/v1/localidades/estados';

  final urlDistritos =
      'http://servicodados.ibge.gov.br/api/v1/localidades/estados/31/distritos';
  final MySqlConnection _conn;

  Database({required connection}) : _conn = connection;

  static Future<MySqlConnection> openConnection() async {
    final settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: '12346',
        db: 'desafio_final');

    final connection = await MySqlConnection.connect(settings);
    return connection;
  }

  MySqlConnection get conn => _conn;
}
