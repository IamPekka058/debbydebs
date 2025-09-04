import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/models/debt.dart";
import "package:debbydebs/core/providers/contact_provider.dart";
import "package:debbydebs/core/providers/debt_provider.dart";
import "package:flutter/cupertino.dart";

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    DebtProvider().addListener(getAllDebts);
    getAllDebts();
  }
  final List<Debt> _debts = [];
  List<Debt> get debts => _debts;
  final DebtProvider _debtProvider = DebtProvider();
  final ContactProvider _contactProvider = ContactProvider();

  void addDebt(final Debt debt) {
    _debtProvider.insertDebt(debt);
    _debts.add(debt);
    notifyListeners();
  }

  void removeDebt(final Debt debt) {
    _debtProvider.deleteDebt(debt);
    _debts.remove(debt);
    notifyListeners();
  }

  Future<void> getAllDebts() async {
    final List<Debt> debts = await _debtProvider.getAllDebts();
    _debts
      ..clear()
      ..addAll(debts);
    notifyListeners();
  }

  Future<String> getContactName(final int contactId) async {
    final Contact contact = await _contactProvider.getContactById(contactId);
    return contact.name;
  }
}
