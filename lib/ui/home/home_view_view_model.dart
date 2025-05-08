import 'package:debbydebs/core/models/debt.dart';
import 'package:debbydebs/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeViewViewModel extends ChangeNotifier {
  final HomeViewModel _model = HomeViewModel();
  List<Debt> get debts => _model.debts;

  HomeViewViewModel() {
    _model.getAllDebts();
  }

  void addDebt(Debt debt) {
    _model.addDebt(debt);
  }

  void removeDebt(Debt debt) {
    _model.removeDebt(debt);
  }
}
