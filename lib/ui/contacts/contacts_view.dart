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
        builder: (context, viewModel, value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (viewModel.errorOccurred) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'You cannot delete this contact because it is linked to a debt.',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              viewModel.resetError();
            }
          });
          return Scaffold(
            body: Column(
              children: [
                ContactCreationTile(onCreate: viewModel.getContacts),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 5,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.contactsCount,
                    itemBuilder: (context, index) {
                      final contact = viewModel.contacts[index];
                      return ContactListTile(
                        contactId: contact.id,
                        contactName: contact.name,
                        onEdit: (int id) {},
                        onDelete: (int id) => viewModel.deleteContact(id),
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
