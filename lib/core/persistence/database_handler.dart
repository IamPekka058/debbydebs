import 'package:debbydebs/core/models/contact.dart';
import 'package:debbydebs/core/models/debt.dart';
import 'package:debbydebs/core/models/debt_dto.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler extends ChangeNotifier {
  Database? _database;

  static final DatabaseHandler _instance = DatabaseHandler._internal();

  DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _instance;
  }

  Database? get database => _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      version: 1,
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

  Future<void> insertDebt(Debt debt) async {
    insertDebtDTO(
      DebtDTO(
        name: debt.name,
        description: debt.description,
        contactId: debt.contactId,
        amount: debt.amount,
        isPaid: debt.isPaid,
      ),
    );
  }

  Future<void> insertDebtDTO(DebtDTO debt) async {
    await checkDatabase();
    await _database?.insert(
      'debts',
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    notifyListeners();
  }

  Future<void> deleteDebt(Debt debt) async {
    await checkDatabase();
    await _database?.delete('debts', where: 'id = ?', whereArgs: [debt.id]);
  }

  Future<List<Debt>> getAllDebts() async {
    await checkDatabase();
    final List<Map<String, dynamic>> maps = await database!.query('debts');
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

  Future<void> insertContact(Contact contact) async {
    await checkDatabase();
    await _database?.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteContact(Contact contact) async {
    await checkDatabase();
    await _database?.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<List<Contact>> getAllContacts() async {
    await checkDatabase();
    final List<Map<String, dynamic>> maps = await database!.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(id: maps[i]['id'], name: maps[i]['name']);
    });
  }

  Future<Contact> getContactById(int id) async {
    await checkDatabase();

    final List<Map<String, dynamic>> maps = await database!.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      throw Exception('Contact not found');
    }
  }
}
