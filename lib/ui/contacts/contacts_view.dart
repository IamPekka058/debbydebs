import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/ui/contacts/_widgets/contact_creation_tile.dart";
import "package:debbydebs/ui/contacts/_widgets/contact_list_tile.dart";
import "package:debbydebs/ui/contacts/contacts_view_view_model.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
      create: (_) => ContactViewViewModel(),
      child: Consumer<ContactViewViewModel>(
        builder: (final context, final viewModel, final value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (viewModel.errorOccurred) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "You cannot delete this contact because it is linked to a debt.",
                  ),
                  backgroundColor: Colors.red,
                  showCloseIcon: true,
                  duration: Duration(seconds: 2),
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
                  thickness: 2,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.contactsCount,
                    itemBuilder: (final context, final index) {
                      final Contact contact = viewModel.contacts[index];
                      return ContactListTile(
                        contactId: contact.id,
                        contactName: contact.name,
                        onEdit: (_) {},
                        onDelete: viewModel.deleteContact,
                        isSelected:
                            viewModel.selectedContact != null &&
                            viewModel.selectedContact!.id == contact.id,
                        onSelect:
                            () => viewModel.toggleContactSelection(contact),
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
