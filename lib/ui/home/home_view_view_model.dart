import "package:debbydebs/core/models/debt.dart";
import "package:debbydebs/ui/home/home_view_model.dart";
import "package:flutter/material.dart";

class HomeViewViewModel extends ChangeNotifier {
  HomeViewViewModel() {
    _model
      ..addListener(_onModelChanged)
      ..getAllDebts();
    notifyListeners();
  }
  final HomeViewModel _model = HomeViewModel();
  List<Debt> get debts => _model.debts;
  void _onModelChanged() {
    notifyListeners();
  }

  void addDebt(final Debt debt) {
    _model.addDebt(debt);
  }

  void removeDebt(final Debt debt) {
    _model.removeDebt(debt);
  }
}
