import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:provider/provider.dart';

class DebtListTile extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final int contactId;
  final double amount;
  final bool isPaid;
  final Function(int id) onTap;
  final Function(int id) onDelete;

  const DebtListTile({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.contactId,
    required this.amount,
    required this.isPaid,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<DebtListTile> createState() => _DebtListTileState();
}

class _DebtListTileState extends State<DebtListTile> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DebtListTileViewModel(contactId: widget.contactId),
      child: Consumer<DebtListTileViewModel>(
        builder: (context, viewModel, child) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.green,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Mark as Paid",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.check, color: Colors.white),
                ],
              ),
            ),
            onDismissed: (direction) => widget.onDelete(widget.id),
            key: Key(widget.id.toString()),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    textColor: Colors.black,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        viewModel.showButtons
                            ? const Icon(Icons.arrow_drop_up)
                            : const Icon(Icons.arrow_drop_down),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Initicon(text: viewModel.contactName, size: 30),
                            Text(viewModel.contactName),
                          ],
                        ),
                      ],
                    ),
                    title: Text(widget.name),
                    subtitle:
                        widget.description.isNotEmpty
                            ? Text(widget.description)
                            : null,
                    trailing: Text(
                      "${widget.amount.toStringAsFixed(2)} €",
                      style: TextStyle(
                        fontSize: 20,
                        color: widget.amount > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                    onTap: viewModel.toggleButtons,
                  ),
                  if (viewModel.showButtons) Divider(color: Colors.grey),
                  if (viewModel.showButtons)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.green,
                              ),
                            ),
                            onPressed: () => widget.onDelete(widget.id),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.paid, color: Colors.white),
                                Text(
                                  "Mark as Paid",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.orange,
                              ),
                            ),
                            onPressed: () => throw UnimplementedError(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.edit, color: Colors.white),
                                Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.red,
                              ),
                            ),
                            onPressed: () => widget.onDelete(widget.id),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DebtListTileViewModel extends ChangeNotifier {
  final int contactId;
  bool showButtons = false;

  DatabaseHandler databaseHandler = DatabaseHandler();
  String contactName = "";
  DebtListTileViewModel({required this.contactId}) {
    getContactName();
  }

  void toggleButtons() {
    showButtons = !showButtons;
    notifyListeners();
  }

  void getContactName() async {
    final contact = await databaseHandler.getContactById(contactId);
    contactName = contact.name;
    notifyListeners();
  }
}
