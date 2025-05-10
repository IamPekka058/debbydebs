import 'package:debbydebs/core/models/debt.dart';
import 'package:flutter/cupertino.dart';

import '../../core/persistence/debt_database_handler.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Debt> _debts = [];
  List<Debt> get debts => _debts;
  final DebtDatabaseHandler _databaseHandler = DebtDatabaseHandler();

  HomeViewModel() {
    getAllDebts();
  }

  void addDebt(Debt debt) {
    _databaseHandler.insert(debt);
    _debts.add(debt);
    notifyListeners();
  }

  void removeDebt(Debt debt) {
    _databaseHandler.delete(debt);
    _debts.remove(debt);
    notifyListeners();
  }

  void getAllDebts() async {
    final List<Debt> debts = await _databaseHandler.getAll();
    _debts.clear();
    _debts.addAll(debts);
    notifyListeners();
  }
}
