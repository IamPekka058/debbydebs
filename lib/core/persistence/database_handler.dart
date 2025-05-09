import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Database? _database;

  static final DatabaseHandler _instance = DatabaseHandler._internal();

  DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _instance;
  }

  Database? get database => _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'app.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE debts(id INTEGER PRIMARY KEY, name TEXT, description TEXT, contactId INTEGER, amount REAL, isPaid INTEGER)",
        );
        return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
    );
  }
}
