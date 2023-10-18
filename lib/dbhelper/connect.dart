import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var ditectory = await getApplicationDocumentsDirectory();
    var path = join(ditectory.path, 'db_crud');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
    return database;
  }

  Future<void> _createDatabase(
    Database database,
    int version,
  ) async {
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact TEXT,description TEXT)";
    await database.execute(sql);
  }
}
