import 'package:debbydebs/core/models/debt.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

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
        db.execute(
          "CREATE TABLE debts(id INTEGER PRIMARY KEY, name TEXT, description TEXT, contactId INTEGER, amount REAL, isPaid INTEGER)",
        );
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

  Future<Contact?> getContact(int id) async {
    checkDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Contact(id: maps[0]['id'], name: maps[0]['name']);
    }
    return null;
  }

  Future<void> insertDebt(Debt debt) async {
    checkDatabase();
    await _database?.insert(
      'debts',
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDebt(Debt debt) async {
    checkDatabase();
    await _database?.update(
      'debts',
      debt.toMap(),
      where: 'id = ?',
      whereArgs: [debt.id],
    );
  }

  Future<void> deleteDebt(String id) async {
    checkDatabase();
    await _database?.delete('debts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Debt>> getDebts() async {
    checkDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query('debts');
    return List.generate(maps.length, (i) {
      return Debt(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        contactId: maps[i]['contactId'],
        amount: maps[i]['amount'],
        isPaid: maps[i]['isPaid'] == 1,
      );
    });
  }

  Future<List<Debt>> getDebtsByContactId(int contactId) async {
    checkDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(
      'debts',
      where: 'contactId = ?',
      whereArgs: [contactId],
    );
    return List.generate(maps.length, (i) {
      return Debt(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        contactId: maps[i]['contactId'],
        amount: maps[i]['amount'],
        isPaid: maps[i]['isPaid'] == 1,
      );
    });
  }

  Future<void> checkDatabase() async {
    if (_database == null) {
      await initializeDatabase();
    }
  }
}
