import 'package:debbydebs/ui/contacts/_widgets/contact_list_tile.dart';
import 'package:debbydebs/ui/contacts/contacts_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '_widgets/contact_creation_tile.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactViewViewModel(),
      child: Consumer<ContactViewViewModel>(
        builder: (context, model, value) {
          return Scaffold(
            body: Column(
              children: [
                ContactCreationTile(onCreate: model.getContacts),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 5,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = model.contacts[index];
                      return ContactListTile(
                        contactId: contact.id,
                        contactName: contact.name,
                        onEdit: (int id) {},
                        onDelete: (int id) {},
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
