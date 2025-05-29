import "package:debbydebs/core/models/debt.dart";
import "package:debbydebs/core/models/debt_dto.dart";
import "package:debbydebs/core/persistence/debt_database_handler.dart";
import "package:flutter/cupertino.dart";

class DebtProvider extends ChangeNotifier {
  factory DebtProvider() => _instance;
  DebtProvider._internal();
  static final DebtProvider _instance = DebtProvider._internal();

  final DebtDatabaseHandler _debtDatabaseHandler = DebtDatabaseHandler();

  Future<void> deleteDebt(final Debt debt) async {
    await _debtDatabaseHandler.deleteDebt(debt);
    notifyListeners();
  }

  Future<List<Debt>> getAllDebts() async {
    final List<Debt> debts = await _debtDatabaseHandler.getAllDebts();
    return debts;
  }

  Future<void> insertDebt(final Debt debt) async {
    await _debtDatabaseHandler.insertDebt(debt);
    notifyListeners();
  }

  Future<void> insertDebtDTO(final DebtDTO debt) async {
    await _debtDatabaseHandler.insertDebtDTO(debt);
    notifyListeners();
  }
}
