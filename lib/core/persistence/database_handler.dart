import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Contact.dart';

class DatabaseHandler {
  Database? _database;

  static final DatabaseHandler _instance = DatabaseHandler._internal();

  DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _instance;
  }

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'app.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
    );
  }

  Future<void> insertContact(Contact contact) async {
    checkDatabase();
    await _database?.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateContact(Contact contact) async {
    checkDatabase();
    await _database?.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    checkDatabase();
    await _database?.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Contact>> getContacts() async {
    checkDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(id: maps[i]['id'], name: maps[i]['name']);
    });
  }

  Future<void> checkDatabase() async {
    if (_database == null) {
      await initializeDatabase();
    }
  }
}
