import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/ui/contacts/contacts_view_model.dart";
import "package:flutter/material.dart";

class ContactViewViewModel extends ChangeNotifier {
  ContactViewViewModel() {
    _contactViewModel
      ..addListener(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      })
      ..getContacts();
  }
  final ContactViewModel _contactViewModel = ContactViewModel();

  List<Contact> get contacts => _contactViewModel.contacts;
  bool _errorOccurred = false;

  Contact? get selectedContact => _contactViewModel.selectedContact;

  int get contactsCount => _contactViewModel.contacts.length;
  bool get errorOccurred => _errorOccurred;

  void toggleContactSelection(final Contact contact) {
    _contactViewModel.toggleContactSelection(contact);
  }

  void addContact(final Contact contact) {
    _contactViewModel.addContact(contact);
  }

  void removeContact(final Contact contact) {
    _contactViewModel.removeContact(contact);
  }

  void getContacts() {
    _contactViewModel.getContacts();
  }

  Future<void> deleteContact(final int contactId) async {
    _errorOccurred = await _contactViewModel.deleteContactById(contactId);
    notifyListeners();

    if (_errorOccurred) {
      Future.delayed(const Duration(seconds: 5)).then((_) {
        resetError();
      });
    }
  }

  void resetError() {
    _errorOccurred = false;
    notifyListeners();
  }
}
