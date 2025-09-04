import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/providers/contact_provider.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_initicon/flutter_initicon.dart";
import "package:provider/provider.dart";

class DebtListTile extends StatefulWidget {
  const DebtListTile({
    required this.id,
    required this.name,
    required this.description,
    required this.contactId,
    required this.amount,
    required this.isPaid,
    required this.onTap,
    required this.onDelete,
    super.key,
  });
  final int id;
  final String name;
  final String description;
  final int contactId;
  final double amount;
  final bool isPaid;
  final Function(int id) onTap;
  final Function(int id) onDelete;

  @override
  State<DebtListTile> createState() => _DebtListTileState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty("id", id))
      ..add(StringProperty("name", name))
      ..add(StringProperty("description", description))
      ..add(IntProperty("contactId", contactId))
      ..add(DoubleProperty("amount", amount))
      ..add(DiagnosticsProperty<bool>("isPaid", isPaid))
      ..add(ObjectFlagProperty<Function(int id)>.has("onTap", onTap))
      ..add(ObjectFlagProperty<Function(int id)>.has("onDelete", onDelete));
  }
}

class _DebtListTileState extends State<DebtListTile> {
  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
    create: (_) => DebtListTileViewModel(contactId: widget.contactId),
    child: Consumer<DebtListTileViewModel>(
      builder:
          (final context, final viewModel, final child) => Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.green,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Mark as Paid", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.check, color: Colors.white),
                ],
              ),
            ),
            onDismissed: (final direction) => widget.onDelete(widget.id),
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
                        if (viewModel.showButtons)
                          const Icon(Icons.arrow_drop_up)
                        else
                          const Icon(Icons.arrow_drop_down),
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
                  if (viewModel.showButtons) const Divider(color: Colors.grey),
                  if (viewModel.showButtons)
                    Padding(
                      padding: const EdgeInsets.all(8),
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
                            child: const Row(
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
                            child: const Row(
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
                            child: const Row(
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
          ),
    ),
  );
}

class DebtListTileViewModel extends ChangeNotifier {
  DebtListTileViewModel({required this.contactId}) {
    getContactName();
  }
  final int contactId;
  bool showButtons = false;

  final ContactProvider _contactProvider = ContactProvider();
  String contactName = "";

  void toggleButtons() {
    showButtons = !showButtons;
    notifyListeners();
  }

  Future<void> getContactName() async {
    final Contact contact = await _contactProvider.getContactById(contactId);
    contactName = contact.name;
    notifyListeners();
  }
}
