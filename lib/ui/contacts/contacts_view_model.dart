import 'package:debbydebs/core/models/contact.dart';
import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;
  final DatabaseHandler _databaseHandler = DatabaseHandler();

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
  /// Returns true if the contact was deleted successfully, false otherwise.
  Future<bool> deleteContactById(int contactId) async {
    bool unsafeToDelete = true;
    if (await _databaseHandler.safeToDeleteContact(contactId)) {
      _contacts.removeWhere((contact) => contact.id == contactId);
      _databaseHandler.deleteContactById(contactId);
      unsafeToDelete = true;
    }

    notifyListeners();
    return unsafeToDelete;
  }
}
