import 'package:debbydebs/core/models/contact.dart';
import 'package:debbydebs/core/persistence/database_controller.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabaseHandler extends DataBaseHandler<Contact> {
  @override
  Future<void> delete(Contact data) async {
    checkDatabase();
    await database?.delete('contacts', where: 'id = ?', whereArgs: [data.id]);
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<List<Contact>> getAll() async {
    checkDatabase();
    List<Map<String, dynamic>> maps = await database!.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(id: maps[i]['id'], name: maps[i]['name']);
    });
  }

  @override
  Future<Contact?> getById(int id) async {
    checkDatabase();
    final List<Map<String, dynamic>> maps = await database!.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Contact(id: maps[0]['id'], name: maps[0]['name']);
    }
    return null;
  }

  @override
  Future<void> insert(Contact data) async {
    checkDatabase();
    await database!.insert(
      'contacts',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(Contact data) async {
    checkDatabase();
    await database!.update(
      'contacts',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }
}
