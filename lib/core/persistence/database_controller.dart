import 'package:sqflite/sqflite.dart';

import 'database_handler.dart';

abstract class DataBaseHandler<T> {
  Database? database = DatabaseHandler().database;
  Future<void> deleteAll();
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<void> insert(T data);
  Future<void> update(T data);
  Future<void> delete(T data);

  Future<void> checkDatabase() async {
    if (database == null) {
      await DatabaseHandler().initializeDatabase();
    }
  }
}
