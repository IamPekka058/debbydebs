import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/models/contact_dto.dart";
import "package:debbydebs/core/persistence/contact_database_handler.dart";
import "package:flutter/material.dart";

class ContactProvider extends ChangeNotifier {
  factory ContactProvider() => _instance;
  ContactProvider._internal();
  static final ContactProvider _instance = ContactProvider._internal();

  final ContactDatabaseHandler _contactDatabaseHandler =
      ContactDatabaseHandler();

  Future<void> deleteContact(final Contact contact) async {
    await _contactDatabaseHandler.deleteContact(contact);
    notifyListeners();
  }

  Future<void> deleteContactById(final int id) async {
    await _contactDatabaseHandler.deleteContactById(id);
    notifyListeners();
  }

  Future<List<Contact>> getAllContacts() async {
    final List<Contact> contacts =
        await _contactDatabaseHandler.getAllContacts();
    return contacts;
  }

  Future<Contact> getContactById(final int id) async {
    final Contact contact = await _contactDatabaseHandler.getContactById(id);
    return contact;
  }

  Future<void> insertContact(final Contact contact) async {
    await _contactDatabaseHandler.insertContact(contact);
    notifyListeners();
  }

  Future<void> insertContactDTO(final ContactDTO contact) async {
    await _contactDatabaseHandler.insertContactDTO(contact);
    notifyListeners();
  }

  Future<bool> safeToDeleteContact(final int contactId) async {
    final bool isSafe = await _contactDatabaseHandler.safeToDeleteContact(
      contactId,
    );
    return isSafe;
  }
}
