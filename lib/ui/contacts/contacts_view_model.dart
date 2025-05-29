import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/providers/contact_provider.dart";
import "package:flutter/material.dart";

class ContactViewModel extends ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;
  Contact? _selectedContact;

  Contact? get selectedContact => _selectedContact;

  final ContactProvider _contactProvider = ContactProvider();

  void toggleContactSelection(final Contact contact) {
    if (_selectedContact != null && _selectedContact!.id == contact.id) {
      _selectedContact = null;
    } else {
      _selectedContact = contact;
    }
    notifyListeners();
  }

  void addContact(final Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void removeContact(final Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  void clearContacts() {
    _contacts.clear();
    notifyListeners();
  }

  Future<void> getContacts() async {
    final List<Contact> contacts = await _contactProvider.getAllContacts();
    _contacts = contacts;
    notifyListeners();
  }

  /// Tries to delete a contact by its ID.
  ///
  /// Returns `false` if the contact was deleted successfully, `true` otherwise.
  Future<bool> deleteContactById(final int contactId) async {
    bool unsafeToDelete = true;
    if (await _contactProvider.safeToDeleteContact(contactId)) {
      _contacts.removeWhere((final contact) => contact.id == contactId);
      _contactProvider.deleteContactById(contactId);
      unsafeToDelete = false;
    }

    notifyListeners();
    return unsafeToDelete;
  }
}
