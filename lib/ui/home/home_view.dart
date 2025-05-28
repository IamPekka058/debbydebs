import "package:debbydebs/core/models/debt.dart";
import "package:debbydebs/ui/forms/debt_creation/debt_creation_screen.dart";
import "package:debbydebs/ui/home/_widgets/debt_list_tile.dart";
import "package:debbydebs/ui/home/home_view_view_model.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
    create: (_) => HomeViewViewModel(),
    child: Consumer<HomeViewViewModel>(
      builder:
          (final context, final model, final child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (final context) => DebtCreationScreen(),
                    ),
                  ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.debts.length,
                    itemBuilder: (final context, final index) {
                      final Debt debt = model.debts[index];
                      return DebtListTile(
                        id: debt.id,
                        name: debt.name,
                        description: debt.description,
                        contactId: debt.contactId,
                        amount: debt.amount,
                        isPaid: debt.isPaid,
                        onTap: (final id) => model.removeDebt(debt),
                        onDelete: (final id) => model.removeDebt(debt),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    ),
  );
}
