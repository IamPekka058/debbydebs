import 'package:debbydebs/core/models/contact_dto.dart';
import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:provider/provider.dart';

class ContactCreationTile extends StatefulWidget {
  const ContactCreationTile({super.key, required this.onCreate});
  final Function() onCreate;

  @override
  State<ContactCreationTile> createState() => _ContactCreationTileState();
}

class _ContactCreationTileState extends State<ContactCreationTile> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => ContactCreationTileViewModel(
            onCreate: widget.onCreate,
            controller: controller,
          ),
      child: Consumer<ContactCreationTileViewModel>(
        builder: (context, model, value) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: TextField(
                decoration: InputDecoration(labelText: "Name"),
                controller: controller,
                onChanged: (String value) => model.contactName = value,
              ),
              leading: Initicon(
                text: model.contactName.isNotEmpty ? model.contactName : '?',
              ),
              trailing: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                ),
                onPressed: () {
                  if (model.isContactNameValid) {
                    model.createContact();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid contact name'),
                      ),
                    );
                  }
                },
                label: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 25,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ContactCreationTileViewModel extends ChangeNotifier {
  String _contactName = '';
  TextEditingController controller;
  String get contactName => _contactName;
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final Function onCreate;

  ContactCreationTileViewModel({
    required this.onCreate,
    required this.controller,
  });

  set contactName(String name) {
    _contactName = name;
    notifyListeners();
  }

  bool get isContactNameValid => _contactName.isNotEmpty;

  void createContact() {
    if (isContactNameValid) {
      ContactDTO contact = ContactDTO(name: _contactName);
      _databaseHandler.insertContactDTO(contact);
      onCreate();
      controller.clear();
      _contactName = '';
      notifyListeners();
    }
  }
}
