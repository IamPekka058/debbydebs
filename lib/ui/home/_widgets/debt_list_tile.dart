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
          return ListTile(
            textColor: Colors.black,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Initicon(text: viewModel.contactName, size: 30),
                Text(viewModel.contactName),
              ],
            ),
            title: Text(widget.name),
            subtitle: Text(widget.description),
            trailing: Text(
              widget.amount.toString(),
              style: TextStyle(
                fontSize: 20,
                color: widget.amount > 0 ? Colors.green : Colors.red,
              ),
            ),
            onTap: () {
              widget.onTap(widget.id);
            },
          );
        },
      ),
    );
  }
}

class DebtListTileViewModel extends ChangeNotifier {
  final int contactId;
  DatabaseHandler databaseHandler = DatabaseHandler();
  String contactName = "";
  DebtListTileViewModel({required this.contactId}) {
    getContactName();
  }

  void getContactName() async {
    final contact = await databaseHandler.getContactById(contactId);
    contactName = contact.name;
    notifyListeners();
  }
}
