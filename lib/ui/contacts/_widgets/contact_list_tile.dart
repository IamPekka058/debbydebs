import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:provider/provider.dart';

class ContactListTile extends StatefulWidget {
  final int contactId;
  final String contactName;
  final Function(int id) onEdit;
  final Function(int id) onDelete;

  const ContactListTile({
    super.key,
    required this.contactId,
    required this.onEdit,
    required this.onDelete,
    required this.contactName,
  });

  @override
  State<ContactListTile> createState() => _ContactListTileState();
}

class _ContactListTileState extends State<ContactListTile> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactListTileViewModel(),
      child: Consumer<ContactListTileViewModel>(
        builder: (context, viewModel, child) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  onTap: viewModel.toggleButtons,
                  textColor: Colors.black,
                  leading: Initicon(text: widget.contactName, size: 30),

                  title: Text(widget.contactName),
                  subtitle: Text(widget.contactId.toString()),
                  trailing:
                      viewModel.showButtons
                          ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FilledButton(
                                onPressed:
                                    () => widget.onEdit(widget.contactId),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.grey,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.white),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              FilledButton(
                                onPressed:
                                    () => widget.onDelete(widget.contactId),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.red,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.white),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ContactListTileViewModel extends ChangeNotifier {
  bool showButtons = false;

  void toggleButtons() {
    showButtons = !showButtons;
    notifyListeners();
  }
}
