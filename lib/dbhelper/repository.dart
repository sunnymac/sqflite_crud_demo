import '../dbhelper/connect.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //? Insert User
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //? Read all Records
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //? Read a single record by ID
  readDatabyId(table, itemID) async {
    var connection = await database;
    return await connection?.query(
      table,
      where: 'id=?',
      whereArgs: [itemID],
    );
  }

  //? Update User
  updateData(table, data) async {
    var connection = await database;
    return await connection?.update(
      table,
      data,
      where: 'id=?',
      whereArgs: [data['id']],
    );
  }

  //? Delete user

  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete(
      "delete from $table where id=$itemId",
    );
  }
}
