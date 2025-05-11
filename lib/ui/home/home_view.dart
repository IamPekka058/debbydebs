import 'package:debbydebs/ui/forms/debt_creation/debt_creation_screen.dart';
import 'package:debbydebs/ui/home/_widgets/debt_list_tile.dart';
import 'package:debbydebs/ui/home/home_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewViewModel(),
      child: Consumer<HomeViewViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add, color: Colors.white),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DebtCreationScreen(),
                    ),
                  ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.debts.length,
                    itemBuilder: (context, index) {
                      final debt = model.debts[index];
                      return DebtListTile(
                        id: debt.id,
                        name: debt.name,
                        description: debt.description,
                        contactId: debt.contactId,
                        amount: debt.amount,
                        isPaid: debt.isPaid,
                        onTap: (int id) => model.removeDebt(debt),
                        onDelete: (int id) => model.removeDebt(debt),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
