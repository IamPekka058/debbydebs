import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/models/debt.dart";
import "package:debbydebs/core/persistence/database_handler.dart";
import "package:flutter/cupertino.dart";

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    DatabaseHandler().addListener(getAllDebts);
    getAllDebts();
  }
  final List<Debt> _debts = [];
  List<Debt> get debts => _debts;
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  void addDebt(final Debt debt) {
    _databaseHandler.insertDebt(debt);
    _debts.add(debt);
    notifyListeners();
  }

  void removeDebt(final Debt debt) {
    _databaseHandler.deleteDebt(debt);
    _debts.remove(debt);
    notifyListeners();
  }

  Future<void> getAllDebts() async {
    final List<Debt> debts = await _databaseHandler.getAllDebts();
    _debts
      ..clear()
      ..addAll(debts);
    notifyListeners();
  }

  Future<String> getContactName(final int contactId) async {
    final Contact contact = await _databaseHandler.getContactById(contactId);
    return contact.name;
  }
}
