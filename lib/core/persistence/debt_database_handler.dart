import "package:debbydebs/core/models/debt.dart";
import "package:debbydebs/core/models/debt_dto.dart";
import "package:debbydebs/core/persistence/app_database.dart";
import "package:sqflite/sqflite.dart";

class DebtDatabaseHandler {
  factory DebtDatabaseHandler() => _instance;
  DebtDatabaseHandler._internal();

  final AppDatabase _appDatabase = AppDatabase();

  static final DebtDatabaseHandler _instance = DebtDatabaseHandler._internal();

  Future<void> insertDebt(final Debt debt) async {
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

  Future<void> insertDebtDTO(final DebtDTO debt) async {
    final Database db = await _appDatabase.database;
    await db.insert(
      "debts",
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteDebt(final Debt debt) async {
    final Database db = await _appDatabase.database;
    await db.delete("debts", where: "id = ?", whereArgs: [debt.id]);
  }

  Future<List<Debt>> getAllDebts() async {
    final Database db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query("debts");
    return List.generate(
      maps.length,
      (final i) => Debt(
        id: maps[i]["id"],
        name: maps[i]["name"],
        description: maps[i]["description"],
        contactId: maps[i]["contactId"],
        amount: maps[i]["amount"],
        isPaid: maps[i]["isPaid"] == 1,
      ),
    );
  }
}
