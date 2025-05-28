import 'package:debbydebs/core/models/contact.dart';
import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;
  Contact? _selectedContact;

  Contact? get selectedContact => _selectedContact;
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  void toggleContactSelection(Contact contact) {
    if (_selectedContact != null && _selectedContact!.id == contact.id) {
      _selectedContact = null;
    } else {
      _selectedContact = contact;
    }
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  void clearContacts() {
    _contacts.clear();
    notifyListeners();
  }

  void getContacts() async {
    List<Contact> contacts = await _databaseHandler.getAllContacts();
    _contacts = contacts;
    notifyListeners();
  }

  /// Tries to delete a contact by its ID.
  ///
  /// Returns `false` if the contact was deleted successfully, `true` otherwise.
  Future<bool> deleteContactById(int contactId) async {
    bool unsafeToDelete = true;
    if (await _databaseHandler.safeToDeleteContact(contactId)) {
      _contacts.removeWhere((contact) => contact.id == contactId);
      _databaseHandler.deleteContactById(contactId);
      unsafeToDelete = false;
    }

    notifyListeners();
    return unsafeToDelete;
  }
}
