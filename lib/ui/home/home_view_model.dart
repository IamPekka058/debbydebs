import 'package:debbydebs/core/models/debt.dart';
import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Debt> _debts = [];
  List<Debt> get debts => _debts;
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  void addDebt(Debt debt) {
    _databaseHandler.insertDebt(debt);
    _debts.add(debt);
    notifyListeners();
  }

  void removeDebt(Debt debt) {
    _databaseHandler.deleteDebt(debt.id);
    _debts.remove(debt);
    notifyListeners();
  }

  void getAllDebts() async {
    final List<Debt> debts = await _databaseHandler.getDebts();
    _debts.clear();
    _debts.addAll(debts);
    notifyListeners();
  }
}
