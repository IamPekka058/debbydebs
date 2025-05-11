import 'package:debbydebs/core/models/debt.dart';
import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Debt> _debts = [];
  List<Debt> get debts => _debts;
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  HomeViewModel() {
    DatabaseHandler().addListener(getAllDebts);
    getAllDebts();
  }

  void addDebt(Debt debt) {
    _databaseHandler.insertDebt(debt);
    _debts.add(debt);
    notifyListeners();
  }

  void removeDebt(Debt debt) {
    _databaseHandler.deleteDebt(debt);
    _debts.remove(debt);
    notifyListeners();
  }

  void getAllDebts() async {
    final List<Debt> debts = await _databaseHandler.getAllDebts();
    _debts.clear();
    _debts.addAll(debts);
    notifyListeners();
  }

  Future<String> getContactName(int contactId) async {
    final contact = await _databaseHandler.getContactById(contactId);
    return contact.name;
  }
}
