import "package:debbydebs/core/models/contact_dto.dart";
import "package:debbydebs/core/persistence/database_handler.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_initicon/flutter_initicon.dart";
import "package:provider/provider.dart";

class ContactCreationTile extends StatefulWidget {
  const ContactCreationTile({required this.onCreate, super.key});
  final Function() onCreate;

  @override
  State<ContactCreationTile> createState() => _ContactCreationTileState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<Function()>.has("onCreate", onCreate));
  }
}

class _ContactCreationTileState extends State<ContactCreationTile> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
    create:
        (_) => ContactCreationTileViewModel(
          onCreate: widget.onCreate,
          controller: controller,
        ),
    child: Consumer<ContactCreationTileViewModel>(
      builder:
          (final context, final model, final value) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: TextField(
                decoration: const InputDecoration(labelText: "Name"),
                controller: controller,
                onChanged: (final value) => model.contactName = value,
              ),
              leading: Initicon(
                text: model.contactName.isNotEmpty ? model.contactName : "?",
              ),
              trailing: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                ),
                onPressed: () {
                  if (model.isContactNameValid) {
                    model.createContact();
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid contact name"),
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
          ),
    ),
  );

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>("controller", controller),
    );
  }
}

class ContactCreationTileViewModel extends ChangeNotifier {
  ContactCreationTileViewModel({
    required this.onCreate,
    required this.controller,
  });
  String _contactName = "";
  TextEditingController controller;
  String get contactName => _contactName;
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final Function() onCreate;

  set contactName(final String name) {
    _contactName = name;
    notifyListeners();
  }

  bool get isContactNameValid => _contactName.isNotEmpty;

  void createContact() {
    if (isContactNameValid) {
      final ContactDTO contact = ContactDTO(name: _contactName);
      _databaseHandler.insertContactDTO(contact);
      onCreate();
      controller.clear();
      _contactName = "";
      notifyListeners();
    }
  }
}
