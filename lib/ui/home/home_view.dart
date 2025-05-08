import 'package:debbydebs/core/models/debt.dart';
import 'package:debbydebs/ui/home/home_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Debts:"),
        ChangeNotifierProvider(
          create: (_) => HomeViewViewModel(),
          child: Consumer<HomeViewViewModel>(
            builder: (context, model, child) {
              return Column(
                children: [
                  FilledButton(
                    onPressed:
                        () => model.addDebt(
                          Debt(
                            id: 1,
                            name: "Hola",
                            description: "description",
                            contactId: 1,
                            amount: 10.50,
                            isPaid: false,
                          ),
                        ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.debts.length,
                      itemBuilder: (context, index) {
                        final debt = model.debts[index];
                        return ListTile(
                          title: Text(debt.name),
                          subtitle: Text(debt.amount.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              model.removeDebt(debt);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
