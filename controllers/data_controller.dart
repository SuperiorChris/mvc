import 'package:postgres/postgres.dart';
import '../models/data_model.dart';

class DataController {
  static Future<PostgreSQLConnection> getConnection() async {
    var connection = PostgreSQLConnection(
      'your_host',
      5432,
      'db_spirit',
      username: 'your_user',
      password: 'your_password',
    );
    await connection.open();
    return connection;
  }

  static Future<List<DataModel>> fetchData() async {
    List<DataModel> dataList = [];
    final connection = await getConnection();

    try {
      List<List<dynamic>> results = await connection.query('SELECT * FROM data_table');

      for (var row in results) {
        dataList.add(DataModel.fromMap({
          'id': row[0],
          'name': row[1],
          'description': row[2],
        }));
      }
    } catch (e) {
      // Manejo de errores
    } finally {
      await connection.close();
    }

    return dataList;
  }

  static Future<void> insertData(DataModel data) async {
    final connection = await getConnection();

    try {
      await connection.query(
        'INSERT INTO data_table (name, description) VALUES (@name, @description)',
        substitutionValues: {'name': data.name, 'description': data.description},
      );
    } catch (e) {
      // Manejo de errores
    } finally {
      await connection.close();
    }
  }

  static Future<void> updateData(DataModel data) async {
    final connection = await getConnection();

    try {
      await connection.query(
        'UPDATE data_table SET name = @name, description = @description WHERE id = @id',
        substitutionValues: {'id': data.id, 'name': data.name, 'description': data.description},
      );
    } catch (e) {
      // Manejo de errores
    } finally {
      await connection.close();
    }
  }

  static Future<void> deleteData(int id) async {
    final connection = await getConnection();

    try {
      await connection.query(
        'DELETE FROM data_table WHERE id = @id',
        substitutionValues: {'id': id},
      );
    } catch (e) {
      // Manejo de errores
    } finally {
      await connection.close();
    }
  }
}