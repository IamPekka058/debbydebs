import 'package:debbydebs/core/models/debt.dart';
import 'package:debbydebs/core/persistence/database_controller.dart';
import 'package:sqflite/sqflite.dart';

class DebtDatabaseHandler extends DataBaseHandler<Debt> {
  @override
  Future<void> delete(Debt data) async {
    checkDatabase();
    await database?.delete('debts', where: 'id = ?', whereArgs: [data.id]);
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<List<Debt>> getAll() async {
    checkDatabase();
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

  @override
  Future<Debt?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> insert(Debt data) async {
    checkDatabase();
    await database?.insert(
      'debts',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(Debt data) async {
    checkDatabase();
    await database?.update(
      'debts',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<List<Debt>> getDebtsByContactId(int contactId) async {
    checkDatabase();
    final List<Map<String, dynamic>> maps = await database!.query(
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
}
