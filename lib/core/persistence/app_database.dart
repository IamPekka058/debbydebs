import "package:sqflite/sqflite.dart";

class AppDatabase {
  factory AppDatabase() => _instance;

  AppDatabase._internal();
  Database? _database;

  static final AppDatabase _instance = AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final Database db = await openDatabase(
      "app.db",
      version: 1,
      onCreate: _onCreate,
    );

    return db;
  }

  Future<void> _onCreate(final Database db, final int version) async {
    await db.execute(
      "CREATE TABLE debts(id INTEGER PRIMARY KEY, name TEXT, description TEXT, contactId INTEGER, amount REAL, isPaid INTEGER)",
    );
    await db.execute(
      "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT)",
    );
  }
}
